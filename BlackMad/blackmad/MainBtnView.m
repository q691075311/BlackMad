//
//  MainBtnView.m
//  blackmad
//
//  Created by taobo on 17/3/9.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "MainBtnView.h"
#define VIEWWIDTH ([UIScreen mainScreen].bounds.size.width-4)/5
#define VIEWHIGTH 88
@implementation MainBtnView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self loadViewBtn];
    }
    return self;
}


- (void)loadViewBtn{
    for (int i = 0; i<5; i++) {
        UIView * view =[[UIView alloc] initWithFrame:CGRectMake(i*(VIEWWIDTH+1), 0, VIEWWIDTH, VIEWHIGTH)];
        view.backgroundColor = [UIColor whiteColor];
        [self addComponentWithView:view WithIndex:i];
        [self addSubview:view];
    }
}
- (void)addComponentWithView:(UIView *)view WithIndex:(int)i{
    NSArray * titleArr = @[@"全部",
                           @"银行金融",
                           @"休闲娱乐",
                           @"体育运动",
                           @"其他"];
    NSArray * imageArr = @[@"all",
                           @"Finance",
                           @"entertainment",
                           @"sport",
                           @"other"];
    //添加image
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArr[i]]]];
    imageView.bounds = CGRectMake(0, 0, 42, 42);
    imageView.center = CGPointMake(view.bounds.size.width/2, 31);
    [view addSubview:imageView];
    //添加lable
    UILabel * lable = [[UILabel alloc] init];
    lable.text = titleArr[i];
    lable.center = CGPointMake(view.bounds.size.width/2, 68);
    lable.bounds = CGRectMake(0, 0, 60, 20);
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    lable.textColor = [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1/1.0];
    [view addSubview:lable];
    //添加btn
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    btn.tag = 100+i;
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn.center = CGPointMake(view.bounds.size.width/2, view.bounds.size.height/2);
    btn.bounds = CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height);
    [view addSubview:btn];
}
- (void)clickBtn:(UIButton *)btn{
    if (_delegate && [_delegate respondsToSelector:@selector(touchBtnWithBtn:)]) {
        [_delegate touchBtnWithBtn:btn];
    }
}


@end
