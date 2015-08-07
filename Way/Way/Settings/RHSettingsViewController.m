//
//  RHSettingsViewController.m
//  Way
//
//  Created by zhuruhong on 15/8/4.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHSettingsViewController.h"
#import "RHSettingsView.h"

@interface RHSettingsViewController ()
{
    RHSettingsView *_settingsView;
}

@end

@implementation RHSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"title";
    self.navigationItem.backBarButtonItem = [self backBarButtonItem];
    
    _settingsView = [[RHSettingsView alloc] init];
    [self.view addSubview:_settingsView];
    [_settingsView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.equalTo(self.view);
    }];
    
}

@end
