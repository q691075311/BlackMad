//
//  MyTicketCell.h
//  blackmad
//
//  Created by 陶博 on 2017/3/14.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTicketCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *ticketNum;//优惠券号
@property (weak, nonatomic) IBOutlet UIImageView *guoQiImage;//过期图片
@property (weak, nonatomic) IBOutlet UIImageView *ticketLogo;//优惠券的logo
@property (weak, nonatomic) IBOutlet UILabel *ticketName;//优惠券名字
@property (weak, nonatomic) IBOutlet UILabel *ticketInfo;//优惠券详情
@property (weak, nonatomic) IBOutlet UILabel *ticketprice;//优惠价格
@property (weak, nonatomic) IBOutlet UIImageView *backImage;//优惠背景图
@property (weak, nonatomic) IBOutlet UILabel *ticketDate;//优惠有效期

@end
