#import "LRPlaceholderTextView.h"
@interface LRPlaceholderTextView ()
@property (nonatomic, strong) UILabel *placeholderLabel;
@end
@implementation LRPlaceholderTextView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self configUI];
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self configUI];
    }
    return  self;
}
- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer {
    self = [super initWithFrame:frame textContainer:textContainer];
    if (self) {
        [self configUI];
    }
    return  self;
}
- (void)addObserve {
    __weak typeof(self) ws = self;
    [[NSNotificationCenter defaultCenter] addObserverForName:UITextViewTextDidChangeNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull notification) {
        __strong typeof(self) ss = ws;
        ss.placeholderLabel.alpha = ss.hasText ? 0 : 1;
    }];
}
- (void)configUI {
    [self addObserve];
    [self addSubview:self.placeholderLabel];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.placeholderLabel.alpha = self.hasText ? 0 : 1;
    self.placeholderLabel.frame = CGRectMake(self.contentInset.left + 5, self.contentInset.top + 8, self.placeholderLabel.bounds.size.width, self.placeholderLabel.bounds.size.height);
}
- (void)setTextColor:(UIColor *)textColor {
    [super setTextColor:textColor];
    self.tintColor = textColor;
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}
- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
    [self.placeholderLabel sizeToFit];
}
- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    _placeholderFont = placeholderFont;
    self.placeholderLabel.font = placeholderFont;
    [self.placeholderLabel sizeToFit];
}
- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc] init];
        _placeholderLabel.font = [UIFont systemFontOfSize:14];
        _placeholderLabel.textColor = [UIColor clearColor];
        _placeholderLabel.alpha = 0;
    }
    return _placeholderLabel;
}
@end
