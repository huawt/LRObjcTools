
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
    self.placeholderLabel = [[UILabel alloc] init];
    self.placeholderLabel.font = [UIFont systemFontOfSize:14];
    self.placeholderLabel.textColor = [UIColor clearColor];
    self.placeholderLabel.alpha = 0;
    [self addSubview:self.placeholderLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.placeholderLabel.alpha = self.hasText ? 0 : 1;
    self.placeholderLabel.frame = CGRectMake(self.contentInset.left + 5, self.contentInset.top + 8, self.placeholderLabel.bounds.size.width, self.placeholderLabel.bounds.size.height);
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.placeholderLabel.font = font;
    [self.placeholderLabel sizeToFit];
    [self layoutIfNeeded];
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
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    _placeholderFont = placeholderFont;
    self.placeholderLabel.font = placeholderFont;
    [self.placeholderLabel sizeToFit];
    [self layoutIfNeeded];
}

@end
