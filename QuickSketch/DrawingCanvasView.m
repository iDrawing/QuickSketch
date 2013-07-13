#import "DrawingCanvasView.h"

@implementation DrawingCanvasView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        allPaths = [[NSMutableArray alloc] init];
        pathColors = [[NSMutableArray alloc] init];
        pathWidth = [[NSMutableArray alloc] init];
        lineWidth = 2.0;
        [self setMultipleTouchEnabled:NO];
        [self setBackgroundColor:[UIColor whiteColor]];
        currentStrokeColor = [UIColor blackColor];
    }
    return self;
}

- (void) dealloc
{
    allPaths = nil;
    pathColors = nil;
    pathWidth = nil;
}

- (void)drawRect:(CGRect)rect
{
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

@end
