//
//  RHMoreView.m
//  Way
//
//  Created by zhuruhong on 15/7/28.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHMoreView.h"


@implementation RHMoreView

- (instancetype)init
{
    if (self = [super init]) {
        _tableView = [[RHTableView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc] init];
        [self addSubview:_tableView];
        [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.equalTo(self);
        }];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
