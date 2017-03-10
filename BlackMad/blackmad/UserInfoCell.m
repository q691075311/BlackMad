//
//  UserInfoCell.m
//  blackmad
//
//  Created by taobo on 17/3/10.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "UserInfoCell.h"

@implementation UserInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.setTitle.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    self.setTitle.textColor = [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1/1.0];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
