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
    self.contentView.backgroundColor = COLORWITHRGB(255, 255, 255);
    self.title.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    self.title.textColor = COLORWITHRGB(74, 74, 74);
    
    self.time.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.time.textColor = COLORWITHRGB(150, 150, 150);
    [self.image sd_setImageWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/logo_white_fe6da1ec.png"] placeholderImage:[UIImage imageNamed:@"XRPlaceholder"]];
}

- (void)setProductModle:(MainProductModle *)productModle{
    self.title.text = productModle.productName;
    self.time.text = [NSString stringWithFormat:@"活动时间：%@ - %@",productModle.activityStartDate,productModle.activityEndDate];
    [self.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,productModle.promotionalPicturePath]] placeholderImage:[UIImage imageNamed:@"XRPlaceholder"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
