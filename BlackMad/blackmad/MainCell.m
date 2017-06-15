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
    
}
- (void)setTicketModle:(MyTicketModle *)ticketModle{
    [self.ticketImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,ticketModle.cardPictureAddress]]];
    self.ticketSub.text = ticketModle.cardName;
    self.ticketMark.text = ticketModle.cardRemark;
    self.ticketName.text = ticketModle.cardType;
    self.oldPrice.text = [NSString stringWithFormat:@"￥%@.00",ticketModle.cardVolumeOriginalPrice];
    self.currentPrice.text = [NSString stringWithFormat:@"￥%@.00",ticketModle.cardVolumePresentPrice];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
