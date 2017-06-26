//
//  TicketInfoController.h
//  blackmad
//
//  Created by taobo on 17/6/15.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "BaseController.h"
#import "MyTicketModle.h"

@interface TicketInfoController : BaseController
/**
 *  接收卡券ID的传值
 */
@property (nonatomic,strong) NSNumber * ticketModleID;

@end
