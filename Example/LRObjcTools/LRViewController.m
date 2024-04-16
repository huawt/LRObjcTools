//
//  LRViewController.m
//  LRObjcTools
//
//  Created by huawt on 03/16/2024.
//  Copyright (c) 2024 huawt. All rights reserved.
//

#import "LRViewController.h"
#import <LRObjcTools/LRObjcTools.h>

@interface LRViewController ()

@end

@implementation LRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    LRBaseTextField *textf = [[LRBaseTextField alloc] initWithFrame:CGRectMake(10, 100, 200, 50)];
    textf.placeholderFont = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    textf.placeholder = @"test-test";
    textf.placeholderColor = [UIColor yellowColor];
    [self.view addSubview:textf];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
