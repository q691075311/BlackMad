//
//  ClassCell.h
//  blackmad
//
//  Created by taobo on 17/6/5.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModels.h"

@protocol ClassDelegate <NSObject>

- (void)cilckMoreBtn:(UIButton *)btn;

- (void)cilckCellBtnWithActProductList:(ActProductList *)actPro;

@end

@interface ClassCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;

/**
 *  type名字
 */
@property (weak, nonatomic) IBOutlet UILabel *typeName;
/**
 *  more按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (nonatomic,strong) ActList * actList;
@property (nonatomic,assign) id <ClassDelegate>delegate;

@end
