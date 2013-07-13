//
//  QSViewController.h
//  QuickSketch
//
//  Created by Thomas DiZoglio on 7/12/13.
//  Copyright (c) 2013 Thomas DiZoglio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawingCanvasView.h"

@interface QSViewController : UIViewController {
    
    DrawingCanvasView *canvasView;
}
- (IBAction)emailButtonActionUp:(id)sender;
- (IBAction)cameraRollButtonActionUp:(id)sender;
- (IBAction)eraserButtonActionUp:(id)sender;
- (IBAction)blackMarkerButtonActionUp:(id)sender;
- (IBAction)redMarkerButtonActionUp:(id)sender;
- (IBAction)blueMarkerButtonActionUp:(id)sender;
- (IBAction)yellowMarkerButtonActionUp:(id)sender;

@end
