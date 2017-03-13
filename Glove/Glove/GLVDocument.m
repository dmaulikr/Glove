//
//  GLVDocument.m
//  Glove
//
//  Created by Race Vanderdecken on 2/3/14.
//  Copyright (c) 2014 The Untrained Brain Co. All rights reserved.
//

#import "GLVDocument.h"


@implementation GLVDocument

@synthesize session = _session;
@synthesize previewLayer = _previewLayer;
@synthesize previewView = _previewView;
@synthesize previewGlLayer  = _previewGlLayer;

- (id)init
{
    self = [super init];
    if (self) {
        // Add your subclass-specific initialization here.
       _defaultFPS = 1.0 / 5.0;
        _frameDuration = CMTimeMakeWithSeconds(_defaultFPS, 90000);

    }
    return self;
}

- (void)addPreviewToSession
{
    _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    [_previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_previewLayer setFrame:[_previewView bounds]];
    [[_previewLayer connection] setAutomaticallyAdjustsVideoMirroring:NO];
    [[_previewLayer connection] setVideoMirrored:YES];
    
    // add the preview layer to the hierarchy
    CALayer *viewLayer = [[CALayer alloc] init];
    [_previewView setWantsLayer:YES];
    [_previewView setLayer:viewLayer];
    CALayer *rootLayer = [_previewView layer];
    
    [rootLayer setBackgroundColor:CGColorGetConstantColor(kCGColorBlack)];
    [rootLayer addSublayer:_previewLayer];
    

    
    _previewGlLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    [_previewGlLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_previewGlLayer setFrame:[_previewGLView bounds]];
    [[_previewGlLayer connection] setAutomaticallyAdjustsVideoMirroring:NO];
    [[_previewGlLayer connection] setVideoMirrored:NO];
    
    CALayer *viewGlLayer = [[CALayer alloc]init];
    [_previewGLView setWantsLayer:YES];
    [_previewGLView setLayer:viewGlLayer];
    
    CALayer *rootGlLayer = [_previewGLView layer];
    [rootGlLayer setBackgroundColor:CGColorGetConstantColor(kCGColorBlack)];
    [rootGlLayer addSublayer:_previewGlLayer];

}

- (BOOL)addCameraToSession
{
    BOOL ret = true;
    for (AVCaptureDevice *device in [AVCaptureDevice devices])
    {
        if ([device hasMediaType:AVMediaTypeVideo] || [device hasMediaType:AVMediaTypeMuxed])
        {
            NSError *error = nil;
            AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
            if ( !error)
            {
                if ([_session canAddInput:input])
                {
                    [_session addInput:input];
                }
            }
            else
            {
                NSLog(@"deviceInputWithDevice failed, error=> %@", [error localizedDescription]);
                ret = false;
            }

            break;
        }
    }
    return ret;
}
- (void)setupCameraPreview
{
    _session = [[AVCaptureSession alloc] init];
    [self addCameraToSession];
    [self addPreviewToSession];
    [_session startRunning];
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"GLVDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
  
    [self setupCameraPreview];
    
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning NO.
    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead.
    // If you override either of these, you should also override -isEntireFileLoaded to return NO if the contents are lazily loaded.
    NSException *exception = [NSException exceptionWithName:@"UnimplementedMethod" reason:[NSString stringWithFormat:@"%@ is unimplemented", NSStringFromSelector(_cmd)] userInfo:nil];
    @throw exception;
    return YES;
}

@end
