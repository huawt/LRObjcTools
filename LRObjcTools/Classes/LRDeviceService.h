
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AVFoundation/AVFoundation.h>
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>

NS_ASSUME_NONNULL_BEGIN

@interface LRDeviceService : NSObject

+ (BOOL)cameraOpen;
+ (AVAuthorizationStatus)cameraStatus;
+ (void)cameraRequest: (void(^)(BOOL granted))handler;

+ (BOOL)locationOpen;
+ (CLAuthorizationStatus)locationStatus;
+ (void)locationRequest: (void(^)(BOOL granted))handler;

+ (BOOL)ctOpen;
+ (CNAuthorizationStatus)ctStatus;
+ (void)ctRequest: (void(^)(BOOL granted))handler;

+ (void)goSettingPage;
@end

NS_ASSUME_NONNULL_END
