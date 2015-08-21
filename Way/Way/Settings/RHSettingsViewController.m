//
//  RHSettingsViewController.m
//  Way
//
//  Created by zhuruhong on 15/8/4.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHSettingsViewController.h"
#import "RHSettingsView.h"
#import "UIImage+App.h"

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
    //当前controler显示的back内容
    self.navigationController.navigationBar.topItem.backBarButtonItem = [self backBarButtonItem];
    //下一级controler显示的back内容
    self.navigationItem.backBarButtonItem = [self backBarButtonItem];
    
    _settingsView = [[RHSettingsView alloc] init];
    [self.view addSubview:_settingsView];
    [_settingsView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.equalTo(self.view);
    }];
    
}

- (UIBarButtonItem *)backBarButtonItem
{
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageWithColor:[UIColor yellowColor] size:CGSizeMake(10, 10)] style:UIBarButtonItemStylePlain target:self action:nil];
    return item;
}

@end
