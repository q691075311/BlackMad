//
//  ChooseGenderView.m
//  blackmad
//
//  Created by taobo on 17/3/13.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "ChooseGenderView.h"

@interface ChooseGenderView()
@property (nonatomic,strong) UIWindow * window;
@property (nonatomic,strong) UIView * genderView;
@property (nonatomic,strong) UIButton * manBtn;
@property (nonatomic,strong) UIButton * womanBtn;
@property (nonatomic,strong) UIButton * confirm;
@property (nonatomic,copy) NSString * select;
@end

@implementation ChooseGenderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        self.hidden = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidden)];
        [self addGestureRecognizer:tap];
        _genderView = [[UIView alloc] initWithFrame:CGRectMake(0, DHIGTH, DWIDTH, 157)];
        _genderView.backgroundColor = COLORWITHRGB(239, 239, 239);
        
        _manBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _manBtn.frame = CGRectMake(0, 0, DWIDTH, 50);
        [_manBtn addTarget:self action:@selector(chooseMan) forControlEvents:UIControlEventTouchUpInside];
        [_manBtn setTitle:@"男士" forState:UIControlStateNormal];
        [_manBtn setTitleColor:COLORWITHRGB(203, 50, 50) forState:UIControlStateNormal];
        _manBtn.backgroundColor = [UIColor whiteColor];
        
        _womanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _womanBtn.frame = CGRectMake(0, 51, DWIDTH, 50);
        [_womanBtn addTarget:self action:@selector(chooseWoman) forControlEvents:UIControlEventTouchUpInside];
        [_womanBtn setTitle:@"女士" forState:UIControlStateNormal];
        [_womanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _womanBtn.backgroundColor = [UIColor whiteColor];
        
        _confirm = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirm.frame = CGRectMake(0, 50+1+50+6, DWIDTH, 50);
        [_confirm addTarget:self action:@selector(clickConfirm) forControlEvents:UIControlEventTouchUpInside];
        [_confirm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_confirm setTitle:@"确定" forState:UIControlStateNormal];
        _confirm.backgroundColor = [UIColor whiteColor];
        
        [_genderView addSubview:_manBtn];
        [_genderView addSubview:_womanBtn];
        [_genderView addSubview:_confirm];
        [self addSubview:_genderView];
        _window = [[[UIApplication sharedApplication] delegate] window];
        _select = @"男";
    }
    return self;
}

- (void)chooseWoman{
    _select = @"女";
    [_womanBtn setTitleColor:COLORWITHRGB(203, 50, 50) forState:UIControlStateNormal];
    [_manBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
- (void)chooseMan{
    _select = @"男";
    [_womanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_manBtn setTitleColor:COLORWITHRGB(203, 50, 50) forState:UIControlStateNormal];
}
- (void)clickConfirm{
    if (_delegate && [_delegate respondsToSelector:@selector(selectWithGender:)]) {
        [_delegate selectWithGender:_select];
    }
    [self hidden];
}
- (void)show{
    [UIView animateWithDuration:0.3 animations:^{
        [_window addSubview:self];
        self.hidden = NO;
        CGRect rect = _genderView.frame;
        rect.origin.y = DHIGTH-157;
        _genderView.frame = rect;
        self.alpha = 1;
    }];
}
- (void)hidden{
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}

@end
