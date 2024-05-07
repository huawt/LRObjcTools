#import "LRHostManager.h"
#import "NSObject+Extension.h"
@interface LRHostManager ()
@property (nonatomic, copy, readwrite) NSString *validHost;
@property (nonatomic, strong) NSArray *hosts;
@property (nonatomic, assign) NSInteger retryTimes;
@property (nonatomic, copy) NSString *hostKey;
@end
@implementation LRHostManager
+ (instancetype)shared {
    static id _singleInstance_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleInstance_ = [[self alloc] init];
    });
    return _singleInstance_;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadHost];
    }
    return self;
}
- (void)loadHost {
    NSString *host = [[NSUserDefaults standardUserDefaults] objectForKey:self.hostKey];
    if ([host isValid]) {
        self.validHost = host;
    }
    if ([NSString isEmpty:self.validHost] && self.hosts.count > 0) {
        self.validHost = self.hosts.firstObject;
    }
}
+ (void)registerHosts:(NSArray *)hosts {
    [LRHostManager shared].hosts = hosts;
    if ([NSString isEmpty:[LRHostManager shared].validHost]) {
        [[LRHostManager shared] loadHost];
    }
}
+ (void)checkHost:(NSString *)currentUrl completion:(void (^)(BOOL))completion {
    if ([LRHostManager shared].retryTimes >= [LRHostManager shared].hosts.count) {
        [LRHostManager shared].retryTimes = 0;
        !completion?:completion(NO);
        return;
    }
    NSString *old = [LRHostManager shared].validHost;
    if ([currentUrl containsString:old] || [old isEmpty]) {
        [LRHostManager shared].retryTimes += 1;
        NSString *new = [[LRHostManager shared].hosts objectAtIndex:([LRHostManager shared].retryTimes % [LRHostManager shared].hosts.count)];
        if ([new isEmpty]) {
            [LRHostManager checkHost:currentUrl completion:completion];
        } else {
            [LRHostManager shared].validHost = new;
            !completion?:completion(YES);
        }
    } else {
        !completion?:completion(YES);
    }
}
+ (void)hostSuccess {
    [LRHostManager shared].retryTimes = 0;
}
- (void)setValidHost:(NSString *)validHost {
    _validHost = validHost;
    if ([validHost isValid]) {
        [[NSUserDefaults standardUserDefaults] setObject:validHost forKey:[LRHostManager shared].hostKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
- (NSString *)hostKey {
    if (!_hostKey) {
        NSString *key = @"LRHostManager - validHost - key";
        NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary;
        NSString *identifier = [infoDict objectForKey:@"CFBundleIdentifier"];
        if ([NSString isValid:identifier]) {
            key = [NSString stringWithFormat:@"%@-validHost-key", identifier];
        }
        _hostKey = key;
    }
    return _hostKey;
}
@end
