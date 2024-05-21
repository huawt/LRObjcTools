#import "LRLayoutButton.h"
#import "NSObject+Extension.h"
@interface LRLayoutButton ()
@property (nonatomic, copy) NSString *storedTitle;
@property (nonatomic, assign) NSInteger second;
@property (nonatomic, strong) NSTimer *timer;
@end
@implementation LRLayoutButton
- (void)setLayoutTypeValue:(NSInteger)layoutTypeValue {
    _layoutTypeValue = layoutTypeValue;
    self.layoutType = MIN(3, MAX(0, layoutTypeValue));
}
- (void)timeCountDown:(NSInteger)second display:(NSString *)title {
    if (second <= 0) {
        self.enabled = YES;
    } else {
        self.second = second;
        if ([NSString isValid:title]) {
            self.storedTitle = title;
        } else {
            self.storedTitle = self.currentTitle;
        }
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeSecond) userInfo:nil repeats:YES];
        [self.timer fire];
    }
}
- (void)changeSecond {
    if (self.second <= 1) {
        [self.timer invalidate];
        self.timer = nil;
        [self displayTitle:self.storedTitle];
        self.enabled = YES;
    } else {
        self.enabled = NO;
        self.second -= 1;
        [self displayTitle:[NSString stringWithFormat:@"%@s", @(self.second)]];
    }
}
- (void)displayTitle: (NSString *)title {
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateHighlighted];
    [self setTitle:title forState:UIControlStateDisabled];
}
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
            leftFrame.origin.x = self.contentEdgeInsets.left;
            rightFrame.origin.x = CGRectGetMaxX(leftFrame) + space;
            break;
        case UIControlContentHorizontalAlignmentCenter:
        case UIControlContentHorizontalAlignmentFill:
            leftFrame.origin.x = (self.bounds.size.width - totalWidth) / 2.0;
            rightFrame.origin.x = CGRectGetMaxX(leftFrame) + space;
            break;
        case UIControlContentHorizontalAlignmentRight:
        case UIControlContentHorizontalAlignmentTrailing:
            rightFrame.origin.x = self.bounds.size.width - rightFrame.size.width - self.contentEdgeInsets.right;
            leftFrame.origin.x = CGRectGetMinX(rightFrame) - space - leftFrame.size.width;
            break;
    }
    switch (self.contentVerticalAlignment) {
        case UIControlContentVerticalAlignmentTop:
            leftFrame.origin.y = self.contentEdgeInsets.top;
            rightFrame.origin.y = self.contentEdgeInsets.top;
            break;
        case UIControlContentVerticalAlignmentCenter:
        case UIControlContentVerticalAlignmentFill:
            leftFrame.origin.y = (self.bounds.size.height - leftFrame.size.height) / 2.0;
            rightFrame.origin.y = (self.bounds.size.height - rightFrame.size.height) / 2.0;
            break;
        case UIControlContentVerticalAlignmentBottom:
            leftFrame.origin.y = (self.bounds.size.height - leftFrame.size.height) - self.contentEdgeInsets.bottom;
            rightFrame.origin.y = (self.bounds.size.height - rightFrame.size.height) - self.contentEdgeInsets.bottom;
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
            upFrame.origin.x = self.contentEdgeInsets.left;
            downFrame.origin.x = self.contentEdgeInsets.left;
            break;
        case UIControlContentHorizontalAlignmentCenter:
        case UIControlContentHorizontalAlignmentFill:
            upFrame.origin.x = (self.bounds.size.width - upFrame.size.width) / 2.0;
            downFrame.origin.x = (self.bounds.size.width - downFrame.size.width) / 2.0;
            break;
        case UIControlContentHorizontalAlignmentRight:
        case UIControlContentHorizontalAlignmentTrailing:
            upFrame.origin.x = self.bounds.size.width - upFrame.size.width - self.contentEdgeInsets.right;
            downFrame.origin.x =self.bounds.size.width - downFrame.size.width - self.contentEdgeInsets.right;
            break;
    }
    switch (self.contentVerticalAlignment) {
        case UIControlContentVerticalAlignmentTop:
            upFrame.origin.y = self.contentEdgeInsets.top;
            downFrame.origin.y = CGRectGetMaxY(upFrame) + space;
            break;
        case UIControlContentVerticalAlignmentCenter:
        case UIControlContentVerticalAlignmentFill:
            upFrame.origin.y = (self.bounds.size.height - totalHeight) / 2.0;
            downFrame.origin.y = CGRectGetMaxY(upFrame) + space;
            break;
        case UIControlContentVerticalAlignmentBottom:
            downFrame.origin.y = (self.bounds.size.height - downFrame.size.height) - self.contentEdgeInsets.bottom;
            upFrame.origin.y = CGRectGetMinY(downFrame) - space - upFrame.size.height;
            break;
    }
    upView.frame = upFrame;
    downView.frame = downFrame;
}
@end
