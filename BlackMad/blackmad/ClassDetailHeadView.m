//
//  ClassDetailHeadView.m
//  blackmad
//
//  Created by taobo on 17/6/7.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "ClassDetailHeadView.h"

#define BTNHEIGHT 42

@interface ClassDetailHeadView ()
@property (nonatomic,strong) UIView * classView;
@property (nonatomic,strong) UIView * orderView;
@property (nonatomic,strong) UITapGestureRecognizer * tap;
@property (nonatomic,assign) BOOL isShow;
@property (nonatomic,assign) BOOL isOrderShow;
@end

@implementation ClassDetailHeadView

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
        ClassDetailHeadView * view = [[[NSBundle mainBundle] loadNibNamed:@"ClassDetailHeadView" owner:self options:nil] lastObject];
        
        view.autoresizingMask = self.autoresizingMask;
        view.frame = self.frame;
        return view;
    }
    return self;
}
//- (instancetype)initWithShowArr:(NSArray *)arr{
//    self = [super initWithFrame:CGRectMake(0, 64, DWIDTH, 40)];
//    if (self) {
//        ClassDetailHeadView * view = [[[NSBundle mainBundle] loadNibNamed:@"ClassDetailHeadView" owner:self options:nil] lastObject];
//        view.autoresizingMask = self.autoresizingMask;
//        view.frame = self.frame;
//        return view;
//    }
//    return self;
//}

//类别Btn
- (IBAction)classBtn:(UIButton *)sender {
    if (_isShow == YES) {
        [_classView removeFromSuperview];
        _classImage.image = [UIImage imageNamed:@"up"];
    }else{
        [self showClassSubView];
        _classImage.image = [UIImage imageNamed:@"down"];
    }
    _isShow = !_isShow;
}
//排序btn
- (IBAction)sortingBtn:(UIButton *)sender {
    if (_isOrderShow == YES) {
        [_orderView removeFromSuperview];
        _orderImage.image = [UIImage imageNamed:@"up"];
    }else{
        [self showOrderSubView];
        _orderImage.image = [UIImage imageNamed:@"down"];
    }
    _isOrderShow = !_isOrderShow;
}

- (void)showClassSubView{
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenView)];
    [self.superview addGestureRecognizer:_tap];
    _classView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 120, BTNHEIGHT*(self.classArr.count))];
    _classView.backgroundColor = [UIColor whiteColor];
    _classView.layer.borderColor = COLORWITHRGB(235, 235, 235).CGColor;
    _classView.layer.borderWidth = 1;
    [self.superview addSubview:_classView];
    [self.superview bringSubviewToFront:_classView];
    for (int i = 0; i<self.classArr.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, i*BTNHEIGHT, 120, BTNHEIGHT);
        [btn setTitle:self.classArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:COLORWITHRGB(166, 166, 166) forState:UIControlStateNormal];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(classCilockBtn:) forControlEvents:UIControlEventTouchUpInside];
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, i*BTNHEIGHT+BTNHEIGHT-1, 120, 1)];
        lineView.backgroundColor = COLORWITHRGB(235, 235, 235);
        [_classView addSubview:lineView];
        [_classView addSubview:btn];
    }
}

- (void)showOrderSubView{
    _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenView)];
    [self.superview addGestureRecognizer:_tap];
    _orderView = [[UIView alloc] initWithFrame:CGRectMake(DWIDTH-120-10, 100, 120, BTNHEIGHT*(self.orderArr.count))];
    _orderView.backgroundColor = [UIColor whiteColor];
    _orderView.layer.borderColor = COLORWITHRGB(235, 235, 235).CGColor;
    _orderView.layer.borderWidth = 1;
    [self.superview addSubview:_orderView];
    [self.superview bringSubviewToFront:_orderView];
    for (int i = 0; i<self.orderArr.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, i*BTNHEIGHT, 120, BTNHEIGHT);
        [btn setTitle:self.orderArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:COLORWITHRGB(166, 166, 166) forState:UIControlStateNormal];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(orderCilockBtn:) forControlEvents:UIControlEventTouchUpInside];
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, i*BTNHEIGHT+BTNHEIGHT-1, 120, 1)];
        lineView.backgroundColor = COLORWITHRGB(235, 235, 235);
        [_orderView addSubview:lineView];
        [_orderView addSubview:btn];
    }
}



- (void)classCilockBtn:(UIButton *)btn{
    [_classView removeFromSuperview];
    _isShow = NO;
    _classImage.image = [UIImage imageNamed:@"up"];
    if (_delegate && [_delegate respondsToSelector:@selector(chooseClassBtnTag:)]) {
        [_delegate chooseClassBtnTag:btn.tag];
    }
}
- (void)orderCilockBtn:(UIButton *)btn{
    [_orderView removeFromSuperview];
    _isOrderShow = NO;
    _orderImage.image = [UIImage imageNamed:@"up"];
    if (_delegate && [_delegate respondsToSelector:@selector(chooseOrderbtnTag:)]) {
        [_delegate chooseOrderbtnTag:btn.tag];
    }
}

- (void)hiddenView{
    [_classView removeFromSuperview];
    [_orderView removeFromSuperview];
    _isShow = NO;
    _isOrderShow = NO;
    _orderImage.image = [UIImage imageNamed:@"up"];
    _classImage.image = [UIImage imageNamed:@"up"];
    [self.superview removeGestureRecognizer:_tap];
}

@end
