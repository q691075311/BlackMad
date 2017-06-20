//
//  ClassDetailHeadView.h
//  blackmad
//
//  Created by taobo on 17/6/7.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClassHeadViewDelegate <NSObject>

- (void)chooseClassBtnTag:(NSInteger)btnTag;

- (void)chooseOrderbtnTag:(NSInteger)btnTag;

@end


@interface ClassDetailHeadView : UIView

- (instancetype)initWithShowArr:(NSArray *)arr;
/**
 *  title数组
 */
@property (nonatomic,copy) NSArray * classArr;
@property (nonatomic,copy) NSArray * orderArr;
@property (weak, nonatomic) IBOutlet UIImageView *classImage;
@property (weak, nonatomic) IBOutlet UIImageView *orderImage;

@property (nonatomic,assign) id<ClassHeadViewDelegate>delegate;

@end
