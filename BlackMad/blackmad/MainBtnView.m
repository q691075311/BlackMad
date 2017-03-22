//
//  MainBtnView.m
//  blackmad
//
//  Created by taobo on 17/3/9.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "MainBtnView.h"


@interface MainBtnView()
@property (nonatomic,copy)NSArray * productImageArr;//图片数组
@property (nonatomic,copy)NSArray * productTitleArr;//Title数组
@property (nonatomic,copy)NSArray * productIDArr;//产品类型ID
@property (nonatomic,strong) UILabel * lastLabel;//记录最后点击的label
@end

@implementation MainBtnView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame WithProductID:(NSArray *)productID WithProductImage:(NSArray *)productImageArr WithProductTitleArr:(NSArray *)productTitleArr{
    self = [super initWithFrame:frame];
    if (self) {
        _productIDArr = productID;
        _productImageArr = productImageArr;
        _productTitleArr = productTitleArr;
        [self loadViewBtn];
    }
    return self;
}

- (void)loadViewBtn{
    UIScrollView * scrollView = [self addScrollView];
    for (int i = 0; i<_productTitleArr.count; i++) {
        UIView * view =[[UIView alloc] initWithFrame:CGRectMake(i*(VIEWWIDTH+1), 0, VIEWWIDTH, VIEWHIGTH)];
        view.backgroundColor = [UIColor whiteColor];
        [self addComponentWithView:view WithIndex:i];
        [scrollView addSubview:view];
    }
}
- (UIScrollView *)addScrollView{
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, DWIDTH, VIEWHIGTH);
    scrollView.contentSize = CGSizeMake(VIEWWIDTH * _productImageArr.count + _productImageArr.count-1, VIEWHIGTH);
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    return scrollView;
}
- (void)addComponentWithView:(UIView *)view WithIndex:(int)i{
    
    //添加image
    UIImageView * imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,_productImageArr[i]]]];
    imageView.bounds = CGRectMake(0, 0, 42, 42);
    imageView.center = CGPointMake(view.bounds.size.width/2, 31);
    [view addSubview:imageView];
    //添加lable
    UILabel * lable = [[UILabel alloc] init];
    lable.tag = 200+i;
    lable.text = _productTitleArr[i];
    lable.center = CGPointMake(view.bounds.size.width/2, 68);
    lable.bounds = CGRectMake(0, 0, 60, 20);
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    if (i == 0) {
        lable.textColor = COLORWITHRGB(203, 50, 50);
        _lastLabel = lable;
    }else{
        lable.textColor = COLORWITHRGB(74, 74, 74);
    }
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
    _lastLabel.textColor = COLORWITHRGB(74, 74, 74);
    NSInteger tag = btn.tag+100;
    UILabel * label = (UILabel *)[self viewWithTag:tag];
    label.textColor = COLORWITHRGB(203, 50, 50);
    _lastLabel = label;
    if (_delegate && [_delegate respondsToSelector:@selector(touchBtnWithBtn:WithProductID:)]) {
        [_delegate touchBtnWithBtn:btn WithProductID:_productIDArr[btn.tag-100]];
    }
}


@end
