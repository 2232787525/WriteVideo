//
//  RecordVideoViewController.m
//  KZWeChatSmallVideo_OC
//
//  Created by wangyadong on 2017/8/18.
//  Copyright © 2017年 侯康柱. All rights reserved.
//

#import "RecordVideoViewController.h"

#import "KZVideoSupport.h"
#import "KZVideoConfig.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "KZVideoListViewController.h"

@interface RecordVideoViewController ()<KZControllerBarDelegate,AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate> {
    
    KZStatusBar *_topSlideView;
    
    UIView *_videoView;
    KZFocusView *_focusView;
    UILabel *_statusInfo;
    UILabel *_cancelInfo;
    
    KZControllerBar *_ctrlBar;
    
    AVCaptureSession *_videoSession;
    AVCaptureVideoPreviewLayer *_videoPreLayer;
    AVCaptureDevice *_videoDevice;
    
    AVCaptureVideoDataOutput *_videoDataOut;
    AVCaptureAudioDataOutput *_audioDataOut;
    
    AVAssetWriter *_assetWriter;
    AVAssetWriterInputPixelBufferAdaptor *_assetWriterPixelBufferInput;
    AVAssetWriterInput *_assetWriterVideoInput;
    AVAssetWriterInput *_assetWriterAudioInput;
    CMTime _currentSampleTime;
    BOOL _recoding;
    
    dispatch_queue_t _recoding_queue;
    //      dispatch_queue_create("com.video.queue", DISPATCH_QUEUE_SERIAL)
    
    KZVideoModel *_currentRecord;
    BOOL _currentRecordIsCancel;
}


@end

@implementation RecordVideoViewController
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //子线程做事
        [KZVideoUtil deleteCacheVideo];
    });
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear: animated];
    
    NSString *mediaType = AVMediaTypeVideo;// Or AVMediaTypeAudio
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusDenied){
        //已经拒绝
        [PLGlobalClass aletWithTitle:@"未获得授权使用摄像头" Message:@"请在iOS\"设置-隐私-相机\"中打开。" sureTitle:nil CancelTitle:@"知道了" SureBlock:^{} andCancelBlock:^{
            [self kBackBtnAction];
        } andDelegate:self];
    }else if(authStatus == AVAuthorizationStatusAuthorized){//允许访问
        NSLog(@"Authorized 同意");
        if (TARGET_IPHONE_SIMULATOR)  return;//模拟器
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self focusInPointAtVideoView:CGPointMake(_videoView.bounds.size.width/2, _videoView.bounds.size.height/2)];
        });
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.knavigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //子线程做事
        dispatch_async(dispatch_get_main_queue(), ^{
            //回到主线程修改UI
            [self makeRecordVideo];

        });
    });

    // Do any additional setup after loading the view.
}

