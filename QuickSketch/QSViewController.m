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

- (IBAction)eraserButtonActionUp:(id)sender {
    
    [canvasView setStrokeColor:[UIColor whiteColor]];
    [canvasView setPathLineWidth:8.0];
}

- (IBAction)blackMarkerButtonActionUp:(id)sender {

    [canvasView setStrokeColor:[UIColor blackColor]];
    [canvasView setPathLineWidth:2.0];
}

- (IBAction)redMarkerButtonActionUp:(id)sender {

    [canvasView setStrokeColor:[UIColor redColor]];
    [canvasView setPathLineWidth:2.0];
}

- (IBAction)blueMarkerButtonActionUp:(id)sender {

    [canvasView setStrokeColor:[UIColor blueColor]];
    [canvasView setPathLineWidth:2.0];
}

- (IBAction)emailButtonActionUp:(id)sender
{
    
}

@end
