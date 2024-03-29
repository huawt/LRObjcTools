
#import "LRBaseNavigationBar.h"

@interface LRBaseNavigationBar ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIStackView *buttonContainer;
@property (nonatomic, strong) UIView *leftBack;
@property (nonatomic, strong) UIView *rightBack;
@end

@implementation LRBaseNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.buttonContainer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = CGRectMake(0, self.bounds.size.height - 44, self.bounds.size.width, 44);
    self.titleLabel.frame = self.contentView.bounds;
    self.buttonContainer.frame = self.contentView.bounds;
}

- (void)setNavigationLeft:(nonnull UIView *)barButton {
    [self.leftBack.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    barButton.frame = CGRectMake(16, 0, barButton.bounds.size.width, 44);
    [self.leftBack addSubview:barButton];
}

- (void)setNavigationRight:(nonnull UIView *)barButton {
    [self.rightBack.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    barButton.frame = CGRectMake(self.rightBack.bounds.size.width - barButton.bounds.size.width - 16, 0, barButton.bounds.size.width, 44);
    [self.rightBack addSubview:barButton];
}

- (void)setNavigationBarTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setNavigationBarTitleFont:(UIFont *)font {
    self.titleLabel.font = font;
}

- (void)setNavigationBarTitleColor:(UIColor *)titleColor {
    self.titleLabel.textColor = titleColor;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = UIColor.whiteColor;
        _titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = UIColor.clearColor;
    }
    return _contentView;
}

- (UIStackView *)buttonContainer {
    if (!_buttonContainer) {
        _buttonContainer = [UIStackView new];
        _buttonContainer.axis = UILayoutConstraintAxisHorizontal;
        _buttonContainer.distribution = UIStackViewDistributionFillEqually;
        _buttonContainer.backgroundColor = [UIColor clearColor];
        [_buttonContainer addArrangedSubview:self.leftBack];
        [_buttonContainer addArrangedSubview:self.rightBack];
    }
    return _buttonContainer;
}

- (UIView *)leftBack {
    if (!_leftBack) {
        _leftBack = [UIView new];
        _leftBack.backgroundColor = [UIColor clearColor];
    }
    return _leftBack;
}
- (UIView *)rightBack {
    if (!_rightBack) {
        _rightBack = [UIView new];
        _rightBack.backgroundColor = [UIColor clearColor];
    }
    return _rightBack;
}
@end
