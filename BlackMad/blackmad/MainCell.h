//
//  MainCell.h
//  blackmad
//
//  Created by taobo on 17/3/9.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTicketModle.h"

@interface MainCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *ticketImage;
/**
 *  卡券主题
 */
@property (weak, nonatomic) IBOutlet UILabel *ticketSub;
/**
 *  卡券说明
 */
@property (weak, nonatomic) IBOutlet UILabel *ticketMark;
/**
 *  老价格
 */
@property (weak, nonatomic) IBOutlet UILabel *oldPrice;
/**
 *  当前价格
 */
@property (weak, nonatomic) IBOutlet UILabel *currentPrice;
/**
 *  商家名称
 */
@property (weak, nonatomic) IBOutlet UILabel *ticketName;


/**
 *  cell的模型类
 */
@property (nonatomic,strong) MyTicketModle * ticketModle;
@end
