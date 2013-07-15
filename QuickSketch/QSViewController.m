/*
 QSViewController.m
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
    bGridMode = NO;
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

- (IBAction)yellowMarkerButtonActionUp:(id)sender {

    [canvasView setStrokeColor:[UIColor yellowColor]];
    [canvasView setPathLineWidth:2.0];
}

- (IBAction)canvasBackgroundActionUp:(id)sender {
    
    if (bGridMode == NO)
    {
        bGridMode = YES;
        [canvasView gridOutlineState:YES];
        [_backgroundButton setImage:[UIImage imageNamed:@"whiteboard.png"] forState:UIControlStateNormal];
    }
    else
    {
        bGridMode = NO;
        [canvasView gridOutlineState:NO];
        [_backgroundButton setImage:[UIImage imageNamed:@"grid.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)cameraRollButtonActionUp:(id)sender
{
    UIImage *canvasImage = [canvasView imageByRenderingView];
    if (canvasImage == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Cameraroll Error" message: @"Problem creating image of worksheet canvas." delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {        
        UIImageWriteToSavedPhotosAlbum(canvasImage, nil, nil, nil);
    }
}

- (IBAction)emailButtonActionUp:(id)sender
{
    if ([MFMailComposeViewController canSendMail])
    {
        
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        [picker setSubject:@"Check out this image!"];
        
        // Set up recipients
        // NSArray *toRecipients = [NSArray arrayWithObject:@"first@example.com"];
        // NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
        // NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
        
        // [picker setToRecipients:toRecipients];
        // [picker setCcRecipients:ccRecipients];
        // [picker setBccRecipients:bccRecipients];
        
        // Attach an image to the email
        NSString *canvasImagePath = [canvasView writeCanvasToJPG];
        if (canvasImagePath == nil)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Attachment Error" message: @"Problem converting Worksheet canvas to JPG." delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return;
        }

        UIImage *coolImage = [canvasView imageByRenderingView];
        NSData *myData = UIImagePNGRepresentation(coolImage);
        [picker addAttachmentData:myData mimeType:@"image/png" fileName:@"coolImage.png"];
        
        // Fill out the email body text
        NSString *emailBody = @"My cool image is attached";
        [picker setMessageBody:emailBody isHTML:NO];
        [self presentModalViewController:picker animated:YES];
    }
    else {
        
        NSLog(@"Device is unable to send email in its current state.");
    }
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    NSString *emailResult = nil;
    switch (result)
    {
        case MFMailComposeResultCancelled:
            emailResult = @"Result: canceled";
            break;
        case MFMailComposeResultSaved:
            emailResult = @"Result: saved";
            break;
        case MFMailComposeResultSent:
            emailResult = @"Result: sent";
            break;
        case MFMailComposeResultFailed:
            emailResult = @"Result: failed";
            break;
        default:
            emailResult = @"Result: not sent";
            break;
    }

    if (emailResult != nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email Message" message:emailResult delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }

    [self dismissModalViewControllerAnimated:YES];
}

@end
