
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LRSlider : UISlider
@property (nonatomic, assign) IBInspectable NSInteger trackHeight;
@property (nonatomic, strong) IBInspectable UIImage *trackImage;
@property (nonatomic, assign) BOOL showCurrentValue;
@property (nonatomic, strong) UIFont *currentValueFont;
@property (nonatomic, strong) IBInspectable UIColor *currentValueColor;
@property (nonatomic, strong) IBInspectable UIImage *currentValueBackgroundImage;
@property (nonatomic, copy) NSString *(^currentValueFormatHandler)(CGFloat currentValue);
@end

NS_ASSUME_NONNULL_END
