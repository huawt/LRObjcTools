#import "LRViewController.h"
#import <LRObjcTools/LRObjcTools.h>
@interface LRViewController ()
@property (weak, nonatomic) IBOutlet LRSlider *slider;
@property (weak, nonatomic) IBOutlet UIView *cornerView;
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

    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 300, 10)];
    [v createTagsViewWithTags:@[@"123", @"123123123123123", @"123312312312312312312312312312312312312312312312123123", @"12312323123", @"12323123", @"1231123", @"123123123"] attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:12], NSForegroundColorAttributeName: UIColor.redColor, NSBackgroundColorAttributeName: UIColor.blueColor, NSStrokeColorAttributeName: UIColor.blackColor, NSStrokeWidthAttributeName: @(1)} insets:10 lineHeight:20 lineSpace:8 itemSpace:15 cornerRadius:10 maxWidth:300];
    v.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:v];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