-(void)makeRecordVideo{
    UIPanGestureRecognizer *ges = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveTopBarAction:)];
    [self.view addGestureRecognizer:ges];
    
    //录制视频view
    _videoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kzSCREEN_WIDTH,kzSCREEN_HEIGHT)];
    _videoView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_videoView];
    
    //底部控制按钮
    _ctrlBar = [[KZControllerBar alloc] initWithFrame:CGRectMake(0,0,kzSCREEN_WIDTH, 120+KBottomStatusH)];
    [_ctrlBar setupSubViewsWithStyle:KZVideoViewShowTypeSingle];
    _ctrlBar.delegate = self;
    [self.view addSubview:_ctrlBar];
    _ctrlBar.bottom_sd = kzSCREEN_HEIGHT;
    
    //单点聚焦
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(focusAction:)];
    tapGesture.delaysTouchesBegan = YES;
    [_videoView addGestureRecognizer:tapGesture];
    //双击放大
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zoomVideo:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    doubleTapGesture.numberOfTouchesRequired = 1;
    doubleTapGesture.delaysTouchesBegan = YES;
    [_videoView addGestureRecognizer:doubleTapGesture];
    [tapGesture requireGestureRecognizerToFail:doubleTapGesture];
    
    //聚焦方框
    _focusView = [[KZFocusView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    _focusView.backgroundColor = [UIColor clearColor];
    
    //状态lable，上移取消
    _statusInfo = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kzSCREEN_WIDTH, 20)];
    _statusInfo.centerY_sd = kzSCREEN_HEIGHT/2.0;
    _statusInfo.textAlignment = NSTextAlignmentCenter;
    _statusInfo.font = [UIFont systemFontOfSize:14.0];
    _statusInfo.textColor = [UIColor whiteColor];
    _statusInfo.hidden = YES;
    [self.view addSubview:_statusInfo];
    //取消lb
    _cancelInfo = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 24)];
    _cancelInfo.center = _videoView.center;
    _cancelInfo.textAlignment = NSTextAlignmentCenter;
    _cancelInfo.textColor = kzThemeWhiteColor;
    _cancelInfo.backgroundColor = kzThemeWaringColor;
    _cancelInfo.hidden = YES;
    [self.view addSubview:_cancelInfo];

    //video放到最下面
    [self.view sendSubviewToBack:_videoView];
    //设置录制view
    dispatch_async(dispatch_get_main_queue(), ^{
        //回到主线程修改UI
        [self setupVideo];
    });
    
}
- (void)setupVideo {
    NSString *unUseInfo = nil;
    if (TARGET_IPHONE_SIMULATOR) {
        unUseInfo = @"模拟器不可以的..";
    }
    AVAuthorizationStatus videoAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(videoAuthStatus == ALAuthorizationStatusRestricted || videoAuthStatus == ALAuthorizationStatusDenied){
        unUseInfo = @"相机访问受限...";
    }
    AVAuthorizationStatus audioAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if(audioAuthStatus == ALAuthorizationStatusRestricted || audioAuthStatus == ALAuthorizationStatusDenied){
        unUseInfo = @"录音访问受限...";
    }
    if (unUseInfo != nil) {
        _statusInfo.text = unUseInfo;
        _statusInfo.hidden = NO;
        [self.view bringSubviewToFront:_statusInfo];
        return;
    }
    
    _recoding_queue = dispatch_queue_create("com.kzsmallvideo.queue", DISPATCH_QUEUE_SERIAL);
    
    NSArray *devicesVideo = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    NSArray *devicesAudio = [AVCaptureDevice devicesWithMediaType:AVMediaTypeAudio];
    
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:devicesVideo[0] error:nil];
    AVCaptureDeviceInput *audioInput = [AVCaptureDeviceInput deviceInputWithDevice:devicesAudio[0] error:nil];
    
    _videoDevice = devicesVideo[0];
    
    _videoDataOut = [[AVCaptureVideoDataOutput alloc] init];
    _videoDataOut.videoSettings = @{(__bridge NSString *)kCVPixelBufferPixelFormatTypeKey:@(kCVPixelFormatType_32BGRA)};
    _videoDataOut.alwaysDiscardsLateVideoFrames = YES;
    [_videoDataOut setSampleBufferDelegate:self queue:_recoding_queue];
    
    _audioDataOut = [[AVCaptureAudioDataOutput alloc] init];
    [_audioDataOut setSampleBufferDelegate:self queue:_recoding_queue];
    
    _videoSession = [[AVCaptureSession alloc] init];
    if ([_videoSession canSetSessionPreset:AVCaptureSessionPreset1280x720]) {
        //设置显示分辨率
        _videoSession.sessionPreset = AVCaptureSessionPreset1280x720;
    }
    if ([_videoSession canAddInput:videoInput]) {
        [_videoSession addInput:videoInput];
    }
    if ([_videoSession canAddInput:audioInput]) {
        [_videoSession addInput:audioInput];
    }
    if ([_videoSession canAddOutput:_videoDataOut]) {
        [_videoSession addOutput:_videoDataOut];
    }
    if ([_videoSession canAddOutput:_audioDataOut]) {
        [_videoSession addOutput:_audioDataOut];
    }
    
    _videoPreLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_videoSession];
    _videoPreLayer.frame = _videoView.bounds;
    _videoPreLayer.position = CGPointMake(kzSCREEN_WIDTH/2.0, kzSCREEN_HEIGHT/2.0);
    _videoPreLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [_videoView.layer addSublayer:_videoPreLayer];
    [_videoSession startRunning];
    
}

