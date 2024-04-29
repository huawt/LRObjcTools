#import "LRLayoutButton.h"
@implementation LRLayoutButton
- (void)setLayoutTypeValue:(NSInteger)layoutTypeValue {
    _layoutTypeValue = layoutTypeValue;
    self.layoutType = MIN(3, MAX(0, layoutTypeValue));
}
#if 0
- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self layoutIfNeeded];
}
- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    [self layoutIfNeeded];
}
#endif
- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutStyle];
}
- (void)layoutStyle {
    [self.imageView sizeToFit];
    [self.titleLabel sizeToFit];
    switch (self.layoutType) {
        case LRLayoutButtonType_LeftImageRightTitle:
            [self layoutHorizontalLeftView:self.imageView rightView:self.titleLabel spacing:self.spacing];
            break;
        case LRLayoutButtonType_LeftTitleRightImage:
            [self layoutHorizontalLeftView:self.titleLabel rightView:self.imageView spacing:self.spacing];
            break;
        case LRLayoutButtonType_UpImageDownTitle:
            [self layoutVerticalUpView:self.imageView downView:self.titleLabel spacing:self.spacing];
            break;
        case LRLayoutButtonType_UpTitleDownImage:
            [self layoutVerticalUpView:self.titleLabel downView:self.imageView spacing:self.spacing];
            break;
    }
}
- (void)layoutHorizontalLeftView: (UIView *)leftView rightView: (UIView *)rightView spacing: (CGFloat)spacing {
    CGRect leftFrame = leftView.hidden ? CGRectZero : leftView.frame;
    CGRect rightFrame = rightView.hidden ? CGRectZero : rightView.frame;
    CGFloat space = (leftView.hidden || rightView.hidden) ? 0 : spacing;
    CGFloat totalWidth = leftFrame.size.width + space + rightFrame.size.width;
    switch (self.contentHorizontalAlignment) {
        case UIControlContentHorizontalAlignmentLeft:
        case UIControlContentHorizontalAlignmentLeading:
            leftFrame.origin.x = 0;
            rightFrame.origin.x = CGRectGetMaxX(leftFrame) + space;
            break;
        case UIControlContentHorizontalAlignmentCenter:
        case UIControlContentHorizontalAlignmentFill:
            leftFrame.origin.x = (self.bounds.size.width - totalWidth) / 2.0;
            rightFrame.origin.x = CGRectGetMaxX(leftFrame) + space;
            break;
        case UIControlContentHorizontalAlignmentRight:
        case UIControlContentHorizontalAlignmentTrailing:
            rightFrame.origin.x = self.bounds.size.width - rightFrame.size.width;
            leftFrame.origin.x = CGRectGetMinX(rightFrame) - space - leftFrame.size.width;
            break;
    }
    switch (self.contentVerticalAlignment) {
        case UIControlContentVerticalAlignmentTop:
            leftFrame.origin.y = 0;
            rightFrame.origin.y = 0;
            break;
        case UIControlContentVerticalAlignmentCenter:
        case UIControlContentVerticalAlignmentFill:
            leftFrame.origin.y = (self.bounds.size.height - leftFrame.size.height) / 2.0;
            rightFrame.origin.y = (self.bounds.size.height - rightFrame.size.height) / 2.0;
            break;
        case UIControlContentVerticalAlignmentBottom:
            leftFrame.origin.y = (self.bounds.size.height - leftFrame.size.height);
            rightFrame.origin.y = (self.bounds.size.height - rightFrame.size.height);
            break;
    }
    leftView.frame = leftFrame;
    rightView.frame = rightFrame;
}
- (void)layoutVerticalUpView: (UIView *)upView downView: (UIView *)downView spacing: (CGFloat)spacing {
    CGRect upFrame = upView.hidden ? CGRectZero : upView.frame;
    CGRect downFrame = downView.hidden ? CGRectZero : downView.frame;
    CGFloat space = (upView.hidden || downView.hidden) ? 0 : spacing;
    CGFloat totalHeight = upFrame.size.height + space + downFrame.size.height;
    switch (self.contentHorizontalAlignment) {
        case UIControlContentHorizontalAlignmentLeft:
        case UIControlContentHorizontalAlignmentLeading:
            upFrame.origin.x = 0;
            downFrame.origin.x = 0;
            break;
        case UIControlContentHorizontalAlignmentCenter:
        case UIControlContentHorizontalAlignmentFill:
            upFrame.origin.x = (self.bounds.size.width - upFrame.size.width) / 2.0;
            downFrame.origin.x = (self.bounds.size.width - downFrame.size.width) / 2.0;
            break;
        case UIControlContentHorizontalAlignmentRight:
        case UIControlContentHorizontalAlignmentTrailing:
            upFrame.origin.x = self.bounds.size.width - upFrame.size.width;
            downFrame.origin.x =self.bounds.size.width - downFrame.size.width;
            break;
    }
    switch (self.contentVerticalAlignment) {
        case UIControlContentVerticalAlignmentTop:
            upFrame.origin.y = 0;
            downFrame.origin.y = CGRectGetMaxY(upFrame) + space;
            break;
        case UIControlContentVerticalAlignmentCenter:
        case UIControlContentVerticalAlignmentFill:
            upFrame.origin.y = (self.bounds.size.height - totalHeight) / 2.0;
            downFrame.origin.y = CGRectGetMaxY(upFrame) + space;
            break;
        case UIControlContentVerticalAlignmentBottom:
            downFrame.origin.y = (self.bounds.size.height - downFrame.size.height);
            upFrame.origin.y = CGRectGetMinY(downFrame) - space - upFrame.size.height;
            break;
    }
    upView.frame = upFrame;
    downView.frame = downFrame;
}
@end
