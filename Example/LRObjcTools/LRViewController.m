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
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
