//
//  ClassCell.m
//  blackmad
//
//  Created by taobo on 17/6/5.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "ClassCell.h"
#import "YYModel.h"

typedef enum : NSUInteger {
    class_ACT,
    class_TICKET,
} classType;

@interface ClassCell ()

@property (nonatomic,copy) NSArray * btnArr;
@property (nonatomic,strong) NSMutableArray * actArr;
@property (nonatomic,strong) NSMutableArray * ticketArr;
@property (nonatomic,assign) classType type;
@end

@implementation ClassCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 6;
    self.contentView.backgroundColor = COLORWITHRGB(239, 239, 239);
    self.actArr = [NSMutableArray array];
    self.ticketArr = [NSMutableArray array];
    self.btnArr = @[self.btn1,self.btn2,self.btn3];
    for (int i = 0; i<3; i++) {
        UIButton * btn = self.btnArr[i];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnCilck:) forControlEvents:UIControlEventTouchUpInside];
    }
}
//配置活动的cell
- (void)setActList:(ActList *)actList{
    [self cleanBtnBackgroundImage];
    _type = class_ACT;
    self.typeName.text = actList.typeName;
    for (int i = 0; i<actList.productList.count; i++) {
        ActProductList * actPro = (ActProductList *) actList.productList[i];
        [self.actArr addObject:actPro];
        UIButton * btn = self.btnArr[i];
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,actPro.promotionalPicturePath]] forState:UIControlStateNormal];
    }
}
//配置卡券的cell
- (void)setTicketList:(TicketList *)ticketList{
    [self cleanBtnBackgroundImage];
    _type = class_TICKET;
    self.typeName.text = ticketList.typeName;
    for (NSInteger i = 0; i<ticketList.cardVolumeList.count; i++) {
        TicketCardVolumeList * ticketCardList = (TicketCardVolumeList *)ticketList.cardVolumeList[i];
        [self.ticketArr addObject:ticketCardList];
        UIButton * btn = self.btnArr[i];
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,ticketCardList.cardPictureAddress]] forState:UIControlStateNormal];
    }
}

- (void)btnCilck:(UIButton *)btn{
    NSInteger tag = btn.tag;
    if (_type == class_ACT) {
        ActProductList * actPro = self.actArr[tag];
        if (_delegate && [_delegate respondsToSelector:@selector(cilckCellBtnWithActProductList:)]) {
            [_delegate cilckCellBtnWithActProductList:actPro];
        }
    }else if (_type == class_TICKET){
        TicketCardVolumeList * ticketCard = self.ticketArr[tag];
        if (_delegate && [_delegate respondsToSelector:@selector(cilckCellBtnWithTicketList:)]) {
            [_delegate cilckCellBtnWithTicketList:ticketCard];
        }
    }
}

- (IBAction)clickMore:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cilckMoreBtn:)]) {
        [self.delegate cilckMoreBtn:sender];
    }
}

- (void)cleanBtnBackgroundImage{
    [_btn1 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_btn2 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_btn3 setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
