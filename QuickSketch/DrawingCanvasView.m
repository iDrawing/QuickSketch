/*
 DrawingCanvasView.m
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

#import <QuartzCore/QuartzCore.h>
#import "DrawingCanvasView.h"
#import "iToast.h"

@implementation DrawingCanvasView

@synthesize cellSize;
@synthesize offset;
@synthesize gridLineWidth;

@synthesize gridWidth;
@synthesize gridHeight;

-(void) initCanvas
{
    allPaths = [[NSMutableArray alloc] init];
    pathColors = [[NSMutableArray alloc] init];
    pathWidth = [[NSMutableArray alloc] init];
    [self setMultipleTouchEnabled:NO];
    [self setBackgroundColor:[UIColor whiteColor]];
    [self setStrokeColor:[UIColor blackColor]];
    [self setPathLineWidth:2.0];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        bGridOn = NO;
        paperColor = CGColorCreateCopy([UIColor whiteColor].CGColor);
        lineColor = CGColorCreateCopy([UIColor colorWithRed:0.48
                                                      green:0.73
                                                       blue:0.96
                                                      alpha:1.0].CGColor);
        
        // default
        self.cellSize = self.frame.size.width / 12;
        self.offset = CGPointMake((self.frame.size.width - cellSize * gridWidth) / 2,
                                  (self.frame.size.height - cellSize * gridHeight) / 2);
        self.gridLineWidth = ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 2.0 : 1.0);

        // This is from init settings I liked for grid
        self.cellSize = 20;
        self.gridLineWidth = 1.0;

        [self initCanvas];
    }
    return self;
}

- (void) dealloc
{
    allPaths = nil;
    pathColors = nil;
    pathWidth = nil;
    
    CGColorRelease(paperColor);
    CGColorRelease(lineColor);
}

- (void) setCellSize:(NSUInteger)aCellSize
{
    cellSize = aCellSize;
    
    // dependent ivars
    gridWidth = self.frame.size.width / cellSize;
    gridHeight = self.frame.size.height / cellSize;
}

- (void)drawRect:(CGRect)rect
{
    if (bGridOn)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        // paper color
        CGContextSetFillColorWithColor(context, paperColor);
        CGContextFillRect(context, rect);
        
        // grid color
        CGContextSetStrokeColorWithColor(context, lineColor);
        CGContextSetLineWidth(context, gridLineWidth);
        
        CGPoint delta;
        
        // horizontal lines
        delta.y = offset.y;
        while (delta.y < rect.size.height) {
            CGContextBeginPath(context);
            CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + delta.y);
            CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + delta.y);
            CGContextStrokePath(context);
            
            delta.y += cellSize;
        }
        
        // vertical lines
        delta.x = offset.x;
        while (delta.x < rect.size.width) {
            CGContextBeginPath(context);
            CGContextMoveToPoint(context, rect.origin.x + delta.x, rect.origin.y);
            CGContextAddLineToPoint(context, rect.origin.x + delta.x, rect.origin.y + rect.size.height);
            CGContextStrokePath(context);
            
            delta.x += cellSize;
        }
    }
    
    int count = 0;
    for(UIBezierPath *path in allPaths)
    {
        UIColor *color = [pathColors objectAtIndex:count];
        [color setStroke];
        NSNumber *width = [pathWidth objectAtIndex:count];
        path.lineWidth = [width floatValue];
        [path strokeWithBlendMode:kCGBlendModeNormal alpha:1.0];
        count++;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    UITouch *mytouch = [[touches allObjects] objectAtIndex:0];
    [path moveToPoint:[mytouch locationInView:self]];
    [allPaths addObject:path];
    [pathColors addObject:currentStrokeColor];
    NSNumber *lLineWidth = [NSNumber numberWithFloat:lineWidth];
    [pathWidth addObject:lLineWidth];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIBezierPath *path = [allPaths objectAtIndex:[allPaths count] - 1];
    UITouch *mytouch = [[touches allObjects] objectAtIndex:0];
    [path addLineToPoint:[mytouch locationInView:self]];
    [self setNeedsDisplay];
}

-(void) gridOutlineState:(BOOL)state
{
    bGridOn = state;
    [self setNeedsDisplay];
}

-(void) eraseCanvas
{    
    [[iToast makeText:NSLocalizedString(@"Shaking device erases whiteboard.", @"")] show];

    allPaths = nil;
    pathColors = nil;
    pathWidth = nil;
    [self initCanvas];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

-(void) setStrokeColor:(UIColor *)color
{
    currentStrokeColor = color;
}

-(void) setPathLineWidth:(float)lw
{
    lineWidth = lw;
}

- (UIImage *)imageByRenderingView
{
    CGSize imgsize = self.frame.size;
    //CGSize imgsize = self.view.bounds;
    UIGraphicsBeginImageContext(imgsize);
    //[self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *canvasImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return canvasImage;
}

-(NSString *) writeCanvasToJPG
{
    UIImage *canvasImage = [self imageByRenderingView];
    NSData *imageData = UIImageJPEGRepresentation(canvasImage, 1);
    // Store in cache directory and remove if email sent ok.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *fullPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"quickSketch.jpg"];
    BOOL success = [imageData writeToFile:fullPath atomically:YES];
    if (success == YES)
        return fullPath;
    else
        return nil;
}

@end
