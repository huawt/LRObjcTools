
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LRBaseNavigationBar : UIView
- (void)setNavigationLeft: (UIView *)barButton;
- (void)setNavigationRight:(UIView *)barButton;
- (void)setNavigationBarTitle: (NSString *)title;
- (void)setNavigationBarTitleFont: (UIFont *)font;
- (void)setNavigationBarTitleColor: (UIColor *)titleColor;

@end

NS_ASSUME_NONNULL_END
