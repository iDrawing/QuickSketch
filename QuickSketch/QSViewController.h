/*
 QSViewController.h
 QuickSketch
 
 Copyright (c) 2013 Thomas DiZoglio. All rights reserved.
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
 of the Software, and to permit persons to whom the Software is furnished to do
 so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 If you happen to meet one of the copyright holders in a bar you are obligated
 to buy them one pint of beer.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
*/

#import <UIKit/UIKit.h>
#import "DrawingCanvasView.h"
#import "KSSheetView.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface QSViewController : UIViewController <MFMailComposeViewControllerDelegate, KSSheetViewDelegate> {
    
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
