#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface LRBaseTextField : UITextField
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;
@property (nonatomic, strong) UIFont *placeholderFont;
@property (nonatomic, copy) IBInspectable NSString *placeholderFontString;
@end
NS_ASSUME_NONNULL_END
