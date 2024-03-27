
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Extension)
+ (instancetype)labelText: (NSString *)text font: (UIFont*)font color: (UIColor *)color align: (NSTextAlignment)alignment lines: (CGFloat)lines;
@end

@interface NSString (Extension)
- (NSString *)currencyGrouped;
- (NSString *)seperateBy: (NSInteger)length;
- (NSString *)lastString: (NSInteger)k;
- (BOOL)isValid;
- (BOOL)isEmpty;
+ (NSString *)fixEmptyString: (NSString *)aString;
- (UIImage *)makeImage;
@end

@interface UITextField (Extension)
- (void)fixOnlyNumber;
@end

@interface UIImageView (Extension)
+ (UIImageView *)imageViewByImage: (NSString *)imageName;
@end

@interface UIAlertController (Extension)
+ (UIAlertController *)sheetWithTitles: (NSArray *)titles handler: (void(^)(NSInteger index))handler;
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
@end
NS_ASSUME_NONNULL_END
