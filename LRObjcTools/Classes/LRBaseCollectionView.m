#import "LRBaseCollectionView.h"
@implementation LRBaseCollectionView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self config];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self config];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self config];
}
- (void)config {
    self.backgroundColor = [UIColor clearColor];
    self.contentInset = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.scrollsToTop = YES;
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.scrollIndicatorInsets = self.contentInset;
    self.alwaysBounceVertical = NO;
    self.alwaysBounceHorizontal = NO;
    self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}
@end
