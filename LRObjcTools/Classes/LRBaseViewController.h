
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, LRStatusBarStyle) {
    LRStatusBarStyle_Dark = 0,
    LRStatusBarStyle_Light = 1,
};

@interface LRBaseViewController : UIViewController

@property (nonatomic, assign) LRStatusBarStyle statusBarStyle;

+ (instancetype)controllerByStoryBoard: (NSString *)storyBoardName;

- (void)navigationLeftAction;

- (void)present:(UIViewController *)viewController animated:(BOOL)flag;

+ (NSString *)identifer;
@end

NS_ASSUME_NONNULL_END
