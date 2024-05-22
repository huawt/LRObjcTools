
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

extern CGFloat kStatusBarHeight;
extern CGFloat kNavigationBarHeight;
extern CGFloat kTabBarOffset;
extern CGFloat kTabBarHeight;
extern CGFloat kStatusBarOffset;
extern CGFloat kFinalTopHeight;
extern CGFloat kUIWidth;
extern CGFloat kUIHeight;
extern BOOL kIsIPhoneX;

NS_ASSUME_NONNULL_BEGIN

@interface LRSize : NSObject
+ (void)configureUISize;
+ (BOOL)judgeIsIPhoneX;
BOOL kIsiPhone(void);
BOOL kIsiPad(void);
BOOL IsIPhoneX(void);
UIImage *ReSizeImage(UIImage *image, CGSize size);
@end

NS_ASSUME_NONNULL_END
