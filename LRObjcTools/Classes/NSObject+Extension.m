
#import "NSObject+Extension.h"
#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

@implementation UILabel (Extension)
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
- (BOOL)isValid {
    return ![self isEmpty];
}

+ (NSString *)fixEmptyString: (NSString *)aString {
    return [aString isValid] ? aString : @"-";
}

- (UIImage *)makeImage {
    return [UIImage imageNamed:self];
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
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSInteger index = 0; index < titles.count; index++) {
        NSString *title = titles[index];
        UIAlertAction *action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            !handler?:handler(index);
        }];
        [alert addAction:action];
    }
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
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
}
@end

@implementation UIApplication (Extension)
- (NSString *)appDisplayName {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}
@end
