

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LRPlaceholderTextView : UITextView

@property (nonatomic, copy) IBInspectable NSString *placeholder;
@property (nonatomic, strong) IBInspectable UIColor *placeholderColor;
@property (nonatomic, strong) IBInspectable UIFont *placeholderFont;
@end

NS_ASSUME_NONNULL_END
