//
//  UserEntity.h
//  Way
//
//  Created by zhuruhong on 15/8/10.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserEntity : NSManagedObject

@property (nonatomic) int64_t user_id;
@property (nonatomic, retain) NSString * user_name;

@end
