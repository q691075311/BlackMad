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
    self.exchangeBtn.layer.masksToBounds = YES;
    self.exchangeBtn.layer.cornerRadius = 6;
    self.guoQiImage.hidden = YES;
}

- (void)setMyTicketModle:(MyTicketModle *)myTicketModle{
    float price = [myTicketModle.cardVolumePresentPrice floatValue];
    self.ticketNum.text = [NSString stringWithFormat:@"优惠券号：%@",myTicketModle.cardCode];
    self.ticketName.text = myTicketModle.cardName;
    self.ticketInfo.text = myTicketModle.cardRemark;
    self.ticketprice.text = [NSString stringWithFormat:@"¥%.2f",price];
    [self.ticketLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,myTicketModle.cardPictureAddress]]];
    //判断状态
    NSString * status = myTicketModle.cardVolumeStatus;
    if ([status isEqualToString:@"0"]) {
        //状态正常
        
    }else if ([status isEqualToString:@"1"]){
        //未开始
        
    }else if ([status isEqualToString:@"2"]){
        //已过期
        self.guoQiImage.hidden = NO;
        [_exchangeBtn setBackgroundColor:[Tool appGrayColor]];
        _exchangeBtn.userInteractionEnabled = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
