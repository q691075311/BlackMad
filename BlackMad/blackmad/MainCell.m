//
//  MainCell.m
//  blackmad
//
//  Created by taobo on 17/3/9.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "MainCell.h"

@implementation MainCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = 5;
    self.backView.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    self.title.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    self.title.textColor = [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1/1.0];
    
    self.time.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.time.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1/1.0];
    
    self.image.image = [UIImage imageNamed:@"XRPlaceholder"];
    self.title.text = @"111111";
    self.time.text = @"222222";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
