#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSObject (Swizzle)
+ (void)instanceSwizzleSelector:(SEL)swizzledSelector originalSelector:(SEL)originalSelector;
+ (void)classSwizzleSelector:(SEL)swizzledSelector originalSelector:(SEL)originalSelector;
@end
NS_ASSUME_NONNULL_END
