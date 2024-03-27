#import "NSObject+Swizzle.h"
#import <objc/runtime.h>
@implementation NSObject (Swizzle)
+ (void)instanceSwizzleSelector:(SEL)swizzledSelector originalSelector:(SEL)originalSelector {
    Class klass = [self class];
    Method originalMethod = class_getInstanceMethod(klass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(klass, swizzledSelector);
    BOOL success = class_addMethod(klass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(klass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
+ (void)classSwizzleSelector:(SEL)swizzledSelector originalSelector:(SEL)originalSelector {
    Class klass = [self class];
    Method originalMethod = class_getClassMethod(klass, originalSelector);
    Method swizzledMethod = class_getClassMethod(klass, swizzledSelector);
    Class metaClass = object_getClass(klass);
    BOOL success = class_addMethod(metaClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(metaClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end
