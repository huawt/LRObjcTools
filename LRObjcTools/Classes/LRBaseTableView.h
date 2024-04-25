
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LRBaseTableView : UITableView
@property (nonatomic, assign) IBInspectable NSInteger showSectionBackground;
@property (nonatomic, strong) IBInspectable UIColor *sectionBackgroundColor;
@property (nonatomic, assign) IBInspectable CGFloat sectionBackgroundCornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat sectionBackgroundEdgePaddding;
@property (nonatomic, assign) IBInspectable NSInteger sectionBackgroundContainsHeader;
@property (nonatomic, assign) IBInspectable NSInteger sectionBackgroundContainsFooter;
- (void)registerClassCell:(Class)cellClass;
- (void)registerNibCell:(Class)cellClass;
- (void)registerNibClassCell:(Class)cellClass;
@end

NS_ASSUME_NONNULL_END
