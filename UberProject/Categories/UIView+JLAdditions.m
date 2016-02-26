

#import "UIView+JLAdditions.h"

@implementation UIView (JLAdditions)

- (CGRect)jl_frameVerticallyCenteredForChildFrame:(CGRect)childRect
{
    CGRect myBounds = [self bounds];
    childRect.origin.y = (CGRectGetHeight(myBounds)/2) - (CGRectGetHeight(childRect)/2);
    return childRect;
}

- (CGRect)jl_frameVerticallyCenteredForChildFrame:(CGRect)childRect topPadding:(CGFloat)topPadding
{
    CGRect myBounds = self.bounds;
    myBounds.size.height -= topPadding;
    childRect.origin.y = topPadding + (CGRectGetHeight(myBounds)/2) - (CGRectGetHeight(childRect)/2);
    return childRect;
}

- (CGRect)jl_frameHorizontallyCenteredForChildFrame:(CGRect)childRect
{
    CGRect viewBounds = [self bounds];
    CGFloat newChildX = CGRectGetMidX(viewBounds) - (CGRectGetWidth(childRect)/2);
    CGRect newChildFrame = CGRectMake(newChildX, CGRectGetMinY(childRect), CGRectGetWidth(childRect), CGRectGetHeight(childRect));
    return CGRectIntegral(newChildFrame);
}

- (CGRect)jl_frameAlignedRightForChildFrame:(CGRect)childFrame rightMargin:(CGFloat)rightMargin
{
    CGRect myBounds = [self bounds];
    childFrame.origin.x = CGRectGetWidth(myBounds) - CGRectGetWidth(childFrame) - rightMargin;
    return childFrame;
}

- (CGRect)jl_frameAlignedLeftForChildFrame:(CGRect)childFrame leftMargin:(CGFloat)leftMargin
{
    childFrame.origin.x = leftMargin;
    return childFrame;
}

- (CGRect)jl_frameCenteredFrameForChildBounds:(CGRect)childBounds
{
    CGRect viewBounds = [self bounds];
    CGFloat newChildX = CGRectGetMidX(viewBounds) - (CGRectGetWidth(childBounds)/2);
    CGFloat newChildY = CGRectGetMidY(viewBounds) - (CGRectGetHeight(childBounds)/2);
    CGRect newChildFrame = CGRectMake(newChildX, newChildY, CGRectGetWidth(childBounds), CGRectGetHeight(childBounds));
    return CGRectIntegral(newChildFrame);
}

- (CGRect)jl_frameAlignedLeft:(CGRect)frameToPosition rightMargin:(CGFloat)rightMargin;
{
    frameToPosition.origin.x = CGRectGetMinX([self frame]) - CGRectGetWidth(frameToPosition) - rightMargin;
    return frameToPosition;
}

- (CGRect)jl_frameAlignedRight:(CGRect)frameToPosition leftMargin:(CGFloat)leftMargin
{
    frameToPosition.origin.x = CGRectGetMaxX([self frame]) + leftMargin;
    return frameToPosition;
}

- (CGRect)jl_frameAlignedBottom:(CGRect)frameToPosition bottomMargin:(CGFloat)bottomMargin
{
    CGRect newFrame = frameToPosition;
    CGFloat childHeight = CGRectGetHeight(frameToPosition);
    newFrame.origin.y = CGRectGetHeight([self bounds]) - childHeight - bottomMargin;
    return newFrame;    
}

- (CGRect)jl_frameAlignedMiddle:(CGRect)frameToPosition topMargin:(CGFloat)topMargin
{
    CGRect newFrame = frameToPosition;
    CGFloat inputFrameHeight = CGRectGetHeight(frameToPosition);
    newFrame.origin.y = (CGRectGetMinY(self.frame) + (CGRectGetHeight([self bounds]) / 2.0) - (inputFrameHeight / 2.0))+ topMargin;
    return newFrame;
}

+ (CGFloat)jl_onePixelForMainScreen
{
    return (1/[[UIScreen mainScreen] scale]);
}

- (UIImage *)jl_viewSnapShot
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *copied = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return copied;
}

CGRect CGRectIntegralRetina(CGRect rect)
{
    return CGRectMake(round(rect.origin.x * [UIScreen mainScreen].scale) / [UIScreen mainScreen].scale, round(rect.origin.y * [UIScreen mainScreen].scale) / [[UIScreen mainScreen] scale], round(rect.size.width * [UIScreen mainScreen].scale) / [UIScreen mainScreen].scale, round(rect.size.height * [UIScreen mainScreen].scale) / [UIScreen mainScreen].scale);
}

@end
