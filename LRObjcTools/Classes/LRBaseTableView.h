
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LRBaseTableView : UITableView
@property (nonatomic, assign) IBInspectable NSInteger showSectionBackground;
@property (nonatomic, strong) IBInspectable UIColor *sectionBackgroundColor;
@property (nonatomic, assign) IBInspectable CGFloat sectionBackgroundCornerRadius;
- (void)registerClassCell:(Class)cellClass;
- (void)registerNibCell:(Class)cellClass;
- (void)registerNibClassCell:(Class)cellClass;
@end

NS_ASSUME_NONNULL_END
