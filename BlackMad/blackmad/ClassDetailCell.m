//
//  ClassDetailCell.m
//  blackmad
//
//  Created by taobo on 17/6/7.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "ClassDetailCell.h"

@implementation ClassDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSString *textStr = [NSString stringWithFormat:@"￥34.00"];
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
    // 赋值
    self.oldPrice.attributedText = attribtStr;
    self.classImage.layer.masksToBounds = YES;
    self.classImage.layer.cornerRadius = 5;
    
}
//配置活动cell
- (void)setClassInfo:(ClassInfo *)classInfo{
    [_classImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,classInfo.promotionalPicturePath]]];
    _classTitle.text = classInfo.productName;
    _classDate.text = classInfo.activityEndDate;
    _classDate.text = [NSString stringWithFormat:@"截止日期:%@",classInfo.activityEndDate];
    _classNewPrice.hidden = YES;
    _oldPrice.hidden = YES;
}
//配置卡券的cell
- (void)setTicketModle:(MyTicketModle *)ticketModle{
    _classNewPrice.hidden = NO;
    _oldPrice.hidden = NO;
    [_classImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,ticketModle.cardPictureAddress]]];
    _classTitle.text = ticketModle.cardName;
    _classNewPrice.text = [NSString stringWithFormat:@"¥%@.00",ticketModle.cardVolumePresentPrice];
    _oldPrice.text = [NSString stringWithFormat:@"¥%@.00",ticketModle.cardVolumeOriginalPrice];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
