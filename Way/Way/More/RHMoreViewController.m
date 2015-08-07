//
//  RHMoreViewController.m
//  Way
//
//  Created by zhuruhong on 15/7/28.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHMoreViewController.h"
#import "RHMoreViewAdapter.h"
#import "RHMoreView.h"
#import "RHMoreMenu.h"

@interface RHMoreViewController () <RHTableViewAdapterDelegate>
{
    RHMoreViewAdapter *_moreAdapter;
    RHMoreView *_moreView;
}

@end

@implementation RHMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _moreAdapter = [[RHMoreViewAdapter alloc] init];
    _moreAdapter.delegate = self;
    
    _moreView = [[RHMoreView alloc] init];
    [_moreView.tableView setTableViewAdapter:_moreAdapter];
    [self.view addSubview:_moreView];
    [_moreView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.equalTo(self.view);
    }];
    
    //test
    for (int i=0; i<5; i++) {
        RHMoreMenu *menu = [[RHMoreMenu alloc] init];
        menu.name = [NSString stringWithFormat:@"name %d", i+1];
        [_moreAdapter addCellData:menu];
    }//for
    
    //test end
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
