//
//  ClassCell.m
//  blackmad
//
//  Created by taobo on 17/6/5.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "ClassCell.h"

@implementation ClassCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 6;
    self.contentView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
