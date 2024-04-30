#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, LRLayoutButtonType) {
    LRLayoutButtonType_LeftImageRightTitle = 0,
    LRLayoutButtonType_LeftTitleRightImage = 1,
    LRLayoutButtonType_UpImageDownTitle = 2,
    LRLayoutButtonType_UpTitleDownImage = 3,
};
@interface LRLayoutButton : UIButton
@property (nonatomic, assign) LRLayoutButtonType layoutType;
@property (nonatomic, assign) IBInspectable NSInteger layoutTypeValue;
@property (nonatomic, assign) IBInspectable CGFloat spacing;
- (void)timeCountDown: (NSInteger)second display: (NSString *)title;
@end
NS_ASSUME_NONNULL_END
