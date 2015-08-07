//
//  RHMoreViewAdapter.m
//  Way
//
//  Created by zhuruhong on 15/7/28.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHMoreViewAdapter.h"
#import "RHMoreMenuCell.h"

@implementation RHMoreViewAdapter

- (Class)classOfCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [RHMoreMenuCell class];
}

@end
