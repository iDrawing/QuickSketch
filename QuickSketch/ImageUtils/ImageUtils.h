@interface UIImage (ImageUtils)
+(UIImage*)imageFromView:(UIView*)view;
+(UIImage*)imageFromView:(UIView*)view scaledToSize:(CGSize)newSize;
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
@end
