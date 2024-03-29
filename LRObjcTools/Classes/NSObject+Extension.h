
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UIView (Extension)
@property (nonatomic) CGFloat left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  size;        ///< Shortcut for frame.size.
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
- (NSString *)lastString: (NSInteger)k;
- (BOOL)isValid;
- (BOOL)isEmpty;
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



@interface CALayer (Extension)

@end
NS_ASSUME_NONNULL_END
