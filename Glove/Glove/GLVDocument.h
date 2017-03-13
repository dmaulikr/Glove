//
//  GLVDocument.h
//  Glove
//
//  Created by Race Vanderdecken on 2/3/14.
//  Copyright (c) 2014 The Untrained Brain Co. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AVFoundation/AVFoundation.h>
 
@interface GLVDocument : NSDocument

@property AVCaptureSession *session;
@property AVCaptureVideoPreviewLayer *previewLayer;
@property AVCaptureVideoPreviewLayer *previewGlLayer;
@property (strong) IBOutlet NSView *previewView;
@property (strong) IBOutlet NSOpenGLView *previewGLView;



@property CMTime frameDuration;
@property CMTime nextPresentationTime;

@property NSURL *outputURL;
@property Float64 defaultFPS;
@end
