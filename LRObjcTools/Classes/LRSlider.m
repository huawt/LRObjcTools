
#import "LRSlider.h"

@interface LRSlider ()
@property (nonatomic, strong) UIView *currentValueView;
@property (nonatomic, strong) UIImageView *currentValueImage;
@property (nonatomic, strong) UILabel *currentValueLabel;
@end

@implementation LRSlider

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.currentValueView];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self addSubview:self.currentValueView];
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addSubview:self.currentValueView];
    }
    return self;
}
- (CGRect)trackRectForBounds:(CGRect)bounds {
    CGRect rect = [super trackRectForBounds:bounds];
    if (self.trackHeight > 0) {
        rect.size.height = self.trackHeight;
    }
    return rect;
}

- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value {
    CGRect thumbRect = [super thumbRectForBounds:bounds trackRect:rect value:value];
    if (self.showCurrentValue) {
        CGRect frame = CGRectMake(CGRectGetMidX(thumbRect) - 58 / 2, CGRectGetMinY(thumbRect) - 30, 58, 26);
        if (frame.origin.x < 0) {
            frame.origin.x = 0;
        }
        if (CGRectGetMaxX(frame) > bounds.size.width) {
            frame.origin.x = bounds.size.width - 58;
        }
        self.currentValueView.frame = frame;
        if (self.currentValueFormatHandler) {
            self.currentValueLabel.text = self.currentValueFormatHandler(value);
        } else {
            self.currentValueLabel.text = @(value).stringValue;
        }
    }
    return thumbRect;
}

- (void)setTrackImage:(UIImage *)trackImage {
    _trackImage = trackImage;
    if (trackImage) {
        [self setThumbImage:trackImage forState:UIControlStateNormal];
        [self setThumbImage:trackImage forState:UIControlStateHighlighted];
    }
}

- (void)setShowCurrentValue:(BOOL)showCurrentValue {
    _showCurrentValue = showCurrentValue;
    self.currentValueView.hidden = !showCurrentValue;
}

- (void)setCurrentValueFont:(UIFont *)currentValueFont {
    _currentValueFont = currentValueFont;
    if (currentValueFont) {
        self.currentValueLabel.font = currentValueFont;
    }
}

- (void)setCurrentValueColor:(UIColor *)currentValueColor {
    _currentValueColor = currentValueColor;
    if (currentValueColor) {
        self.currentValueLabel.textColor = currentValueColor;
    }
}

- (void)setCurrentValueBackgroundImage:(UIImage *)currentValueBackgroundImage {
    _currentValueBackgroundImage = currentValueBackgroundImage;
    if (currentValueBackgroundImage) {
        self.currentValueImage.image = currentValueBackgroundImage;
    }
}

- (UIView *)currentValueView {
    if (!_currentValueView) {
        _currentValueView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 58, 26)];
        _currentValueView.backgroundColor = [UIColor clearColor];
        _currentValueView.hidden = YES;
        [_currentValueView addSubview:self.currentValueImage];
        [_currentValueView addSubview:self.currentValueLabel];
    }
    return _currentValueView;
}

- (UIImageView *)currentValueImage {
    if (!_currentValueImage) {
        _currentValueImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 58, 26)];
    }
    return _currentValueImage;
}
- (UILabel *)currentValueLabel {
    if (!_currentValueLabel) {
        _currentValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 58, 22)];
        _currentValueLabel.textAlignment = NSTextAlignmentCenter;
        _currentValueLabel.font = [UIFont systemFontOfSize:12];
        _currentValueLabel.adjustsFontSizeToFitWidth = YES;
        _currentValueLabel.minimumScaleFactor = 0.5;
    }
    return _currentValueLabel;
}

@end
