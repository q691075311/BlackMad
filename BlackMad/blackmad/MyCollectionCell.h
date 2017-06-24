//
//  MyCollectionCell.h
//  blackmad
//
//  Created by taobo on 17/6/1.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTicketModle.h"

@interface MyCollectionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *collectionImage;
@property (weak, nonatomic) IBOutlet UILabel *collectionTitle;
@property (weak, nonatomic) IBOutlet UILabel *collectionPerce;
@property (weak, nonatomic) IBOutlet UIButton *collectionCancleBtn;

@property (nonatomic,strong) MyTicketModle * ticketModle;

@end
