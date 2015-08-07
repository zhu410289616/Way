//
//  RHMoreMenuCell.m
//  Way
//
//  Created by zhuruhong on 15/8/4.
//  Copyright (c) 2015年 zhuruhong. All rights reserved.
//

#import "RHMoreMenuCell.h"
#import "RHMoreMenu.h"

@interface RHMoreMenuCell ()
{
    UILabel *_nameLabel;
    
    RHMoreMenu *_menu;
}

@end

@implementation RHMoreMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:_nameLabel];
        [_nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(@(kSizeFrom750(40)));
        }];
    }
    return self;
}

- (void)updateViewWithData:(id)cellData
{
    _menu = cellData;
    
    _nameLabel.text = _menu.name;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
