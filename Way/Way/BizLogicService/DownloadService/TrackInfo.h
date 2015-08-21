//
//  TrackInfo.h
//  Way
//
//  Created by zhuruhong on 15/8/11.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle.h>

@interface TrackInfo : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *albumId;
@property (nonatomic, copy) NSString *albumImage;
@property (nonatomic, copy) NSString *albumTitle;
@property (nonatomic, copy) NSString *coverLarge;

@end