- (void)focusInPointAtVideoView:(CGPoint)point {
    CGPoint cameraPoint= [_videoPreLayer captureDevicePointOfInterestForPoint:point];
    _focusView.center = point;
    [_videoView addSubview:_focusView];
    [_videoView bringSubviewToFront:_focusView];
    [_focusView focusing];
    
    NSError *error = nil;
    if ([_videoDevice lockForConfiguration:&error]) {
        if ([_videoDevice isFocusPointOfInterestSupported]) {
            _videoDevice.focusPointOfInterest = cameraPoint;
        }
        if ([_videoDevice isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            _videoDevice.focusMode = AVCaptureFocusModeAutoFocus;
        }
        if ([_videoDevice isExposureModeSupported:AVCaptureExposureModeAutoExpose]) {
            _videoDevice.exposureMode = AVCaptureExposureModeAutoExpose;
        }
        if ([_videoDevice isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
            _videoDevice.whiteBalanceMode = AVCaptureWhiteBalanceModeAutoWhiteBalance;
        }
        [_videoDevice unlockForConfiguration];
    }
    if (error) {
        NSLog(@"聚焦失败:%@",error);
    }
    kz_dispatch_after(1.0, ^{
        [_focusView removeFromSuperview];
    });
}

#pragma mark - Actions --
- (void)focusAction:(UITapGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView:_videoView];
    [self focusInPointAtVideoView:point];
}

- (void)zoomVideo:(UITapGestureRecognizer *)gesture {
    NSError *error = nil;
    if ([_videoDevice lockForConfiguration:&error]) {
        CGFloat zoom = _videoDevice.videoZoomFactor == 2.0?1.0:2.0;
        _videoDevice.videoZoomFactor = zoom;
        [_videoDevice unlockForConfiguration];
    }
}
- (void)moveTopBarAction:(UIPanGestureRecognizer *)gesture {
    
}

#pragma mark - controllerBarDelegate
- (void)ctrollVideoDidStart:(KZControllerBar *)controllerBar {
    _currentRecord = [KZVideoUtil createNewVideo];
    _currentRecordIsCancel = NO;
    NSURL *outURL = [NSURL fileURLWithPath:_currentRecord.videoAbsolutePath];
    [self createWriter:outURL];
    
    _topSlideView.isRecoding = YES;
    
    _statusInfo.textColor = kzThemeTineColor;
    _statusInfo.text = @"↑上移取消";
    _statusInfo.hidden = NO;
    kz_dispatch_after(0.5, ^{
        _statusInfo.hidden = YES;
    });
    
    _recoding = YES;
}

- (void)ctrollVideoDidEnd:(KZControllerBar *)controllerBar {
    _topSlideView.isRecoding = NO;
    _recoding = NO;
    __weak typeof(self)weakSelf = self;

    [self saveVideo:^(NSURL *outFileURL) {
        //录制结束，拿到数据
        //_currentRecord就是最后的数据        
        
        [self movFileTransformToMP4WithSourceUrl:_currentRecord.videoAbsolutePath completion:^(NSString *Mp4FilePath) {            
            if (weakSelf.finishVideoBlock) {
                weakSelf.finishVideoBlock(_currentRecord);
            }
        }];
        [weakSelf dismissViewControllerAnimated:YES completion:nil];

    }];
}

- (void)ctrollVideoDidCancel:(KZControllerBar *)controllerBar reason:(KZRecordCancelReason)reason{
    _currentRecordIsCancel = YES;
    _topSlideView.isRecoding = NO;
    _recoding = NO;
    if (reason == KZRecordCancelReasonTimeShort) {
        [KZVideoConfig showHinInfo:@"录制时间过短" inView:_videoView frame:CGRectMake(0,CGRectGetHeight(_videoView.frame)/3*2,CGRectGetWidth(_videoView.frame),20) timeLong:1.0];
    }
}

- (void)ctrollVideoWillCancel:(KZControllerBar *)controllerBar {
    if (!_cancelInfo.hidden) {
        return;
    }
    _cancelInfo.text = @"松手取消";
    _cancelInfo.hidden = NO;
    kz_dispatch_after(0.5, ^{
        _cancelInfo.hidden = YES;
    });
}

- (void)ctrollVideoDidRecordSEC:(KZControllerBar *)controllerBar {
    _topSlideView.isRecoding = YES;
}

- (void)ctrollVideoDidClose:(KZControllerBar *)controllerBar {
    NSLog(@"没有录到视频");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)ctrollVideoOpenVideoList:(KZControllerBar *)controllerBar {
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate, AVCaptureAudioDataOutputSampleBufferDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
    if (!_recoding) return;
    
    @autoreleasepool {
        _currentSampleTime = CMSampleBufferGetOutputPresentationTimeStamp(sampleBuffer);
        if (_assetWriter.status != AVAssetWriterStatusWriting) {
            [_assetWriter startWriting];
            [_assetWriter startSessionAtSourceTime:_currentSampleTime];
        }
        if (captureOutput == _videoDataOut) {
            if (_assetWriterPixelBufferInput.assetWriterInput.isReadyForMoreMediaData) {
                CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
                BOOL success = [_assetWriterPixelBufferInput appendPixelBuffer:pixelBuffer withPresentationTime:_currentSampleTime];
                if (!success) {
                    NSLog(@"Pixel Buffer没有append成功");
                }
            }
        }
        if (captureOutput == _audioDataOut) {
            [_assetWriterAudioInput appendSampleBuffer:sampleBuffer];
        }
    }
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didDropSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
}




- (void)createWriter:(NSURL *)assetUrl {
    _assetWriter = [AVAssetWriter assetWriterWithURL:assetUrl fileType:AVFileTypeQuickTimeMovie error:nil];
    int videoWidth = kzSCREEN_WIDTH;
    int videoHeight = kzSCREEN_HEIGHT;
    NSDictionary *outputSettings = @{
                                     AVVideoCodecKey : AVVideoCodecH264,
                                     AVVideoWidthKey : @(videoHeight),
                                     AVVideoHeightKey : @(videoWidth),
                                     AVVideoScalingModeKey:AVVideoScalingModeResizeAspectFill,
                                     };
    _assetWriterVideoInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:outputSettings];
    _assetWriterVideoInput.expectsMediaDataInRealTime = YES;
    _assetWriterVideoInput.transform = CGAffineTransformMakeRotation(M_PI / 2.0);
    
    
    NSDictionary *audioOutputSettings = @{
                                          AVFormatIDKey:@(kAudioFormatMPEG4AAC),
                                          AVEncoderBitRateKey:@(64000),
                                          AVSampleRateKey:@(44100),
                                          AVNumberOfChannelsKey:@(1),
                                          };
    
    _assetWriterAudioInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeAudio outputSettings:audioOutputSettings];
    _assetWriterAudioInput.expectsMediaDataInRealTime = YES;
    
    
    NSDictionary *SPBADictionary = @{
                                     (__bridge NSString *)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_32BGRA),
                                     (__bridge NSString *)kCVPixelBufferWidthKey : @(videoWidth),
                                     (__bridge NSString *)kCVPixelBufferHeightKey  : @(videoHeight),
                                     (__bridge NSString *)kCVPixelFormatOpenGLESCompatibility : ((__bridge NSNumber *)kCFBooleanTrue)
                                     };
    _assetWriterPixelBufferInput = [AVAssetWriterInputPixelBufferAdaptor assetWriterInputPixelBufferAdaptorWithAssetWriterInput:_assetWriterVideoInput sourcePixelBufferAttributes:SPBADictionary];
    if ([_assetWriter canAddInput:_assetWriterVideoInput]) {
        [_assetWriter addInput:_assetWriterVideoInput];
    }else {
        NSLog(@"不能添加视频writer的input \(assetWriterVideoInput)");
    }
    if ([_assetWriter canAddInput:_assetWriterAudioInput]) {
        [_assetWriter addInput:_assetWriterAudioInput];
    }else {
        NSLog(@"不能添加视频writer的input \(assetWriterVideoInput)");
    }
    
}

