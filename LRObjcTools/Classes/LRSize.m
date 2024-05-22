
#import "LRSize.h"
#import <UIKit/UIKit.h>

CGFloat kStatusBarHeight = 20.0f;
CGFloat kNavigationBarHeight = 44.0f;
CGFloat kTabBarOffset = 0;
CGFloat kTabBarHeight = 49;
CGFloat kStatusBarOffset = 0;
CGFloat kFinalTopHeight = (20.0f + 44.0f);
CGFloat kUIWidth = 0.0f;
CGFloat kUIHeight = 0.0f;
BOOL kIsIPhoneX = NO;

@implementation LRSize

+ (void)configureUISize
{
    kIsIPhoneX = [self judgeIsIPhoneX];
    if (kIsIPhoneX) {
        kStatusBarHeight = AppWindow().safeAreaInsets.top;
        kNavigationBarHeight = 44.0f;
        kTabBarOffset = AppWindow().safeAreaInsets.bottom;
        kTabBarHeight = 49.0 + kTabBarOffset;
        kStatusBarOffset = kStatusBarHeight - 20;
        kFinalTopHeight = (kStatusBarHeight + kNavigationBarHeight);
    }else{
        kStatusBarHeight = 20.0f;
        kNavigationBarHeight = 44.0f;
        kTabBarOffset = 0;
        kTabBarHeight = 49.0;
        kStatusBarOffset = 0;
        kFinalTopHeight = (kStatusBarHeight + kNavigationBarHeight);
    }
    kUIWidth = [UIScreen mainScreen].bounds.size.width;
    kUIHeight = [UIScreen mainScreen].bounds.size.height;
}

UIWindow *AppWindow(void) {
    if (@available(iOS 16.0, *)) {
        UIWindowScene *scene = [UIApplication sharedApplication].connectedScenes.anyObject;
        UIWindow *window = scene.windows.firstObject;
        if (window) {
            return window;
        }
    } else if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        if (window) {
            return window;
        }
    }
    return [UIApplication sharedApplication].keyWindow;
}

+ (BOOL)judgeIsIPhoneX
{
    if (@available(iOS 11.0, *)) {
        return  AppWindow().safeAreaInsets.top > 0 || AppWindow().safeAreaInsets.bottom > 0;
    } else {
        return NO;
    }
}

BOOL kIsiPhone(void){
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return YES;
    }
    return NO;
}
BOOL kIsiPad(void){
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    }
    return NO;
}

BOOL IsIPhoneX(void){
    if (@available(iOS 11.0, *)) {
        return  AppWindow().safeAreaInsets.top > 0 || AppWindow().safeAreaInsets.bottom > 0;
    }
    return NO;
}

UIImage *ReSizeImage(UIImage *image, CGSize size)
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
