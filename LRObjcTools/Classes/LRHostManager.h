
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LRHostManager : NSObject
@property (nonatomic, copy, readonly) NSString *validHost;
+ (instancetype)shared;
+ (void)checkHost: (NSString *)currentUrl completion: (void(^)(BOOL granted))completion;
+ (void)registerHosts: (NSArray *)hosts;
@end

NS_ASSUME_NONNULL_END
