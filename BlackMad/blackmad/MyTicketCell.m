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

- (void)setMyTicketModle:(MyTicketModle *)myTicketModle{
    self.ticketNum.text = [NSString stringWithFormat:@"优惠券号：%@",myTicketModle.cardCode];
    self.ticketName.text = myTicketModle.cardName;
    self.ticketInfo.text = myTicketModle.cardRemark;
    self.ticketprice.text = [NSString stringWithFormat:@"¥ %@元",myTicketModle.cardVolumeAmount];
    self.ticketDate.text = [NSString stringWithFormat:@"截止日期：有效期至%@",myTicketModle.effectiveEndDate];
    [self.ticketLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,myTicketModle.cardPictureAddress]]];
    //0是未过期  1是未开始  2是已过期
    if ([myTicketModle.cardVolumeStatus isEqualToString:@"0"]) {
        self.guoQiImage.hidden = YES;
        self.backImage.image = [UIImage imageNamed:@"bolanghong"];
    }else if ([myTicketModle.cardVolumeStatus isEqualToString:@"1"]){
        self.guoQiImage.hidden = YES;
        self.backImage.image = [UIImage imageNamed:@"bolanghong"];
    }else{
        self.guoQiImage.hidden = NO;
        self.backImage.image = [UIImage imageNamed:@"bolanghui"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
