#import <UIKit/UIKit.h>
FOUNDATION_EXPORT double StepSliderVersionNumber;
FOUNDATION_EXPORT const unsigned char StepSliderVersionString[];
typedef NS_ENUM(NSUInteger, StepSliderTextOrientation) {
    StepSliderTextOrientationDown,
    StepSliderTextOrientationUp,
};
IB_DESIGNABLE
@interface LRStepSlider : UIControl
@property (nonatomic) IBInspectable NSUInteger maxCount;
@property (nonatomic) IBInspectable NSUInteger index;
@property (nonatomic) IBInspectable CGFloat trackHeight;
@property (nonatomic) IBInspectable CGFloat trackCircleRadius;
@property (nonatomic) IBInspectable CGFloat sliderCircleRadius;
@property (nonatomic, getter=isDotsInteractionEnabled) IBInspectable BOOL dotsInteractionEnabled;
@property (nonatomic, strong) IBInspectable UIColor *trackColor;
@property (nonatomic, strong) IBInspectable UIColor *sliderCircleColor;
@property (nonatomic, strong) IBInspectable UIImage *sliderCircleImage;
@property (nonatomic, strong) NSArray *labels;
@property (nonatomic, strong) UIFont *labelFont;
@property (nonatomic, strong) IBInspectable UIColor *labelColor;
@property (nonatomic) IBInspectable CGFloat labelOffset;
@property (nonatomic) StepSliderTextOrientation labelOrientation;
@property (nonatomic) IBInspectable BOOL adjustLabel;
@property (nonatomic) IBInspectable BOOL enableHapticFeedback;
- (void)setIndex:(NSUInteger)index animated:(BOOL)animated;
- (void)setTrackCircleImage:(UIImage *)image forState:(UIControlState)state;
@end
