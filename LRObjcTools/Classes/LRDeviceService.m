#import "LRDeviceService.h"
@interface LRDeviceService ()
@end
@implementation LRDeviceService
+ (BOOL)cameraOpen {
    return [LRDeviceService cameraStatus] == AVAuthorizationStatusAuthorized;
}
+ (AVAuthorizationStatus)cameraStatus {
    return [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
}
+ (void)cameraRequest: (void(^)(BOOL granted))handler {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            !handler?:handler(granted);
        });
    }];
}
+ (BOOL)locationOpen {
    return [LRDeviceService locationStatus] == kCLAuthorizationStatusAuthorizedAlways || [LRDeviceService locationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse;
}
+ (CLAuthorizationStatus)locationStatus {
    return [CLLocationManager authorizationStatus];
}
+ (void)locationRequest: (void(^)(BOOL granted))handler {
    CLLocationManager *manger = [CLLocationManager new];
    [manger requestWhenInUseAuthorization];
    [manger requestAlwaysAuthorization];
    dispatch_async(dispatch_get_main_queue(), ^{
        !handler?:handler(NO);
    });
}
+ (BOOL)ctOpen {
    return [LRDeviceService ctStatus] == CNAuthorizationStatusAuthorized;
}
+ (CNAuthorizationStatus)ctStatus {
    return [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
}
+ (void)ctRequest: (void(^)(BOOL granted))handler {
    [[CNContactStore new] requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            !handler?:handler(granted);
        });
    }];
}
+ (void)goSettingPage {
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}
@end
