//
//  QSViewController.m
//  QuickSketch
//
//  Created by Thomas DiZoglio on 7/12/13.
//  Copyright (c) 2013 Thomas DiZoglio. All rights reserved.
//

#import "QSViewController.h"

@interface QSViewController ()

@end

@implementation QSViewController

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    canvasView = (DrawingCanvasView *)self.view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        [canvasView eraseCanvas];
    }
}

- (IBAction)eraserButtonActionUp:(id)sender
{
    
    [canvasView setStrokeColor:[UIColor whiteColor]];
    [canvasView setPathLineWidth:8.0];
}

- (IBAction)blackMarkerButtonActionUp:(id)sender
{

    [canvasView setStrokeColor:[UIColor blackColor]];
    [canvasView setPathLineWidth:2.0];
}

- (IBAction)redMarkerButtonActionUp:(id)sender
{

    [canvasView setStrokeColor:[UIColor redColor]];
    [canvasView setPathLineWidth:2.0];
}

- (IBAction)blueMarkerButtonActionUp:(id)sender
{

    [canvasView setStrokeColor:[UIColor blueColor]];
    [canvasView setPathLineWidth:2.0];
}

- (IBAction)cameraRollButtonActionUp:(id)sender
{
}

- (IBAction)emailButtonActionUp:(id)sender
{
    
}

@end
