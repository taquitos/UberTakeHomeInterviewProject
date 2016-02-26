
#import <UIKit/UIKit.h>

@interface UIView (JLAdditions)

///positions a child frame in the center of its parent.
///Note:It doesn't change the x origin.

///                                     |                       |
///Visually, it might looks like this:  |       |childFrame|    |
///                                     |                       |
- (CGRect)jl_frameVerticallyCenteredForChildFrame:(CGRect)childRect;

///positions a child frame in the center of its parent plus top padding.
///Note:It doesn't change the x origin.

///                                     |                       |
///Visually, it might looks like this:  |       |childFrame|    |
///                                     |                       |
- (CGRect)jl_frameVerticallyCenteredForChildFrame:(CGRect)childRect topPadding:(CGFloat)topPadding;

///positions a child frame in the center of its parent.
///Note:It doesn't change the y origin.
///
///Visually, it might looks like this:  |      |childFrame|     |
///                                     |                       |
///                                     |                       |
- (CGRect)jl_frameHorizontallyCenteredForChildFrame:(CGRect)childRect;

///positions a child frame all the way to the right-most position inside its parent view, with an optional right margin.
///a positive right margin pushing the frame towards the left
///Note:It doesn't change the y origin.
///                              |                              |
///Visually, it looks like this: |                              |
///                              |       |childFrame|rightMargin|
///note: it dosn't change the y origin,
///
- (CGRect)jl_frameAlignedRightForChildFrame:(CGRect)childFrame rightMargin:(CGFloat)rightMargin;

///positions a child frame all the way to the left-most position inside its parent view, with an optional left margin.
///a positive left margin pushing the frame towards the right
///Note:It doesn't change the y origin.
///                              |                              |
///Visually, it looks like this: |                              |
///                              |leftMargin|childFrame|        |
///note: it doesn't change the y origin,
- (CGRect)jl_frameAlignedLeftForChildFrame:(CGRect)childFrame leftMargin:(CGFloat)leftMargin;

///positions a child frame or bounds in the center (vertically and horizontally) of this view's bounds
///
///                                      (this view)
///                              |                          |
///Visually, it looks like this: |       |childFrame|       |
///                              |                          |
///
- (CGRect)jl_frameCenteredFrameForChildBounds:(CGRect)childBounds;

///returns a frame that accounts for the width of this frame, and is just left of the sibling frame.
/// visually, it looks like this when you are done:
///     |              ||           ||          |
///     |returned frame||rightMargin||this frame|
///     |              ||           ||          |
- (CGRect)jl_frameAlignedLeft:(CGRect)frameToPosition rightMargin:(CGFloat)rightMargin;

///returns a frame that accounts for the width of this frame, and is just right of the sibling frame.
/// visually, it looks like this when you are done:
///     |            ||          ||              |
///     | this frame ||leftMargin||returned frame|
///     |            ||          ||              |
/// Note: not hard, just here for completeness
- (CGRect)jl_frameAlignedRight:(CGRect)frameToPosition leftMargin:(CGFloat)leftMargin;

///returns a frame that accounts for the height of this frame, and is just below the sibling frame.
/// visually, it looks like this when you are done:
///     |                |
///     | returned frame |
///     |----------------|
///       bottom margin
///     ------------------
///      this frame bottom
/// Note: not hard, just here for completeness
- (CGRect)jl_frameAlignedBottom:(CGRect)frameToPosition bottomMargin:(CGFloat)bottomMargin;

- (CGRect)jl_frameAlignedMiddle:(CGRect)frameToPosition topMargin:(CGFloat)topMargin;

///returns whatever the single pixel is for the given device you're using, example: retina is currently 0.5.
+ (CGFloat)jl_onePixelForMainScreen;

- (UIImage *)jl_viewSnapShot;

CG_EXTERN CGRect CGRectIntegralRetina(CGRect rect);

@end
