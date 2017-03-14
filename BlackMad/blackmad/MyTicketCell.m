//
//  MyTicketCell.m
//  blackmad
//
//  Created by 陶博 on 2017/3/14.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "MyTicketCell.h"

@implementation MyTicketCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = COLORWITHRGB(238, 238, 238);
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
