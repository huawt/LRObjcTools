#import "NSObject+Extension.h"
#import "NSObject+Swizzle.h"
#import <objc/runtime.h>
@implementation UILabel (Extension)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL sysInitSEL = @selector(init);
        SEL customInitSEL = @selector(initLR);
        [self instanceSwizzleSelector:customInitSEL originalSelector:sysInitSEL];
        SEL sysFrameSEL = @selector(initWithFrame:);
        SEL customFrameSEL = @selector(initWithFrameLR:);
        [self instanceSwizzleSelector:customFrameSEL originalSelector:sysFrameSEL];
        SEL sysNibSEL = @selector(awakeFromNib);
        SEL customNibSEL = @selector(awakeFromNibLR);
        [self instanceSwizzleSelector:customNibSEL originalSelector:sysNibSEL];
    });
}
- (instancetype)initLR {
    UILabel *label = [self initLR];
    label.adjustsFontSizeToFitWidth = true;
    label.minimumScaleFactor = 0.5;
    return label;
}
- (instancetype)initWithFrameLR:(CGRect)frame {
    UILabel *label = [self initWithFrameLR:frame];
    label.adjustsFontSizeToFitWidth = true;
    label.minimumScaleFactor = 0.5;
    return label;
}
- (void)awakeFromNibLR {
    [self awakeFromNibLR];
    self.adjustsFontSizeToFitWidth = true;
    self.minimumScaleFactor = 0.5;
}
+ (instancetype)labelText:(NSString *)text font:(UIFont *)font color:(UIColor *)color align:(NSTextAlignment)alignment lines:(CGFloat)lines {
    UILabel *label = [UILabel new];
    label.text = text;
    label.font = font;
    label.textColor = color;
    label.textAlignment = alignment;
    label.numberOfLines = lines;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    return label;
}
@end
@implementation NSString (Extension)
- (NSString *)currencyGrouped {
    if (self.integerValue < 1000) { return self; }
    NSNumberFormatter *form = [NSNumberFormatter new];
    form.numberStyle = NSNumberFormatterDecimalStyle;
    form.groupingSeparator = @",";
    form.decimalSeparator = @".";
    form.maximumFractionDigits = 2;
    form.groupingSize = 3;
    form.minimumFractionDigits = 0;
    if ([self hasSuffix:@".00"]) {
        form.minimumFractionDigits = 2;
    }
    NSNumber *number = [form numberFromString:self];
    if (number) {
        NSString *str = [form stringFromNumber:number];
        return str ? str : self;
    } else {
        return  self;
    }
}
- (NSString *)seperateBy: (NSInteger)length {
    NSInteger count = self.length / length;
    NSMutableArray *array = @[].mutableCopy;
    for (NSInteger index = 0; index < count; index++) {
        NSInteger start = index * length;
        NSString *str = [self substringWithRange: NSMakeRange(start, length)];
        [array addObject:str];
    }
    if (self.length % length > 0) {
        [array addObject: [self substringWithRange: NSMakeRange(count * length, self.length - count * length)]];
    }
    return [array componentsJoinedByString:@" "];
}
- (NSString *)seperateBy:(NSInteger)length sepeator:(NSString *)sepeator {
    NSString *string = [self seperateBy:length];
    return  [string stringByReplacingOccurrencesOfString:@" " withString:sepeator];
}
- (NSString *)lastString: (NSInteger)k {
    return self.length <= k ? self : [self substringFromIndex:self.length - k];
}
- (BOOL)isEmpty {
    if (self.length == 0) {
        return YES;
    }
    if ([self stringByReplacingOccurrencesOfString:@" " withString:@""].length == 0 ) {
        return YES;
    }
    if ([self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0) {
        return YES;
    }
    return NO;
}
+ (BOOL)isEmpty:(NSString *)aString {
    if (aString == nil) {
        return YES;
    }
    return [aString isEmpty];
}
- (BOOL)isValid {
    return ![self isEmpty];
}
+ (BOOL)isValid:(NSString *)aString {
    if (aString == nil) {
        return NO;
    }
    return [aString isValid];
}
+ (NSString *)fixEmptyString: (NSString *)aString {
    return [aString isValid] ? aString : @"-";
}
- (UIImage *)makeImage {
    return [UIImage imageNamed:self];
}
- (UIColor *)makeColor {
    return [UIColor hexStringColor:self] ;
}
@end
@implementation UIColor (Extension)
+ (instancetype)hexStringColor:(NSString *)hexStr {
    CGFloat r, g, b, a;
    if (lrHexStrToRGBA(hexStr, &r, &g, &b, &a)) {
        return [UIColor colorWithRed:r green:g blue:b alpha:a];
    }
    return nil;
}
static inline NSUInteger lrHexStrToInt(NSString *str) {
    uint32_t result = 0;
    sscanf([str UTF8String], "%X", &result);
    return result;
}
static BOOL lrHexStrToRGBA(NSString *str,
                         CGFloat *r, CGFloat *g, CGFloat *b, CGFloat *a) {
    str = [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([str hasPrefix:@"#"]) {
        str = [str substringFromIndex:1];
    } else if ([str hasPrefix:@"0X"]) {
        str = [str substringFromIndex:2];
    }
    NSUInteger length = [str length];
    if (length != 3 && length != 4 && length != 6 && length != 8) {
        return NO;
    }
    if (length < 5) {
        *r = lrHexStrToInt([str substringWithRange:NSMakeRange(0, 1)]) / 255.0f;
        *g = lrHexStrToInt([str substringWithRange:NSMakeRange(1, 1)]) / 255.0f;
        *b = lrHexStrToInt([str substringWithRange:NSMakeRange(2, 1)]) / 255.0f;
        if (length == 4)  *a = lrHexStrToInt([str substringWithRange:NSMakeRange(3, 1)]) / 255.0f;
        else *a = 1;
    } else {
        *r = lrHexStrToInt([str substringWithRange:NSMakeRange(0, 2)]) / 255.0f;
        *g = lrHexStrToInt([str substringWithRange:NSMakeRange(2, 2)]) / 255.0f;
        *b = lrHexStrToInt([str substringWithRange:NSMakeRange(4, 2)]) / 255.0f;
        if (length == 8) *a = lrHexStrToInt([str substringWithRange:NSMakeRange(6, 2)]) / 255.0f;
        else *a = 1;
    }
    return YES;
}
@end
@implementation UITextField (Extension)
- (void)fixOnlyNumber {
    NSCharacterSet *set = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray *array = [self.text componentsSeparatedByCharactersInSet:set];
    self.text = [array componentsJoinedByString:@""];
}
@end
@implementation UIImageView (Extension)
+ (UIImageView *)imageViewByImage: (NSString *)imageName {
    return  [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
}
@end
@implementation UIAlertController (Extension)
+ (UIAlertController *)sheetWithTitles:(NSArray *)titles handler:(void (^)(NSInteger))handler {
    return  [UIAlertController sheetWithTitles:titles cancel:@"Cancel" handler:handler];
}
+ (UIAlertController *)sheetWithTitles:(NSArray *)titles cancel:(NSString *)cancel handler:(void (^)(NSInteger))handler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSInteger index = 0; index < titles.count; index++) {
        NSString *title = titles[index];
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            !handler?:handler(index);
        }];
        [alert addAction:action];
    }
    NSString *cancelText = [cancel isValid] ? cancel : @"Cancel";
    UIAlertAction *action = [UIAlertAction actionWithTitle:cancelText style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:action];
    return  alert;
}
@end
static NSArray *LRControlDelayClasses;
@implementation UIControl (TimeDelay)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL sysSEL = @selector(sendAction:to:forEvent:);
        SEL customSEL = @selector(accept_sendAction:to:forEvent:);
        [self instanceSwizzleSelector:customSEL originalSelector:sysSEL];
    });
}
- (void)accept_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    if ([self checkCanPass]) {
        [self accept_sendAction:action to:target forEvent:event];
    } else {
        NSTimeInterval now = NSDate.date.timeIntervalSince1970;
        BOOL canSendAction = (now - self.limitEventTime >= self.eventInterval);
        if (canSendAction) {
            self.limitEventTime = now;
            [self accept_sendAction:action to:target forEvent:event];
        }else{
            return;
        }
    }
}
- (BOOL)checkCanPass {
    for (NSString *className in LRControlDelayClasses) {
        if ([self isKindOfClass:NSClassFromString(className)]) {
            return NO;
        }
    }
    return YES;
}
- (NSTimeInterval )eventInterval{
    NSNumber * time = objc_getAssociatedObject(self, "TimeDelay_eventInterval");
    if (time == nil) {
        objc_setAssociatedObject(self, "TimeDelay_eventInterval", @(1), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return 1;
    } else {
        return [time doubleValue];
    }
}
- (void)setEventInterval:(NSTimeInterval)eventInterval {
    objc_setAssociatedObject(self, "TimeDelay_eventInterval", @(eventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSTimeInterval )limitEventTime{
    return [objc_getAssociatedObject(self, "TimeDelay_limitEventTime") doubleValue];
}
- (void)setLimitEventTime:(NSTimeInterval)limitEventTime{
    objc_setAssociatedObject(self, "TimeDelay_limitEventTime", @(limitEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (void)registerDelayClass:(NSArray *)classNames {
    LRControlDelayClasses = classNames;
}
@end
@implementation UIButton (Extension)
- (void)beEnabled {
    self.userInteractionEnabled = YES;
}
- (void)beDisabled {
    self.userInteractionEnabled = NO;
    __weak typeof(self) ws = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __weak typeof(self) ss = ws;
        [ss beEnabled];
    });
}
@end
@implementation UIApplication (Extension)
- (NSString *)appDisplayName {
    NSString *text = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
    return [text isValid] ? text : @"";
}
- (NSString *)appBundleName {
    NSString *text = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
    return [text isValid] ? text : @"";
}
- (NSString *)appBundleIdentifier {
    NSString *text = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIdentifier"];
    return [text isValid] ? text : @"";
}
- (NSString *)appShortVersion {
    NSString *text = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    return [text isValid] ? text : @"";
}
- (NSString *)appBuildVersion {
    NSString *text = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    return [text isValid] ? text : @"";;
}
@end
@implementation UIView (Extension)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL sysSEL = @selector(layoutSubviews);
        SEL customSEL = @selector(layoutSubviewsLR);
        [self instanceSwizzleSelector:customSEL originalSelector:sysSEL];
    });
}
- (void)layoutSubviewsLR {
    [self layoutSubviewsLR];
    if (CGPointEqualToPoint(self.topCorners, CGPointZero) && CGPointEqualToPoint(self.bottomCorners, CGPointZero)) { return; }
    CGRect rect = self.bounds;
    CGFloat maxX = rect.size.width;
    CGFloat maxY = rect.size.height;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.topCorners.x)];
    [path addQuadCurveToPoint:CGPointMake(self.topCorners.x, 0) controlPoint:CGPointZero];
    [path addLineToPoint:CGPointMake(maxX - self.topCorners.y, 0)];
    [path addQuadCurveToPoint:CGPointMake(maxX, self.topCorners.y) controlPoint:CGPointMake(maxX, 0)];
    [path addLineToPoint:CGPointMake(maxX, maxY - self.bottomCorners.y)];
    [path addQuadCurveToPoint:CGPointMake(maxX - self.bottomCorners.y, maxY) controlPoint:CGPointMake(maxX, maxY)];
    [path addLineToPoint:CGPointMake(self.bottomCorners.x, maxY)];
    [path addQuadCurveToPoint:CGPointMake(0, maxY - self.bottomCorners.x) controlPoint:CGPointMake(0, maxY)];
    [path closePath];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    self.layer.mask = shapeLayer;
}
- (CGFloat)left {
    return self.frame.origin.x;
}
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)top {
    return self.frame.origin.y;
}
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}
- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}
- (CGFloat)width {
    return self.frame.size.width;
}
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)height {
    return self.frame.size.height;
}
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)centerX {
    return self.center.x;
}
- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}
- (CGFloat)centerY {
    return self.center.y;
}
- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}
- (CGPoint)origin {
    return self.frame.origin;
}
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (CGSize)size {
    return self.frame.size;
}
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (void)setDisplayed:(BOOL)displayed {
    self.hidden = !displayed;
}
- (BOOL)isDisplayed {
    return !self.hidden;
}
- (void)setTopCorners:(CGPoint)topCorners {
    objc_setAssociatedObject(self, "UIViewCustomTopCorners", [NSValue valueWithCGPoint:topCorners], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGPoint)topCorners {
    NSValue *value = objc_getAssociatedObject(self, "UIViewCustomTopCorners");
    if (value) {
        return [value CGPointValue];
    }
    return CGPointZero;
}
- (void)setBottomCorners:(CGPoint)bottomCorners {
    objc_setAssociatedObject(self, "UIViewCustomBottomCorners", [NSValue valueWithCGPoint:bottomCorners], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGPoint)bottomCorners {
    NSValue *value = objc_getAssociatedObject(self, "UIViewCustomBottomCorners");
    if (value) {
        return [value CGPointValue];
    }
    return CGPointZero;
}
- (void)dashedLine: (UIColor *)color thickness: (CGFloat)thickness spacing: (CGFloat)spacing length: (CGFloat)length {
    while (self.layer.sublayers.count) {
        [self.layer.sublayers.lastObject removeFromSuperlayer];
    }
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.lineWidth = thickness;
    shapeLayer.lineDashPattern = @[@(spacing), @(length)];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddLines(path, NULL, (const CGPoint[]){
        CGPointMake(0, CGRectGetHeight(self.bounds) / 2),
        CGPointMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) / 2)
    }, 2);
    shapeLayer.path = path;
    CGPathRelease(path);
    [self.layer insertSublayer:shapeLayer atIndex:0];
}
- (void)createTagsViewWithTags: (NSArray<NSString *> *)tags attributes: (NSDictionary<NSAttributedStringKey, id> *)attributes insets:(CGFloat)insets lineHeight: (CGFloat)lineHeight lineSpace: (CGFloat)lineSpace itemSpace: (CGFloat)itemSpace cornerRadius: (CGFloat)radius maxWidth: (CGFloat)maxWidth {
    if (tags.count > 0) {
        CGFloat maxHeight = 0;
        CGFloat originX = 0;
        CGFloat originY = 0;
        CGFloat minWidth = 12;
        CGFloat textHeight = [@" " boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine) attributes:attributes context:nil].size.height;
        for (NSString *tag in tags) {
            UIFont *font = attributes[NSFontAttributeName];
            if (font) {
                minWidth = font.pointSize;
            }
            UIButton *button = [UIButton buttonWithType:0];
            button.userInteractionEnabled = NO;
            button.backgroundColor = attributes[NSBackgroundColorAttributeName];
            [button setTitle:tag forState:0];
            [button setTitleColor:attributes[NSForegroundColorAttributeName] forState:0];
            button.titleLabel.font = font;
            button.titleLabel.numberOfLines = 0;
            button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            button.layer.borderColor = [attributes[NSStrokeColorAttributeName] CGColor];
            button.layer.borderWidth = [attributes[NSStrokeWidthAttributeName] floatValue];
            button.layer.cornerRadius = radius;
            button.clipsToBounds = radius > 0;
            button.contentEdgeInsets = UIEdgeInsetsMake(0, insets, 0, insets);
            NSMutableDictionary *mulAttributes = [attributes mutableCopy];
            if (mulAttributes[NSParagraphStyleAttributeName] == nil) {
                NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
                style.lineBreakMode = NSLineBreakByWordWrapping;
                mulAttributes[NSParagraphStyleAttributeName] = style;
            }
            CGSize size = [tag boundingRectWithSize:CGSizeMake(maxWidth - insets * 2, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine) attributes:mulAttributes context:nil].size;
            CGFloat labelWidth = MAX(size.width, minWidth) + insets * 2;
            CGFloat labelHeight = MAX(lineHeight, size.height + (lineHeight - textHeight));
             if (originX + labelWidth + itemSpace > maxWidth) {
                 originY += lineHeight + lineSpace;
                 originX = 0;
            }
            button.frame = CGRectMake(originX, originY, labelWidth, labelHeight);
            button.contentHorizontalAlignment = labelHeight > lineHeight ? UIControlContentHorizontalAlignmentLeft : UIControlContentHorizontalAlignmentCenter;
            [self addSubview:button];
            originX += labelWidth + itemSpace;
            originY += labelHeight - lineHeight;
            maxHeight = MAX(maxHeight, CGRectGetMaxY(button.frame));
        }
        self.frame = CGRectMake(self.left, self.top, self.width, maxHeight);
        for (NSLayoutConstraint *c in self.constraints) {
            if (c.firstAnchor == self.heightAnchor) {
                c.constant = maxHeight;
            }
        }
    }
}
@end
@implementation CALayer (Extension)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL sysSEL = @selector(display);
        SEL customSEL = @selector(displayLR);
        [self instanceSwizzleSelector:customSEL originalSelector:sysSEL];
    });
}
- (void)displayLR {
    if (self.frame.size.width * self.frame.size.height == 0) {
        return;
    }
    [self displayLR];
}
@end
