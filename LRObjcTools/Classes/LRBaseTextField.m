
#import "LRBaseTextField.h"
#import "NSObject+Extension.h"

@implementation LRBaseTextField
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    if (placeholderColor == nil) return;
    if ([NSString isValid:self.placeholder]) {
        if (self.attributedPlaceholder) {
            NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedPlaceholder];
            [att addAttributes:@{NSForegroundColorAttributeName: placeholderColor} range:NSMakeRange(0, self.attributedPlaceholder.length)];
            self.attributedPlaceholder = att;
        } else {
            NSAttributedString *att = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName: placeholderColor}];
            self.attributedPlaceholder = att;
        }
    }
}
- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    _placeholderFont = placeholderFont;
    if (placeholderFont == nil) return;
    if ([NSString isValid:self.placeholder]) {
        if (self.attributedPlaceholder) {
            NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedPlaceholder];
            [att addAttributes:@{NSFontAttributeName: placeholderFont} range:NSMakeRange(0, self.attributedPlaceholder.length)];
            self.attributedPlaceholder = att;
        } else {
            NSAttributedString *att = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSFontAttributeName: placeholderFont}];
            self.attributedPlaceholder = att;
        }
    }
}
- (void)setPlaceholder:(NSString *)placeholder {
    [super setPlaceholder:placeholder];
    if ([NSString isValid:placeholder]) {
        NSMutableDictionary *dictionary = @{}.mutableCopy;
        if (self.placeholderColor) {
            [dictionary setObject:self.placeholderColor forKey:NSForegroundColorAttributeName];
        }
        if (self.placeholderFont) {
            [dictionary setObject:self.placeholderFont forKey:NSFontAttributeName];
        }
        if (dictionary.count) {
            NSAttributedString *att = [[NSAttributedString alloc] initWithString:placeholder attributes:dictionary];
            self.attributedPlaceholder = att;
        }
    }
}
- (void)setPlaceholderFontString:(NSString *)placeholderFontString {
    _placeholderFontString = placeholderFontString;
    NSArray<NSString *> *params = [placeholderFontString componentsSeparatedByString:@"##"];
    if (params.count != 2) { return; }
    UIFont *font = [UIFont fontWithName:params.firstObject size:params.lastObject.floatValue];
    self.placeholderFont = font;
}
@end
