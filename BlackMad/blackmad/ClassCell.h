//
//  ClassCell.h
//  blackmad
//
//  Created by taobo on 17/6/5.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClassDelegate <NSObject>

- (void)cilckMoreBtn:(UIButton *)btn;

@end

@interface ClassCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;
/**
 *  背景图1
 */
@property (weak, nonatomic) IBOutlet UIImageView *image1;
/**
 *  背景图2
 */
@property (weak, nonatomic) IBOutlet UIImageView *image2;
/**
 *  背景图3
 */
@property (weak, nonatomic) IBOutlet UIImageView *image3;
/**
 *  more按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@property (nonatomic,assign) id <ClassDelegate>delegate;

@end
