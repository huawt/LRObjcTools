#import "LRObjcTools.h"
#import <WebKit/WebKit.h>
void LRMainAfter(CGFloat time, dispatch_block_t executed) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        !executed?:executed();
    });
}
void LRMainQueue(dispatch_block_t executed) {
    dispatch_async(dispatch_get_main_queue(), ^{
        !executed?:executed();
    });
}
@implementation LRObjcTools
+ (void)clearWebViewCache {
    NSSet *websiteDataTypes = [NSSet setWithArray:@[
            WKWebsiteDataTypeDiskCache,
            WKWebsiteDataTypeMemoryCache,
            WKWebsiteDataTypeCookies,
            WKWebsiteDataTypeSessionStorage,
            WKWebsiteDataTypeLocalStorage,
            WKWebsiteDataTypeWebSQLDatabases,
            WKWebsiteDataTypeIndexedDBDatabases
        ]];
    [[WKWebsiteDataStore defaultDataStore] fetchDataRecordsOfTypes:websiteDataTypes completionHandler:^(NSArray<WKWebsiteDataRecord *> * _Nonnull records) {
        if (records.count > 0) {
            [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes forDataRecords:records completionHandler:^{ }];
        }
    }];
}
@end
