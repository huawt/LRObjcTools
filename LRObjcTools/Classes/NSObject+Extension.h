#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIView (Extension)
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize  size;
@property (nonatomic, getter = isDisplayed) BOOL  displayed;
@property (nonatomic, assign) IBInspectable CGPoint topCorners;
@property (nonatomic, assign) IBInspectable CGPoint bottomCorners;
- (void)dashedLine: (UIColor *)color thickness: (CGFloat)thickness spacing: (CGFloat)spacing length: (CGFloat)length;
@end
@interface UILabel (Extension)
+ (instancetype)labelText: (NSString *)text font: (UIFont*)font color: (UIColor *)color align: (NSTextAlignment)alignment lines: (CGFloat)lines;
@end
@interface UIColor (Extension)
+ (instancetype)hexStringColor:(NSString *)hexStr;
@end
@interface NSString (Extension)
- (NSString *)currencyGrouped;
- (NSString *)seperateBy: (NSInteger)length;
- (NSString *)seperateBy: (NSInteger)length sepeator: (NSString *)sepeator;
- (NSString *)lastString: (NSInteger)k;
- (BOOL)isValid;
+ (BOOL)isValid: (NSString *)aString;
- (BOOL)isEmpty;
+ (BOOL)isEmpty:(NSString *)aString;
+ (NSString *)fixEmptyString: (NSString *)aString;
- (UIImage *)makeImage;
- (UIColor *)makeColor;
@end
@interface UITextField (Extension)
- (void)fixOnlyNumber;
@end
@interface UIImageView (Extension)
+ (UIImageView *)imageViewByImage: (NSString *)imageName;
@end
@interface UIAlertController (Extension)
+ (UIAlertController *)sheetWithTitles: (NSArray *)titles handler: (void(^)(NSInteger index))handler;
+ (UIAlertController *)sheetWithTitles: (NSArray *)titles cancel: (NSString *)cancel handler: (void(^)(NSInteger index))handler;
@end
@interface UIControl (TimeDelay)
@property (nonatomic, assign) NSTimeInterval eventInterval;
+ (void)registerDelayClass: (NSArray *)classNames;
@end
@interface UIButton (Extension)
- (void)beEnabled;
- (void)beDisabled;
@end
@interface UIApplication (Extension)
@property (nonatomic, copy, readonly) NSString *appDisplayName;
@property (copy, nonatomic, readonly) NSString *appBundleName;
@property (copy, nonatomic, readonly) NSString *appBundleIdentifier;
@property (copy, nonatomic, readonly) NSString *appShortVersion;
@property (copy, nonatomic, readonly) NSString *appBuildVersion;
@end
@interface CALayer (Extension)
@end
NS_ASSUME_NONNULL_END
