
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LRBaseTableView : UITableView

- (void)registerClassCell:(Class)cellClass;
- (void)registerNibCell:(Class)cellClass;

@end

NS_ASSUME_NONNULL_END
