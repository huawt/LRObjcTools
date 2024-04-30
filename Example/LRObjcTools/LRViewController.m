#import "LRViewController.h"
#import <LRObjcTools/LRObjcTools.h>
@interface LRViewController ()
@property (weak, nonatomic) IBOutlet LRSlider *slider;
@end
@implementation LRViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.slider.showCurrentValue = YES;
    self.slider.currentValueFormatHandler = ^NSString * _Nonnull(CGFloat currentValue) {
        return  [NSString stringWithFormat:@"%.0f", currentValue];
    };
    
    LRLayoutButton *button = [LRLayoutButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(100, 400, 100, 50);
    [button timeCountDown:10 display:@"resend"];
    [self.view addSubview:button];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
