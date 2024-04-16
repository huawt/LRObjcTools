

#import "LRBaseViewController.h"

@interface LRBaseViewController ()

@end

@implementation LRBaseViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.statusBarStyle == LRStatusBarStyle_Light) {
        return UIStatusBarStyleLightContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

+ (instancetype)controllerByStoryBoard:(NSString *)storyBoardName {
    return [[UIStoryboard storyboardWithName:storyBoardName bundle: [NSBundle mainBundle]] instantiateViewControllerWithIdentifier: [self identifer]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)navigationLeftAction {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:true completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:true];
    }
}
- (void)present:(UIViewController *)viewController animated:(BOOL)flag {
    [self presentViewController:viewController animated:flag completion:nil];
}

+ (NSString *)identifer {
    return [NSStringFromClass([self class]) componentsSeparatedByString:@"."].lastObject;
}
@end
