//
//  MainItemView.m
//  blackmad
//
//  Created by taobo on 17/6/8.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "MainItemView.h"
#import "DataModels.h"
#define VIEWCENTER DWIDTH/6

@implementation MainItemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithData:(NSMutableArray *)arr{
    self = [super initWithFrame:CGRectMake(0, 240, DWIDTH, 145)];
    if (self) {
//        self.frame = frame;
        [self addScorllViewWithData:arr];
        
    }
    return self;
}
- (void)addScorllViewWithData:(NSMutableArray *)arr{
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [self addSubview:scrollView];
    [self addViewToView:scrollView WithArr:arr];
}

- (void)addViewToView:(UIScrollView *)scrollView WithArr:(NSMutableArray *)arr{
    for (int i = 0; i<arr.count; i++) {
        ActProductList * actPro = [[ActProductList alloc] initWithDictionary:arr[i]];
        NSLog(@"%@",actPro);
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
        label.text = actPro.productName;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1];
        label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
        //info文字
        UILabel * infoLabel = [[UILabel alloc] init];
        infoLabel.center = CGPointMake(view.bounds.size.width/2, 27+9);
        infoLabel.bounds = CGRectMake(0, 0, view.bounds.size.width, 18);
        infoLabel.text = actPro.productSubject;
        infoLabel.font = [UIFont systemFontOfSize:13];
        infoLabel.textAlignment = NSTextAlignmentCenter;
        infoLabel.textColor = [Tool appRedColor];
        //item图片
        UIImageView * imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,actPro.promotionalPicturePath]]];
//        imageView.image = [UIImage imageNamed:@"XRPlaceholder"];
        imageView.center = CGPointMake(view.bounds.size.width/2, 51+32);
        imageView.bounds = CGRectMake(0, 0, 92, 64);
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 5;
        //item点击按钮
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.frame = CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height);
        [btn addTarget:self action:@selector(cilckBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        scrollView.contentSize = CGSizeMake(self.bounds.size.width/3*arr.count, self.bounds.size.height);
        
        [scrollView addSubview:view];
        [view addSubview:btn];
        [view addSubview:imageView];
        [view addSubview:infoLabel];
        [view addSubview:label];
    }
}

- (void)cilckBtn:(UIButton *)btn{
    if (_delegate && [_delegate respondsToSelector:@selector(chooseBtnTag:)]) {
        [_delegate chooseBtnTag:btn.tag];
    }
    
}

@end
