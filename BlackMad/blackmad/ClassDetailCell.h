//
//  ClassDetailCell.h
//  blackmad
//
//  Created by taobo on 17/6/7.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassInfo.h"

@interface ClassDetailCell : UITableViewCell
/**
 *  cell图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *classImage;
/**
 *  cell标题
 */
@property (weak, nonatomic) IBOutlet UILabel *classTitle;
/**
 *  cell时间
 */
@property (weak, nonatomic) IBOutlet UILabel *classDate;
/**
 *  cell新价格
 */
@property (weak, nonatomic) IBOutlet UILabel *classNewPrice;
/**
 *  cell老价格
 */
@property (weak, nonatomic) IBOutlet UILabel *oldPrice;

@property (nonatomic,strong) ClassInfo * classInfo;

@end
