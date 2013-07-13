//
//  DrawingCanvasView.h
//
//

#import <UIKit/UIKit.h>

@interface DrawingCanvasView : UIView {
    
    NSMutableArray *allPaths;
    NSMutableArray *pathColors;
    NSMutableArray *pathWidth;
    UIColor *currentStrokeColor;
    float lineWidth;
}

-(void) setStrokeColor:(UIColor *)color;
-(void) setPathLineWidth:(float)lineWidth;

-(void) eraseCanvas;

@end
