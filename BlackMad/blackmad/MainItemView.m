//
//  MainItemView.m
//  blackmad
//
//  Created by taobo on 17/6/8.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "MainItemView.h"
#define VIEWCENTER DWIDTH/6

@implementation MainItemView

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
        [self addView];
    }
    return self;
}
- (void)addView{
    for (int i = 0; i<3; i++) {
        UIView * view = [[UIView alloc] init];
        view.center = CGPointMake(VIEWCENTER+(i*2)*VIEWCENTER, 10+125/2);
        view.bounds = CGRectMake(0, 0, 111, 125);
        view.backgroundColor = [UIColor whiteColor];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 5;
        //item文字
        UILabel * label = [[UILabel alloc] init];
        label.center = CGPointMake(view.bounds.size.width/2, 15);
        label.bounds = CGRectMake(0, 0, view.bounds.size.width, 22);
        label.text = @"邮储办卡";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1];
        label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
        //info文字
        UILabel * infoLabel = [[UILabel alloc] init];
        infoLabel.center = CGPointMake(view.bounds.size.width/2, 27+9);
        infoLabel.bounds = CGRectMake(0, 0, view.bounds.size.width, 18);
        infoLabel.text = @"各大大礼免费拿";
        infoLabel.font = [UIFont systemFontOfSize:13];
        infoLabel.textAlignment = NSTextAlignmentCenter;
        infoLabel.textColor = [Tool appRedColor];
        //item图片
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"XRPlaceholder"];
        imageView.center = CGPointMake(view.bounds.size.width/2, 51+32);
        imageView.bounds = CGRectMake(0, 0, 92, 64);
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 5;
        //item点击按钮
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.frame = CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height);
        [btn addTarget:self action:@selector(cilckBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:btn];
        [view addSubview:imageView];
        [view addSubview:infoLabel];
        [view addSubview:label];
        [self addSubview:view];
    }
}

- (void)cilckBtn:(UIButton *)btn{
    NSLog(@"%ld",(long)btn.tag);
}

@end