- (void)saveVideo:(void(^)(NSURL *outFileURL))complier {
    
    if (_recoding) return;
    
    if (!_recoding_queue){
        complier(nil);
        return;
    };
    
    dispatch_async(_recoding_queue, ^{
        NSURL *outputFileURL = [NSURL fileURLWithPath:_currentRecord.videoAbsolutePath];
        [_assetWriter finishWritingWithCompletionHandler:^{
            
            if (_currentRecordIsCancel) return ;
            
            [KZVideoUtil saveThumImageWithVideoURL:outputFileURL second:1];
            
            if (complier) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    complier(outputFileURL);
                });
            }
        }];
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)movFileTransformToMP4WithSourceUrl:(NSString *)sourceUrl completion:(void(^)(NSString *Mp4FilePath))comepleteBlock
{
    /**
     *  mov格式转mp4格式
     */
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:sourceUrl] options:nil];
    
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
        
        NSString * resultPath = _currentRecord.videoMP4Path;//PATH_OF_DOCUMENT为documents路径
        exportSession.outputURL = [NSURL fileURLWithPath:resultPath];
        
        exportSession.outputFileType = AVFileTypeMPEG4;//可以配置多种输出文件格式
        
        exportSession.shouldOptimizeForNetworkUse = YES;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
         
         {
             dispatch_async(dispatch_get_main_queue(), ^{
             });
             
             switch (exportSession.status) {
                 case AVAssetExportSessionStatusUnknown:
                     NSLog(@"视频格式转换出错Unknown"); //自定义错误提示信息
                     break;
                     
                 case AVAssetExportSessionStatusWaiting:
                     NSLog(@"视频格式转换出错Waiting");
                     break;
                     
                 case AVAssetExportSessionStatusExporting:
                     NSLog(@"视频格式转换出错Exporting");
                     break;
                     
                 case AVAssetExportSessionStatusCompleted:
                 {
                     NSLog(@"MOV->MP4=OK");
                     NSLog(@"%@",exportSession.outputURL);
                     comepleteBlock(resultPath);
                 }
                     break;
                     
                 case AVAssetExportSessionStatusFailed:
                     
                     //                     NSLog(@"AVAssetExportSessionStatusFailed");
                     NSLog(@"视频格式转换出错Unknown");
                     
                     break;
                     
                 case AVAssetExportSessionStatusCancelled:
                     
                     //                     NSLog(@"AVAssetExportSessionStatusFailed");
                     NSLog(@"视频格式转换出错Cancelled");
                     
                     break;
                     
             }
             
         }];
        
    }  
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
