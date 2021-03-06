//
//  ClassHeadView.m
//  blackmad
//
//  Created by taobo on 17/6/5.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "ClassHeadView.h"

@interface ClassHeadView ()
@property (nonatomic,strong) UIView *lineView;

@end

@implementation ClassHeadView

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
        ClassHeadView * view = [[[NSBundle mainBundle] loadNibNamed:@"ClassHeadView" owner:self options:nil] lastObject];
        view.frame = self.frame ;
        view.autoresizingMask = self.autoresizingMask;
        return view;
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    //添加下划线
    _lineView = [[UIView alloc] init];
    _lineView.center = CGPointMake(DWIDTH/4, 41);
    _lineView.bounds = CGRectMake(0, 0, 20, 2);
    _lineView.backgroundColor = [Tool appRedColor];
    [self addSubview:_lineView];
    //添加2个Btn
    for (int i = 0; i<2; i++) {
        UIButton * classBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        classBtn.center = CGPointMake((DWIDTH/4) + i*2*(DWIDTH/4), self.bounds.size.height/2);
        classBtn.bounds = CGRectMake(0, 0, 33, 22);
        classBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        classBtn.tag = i+100;
        [classBtn addTarget:self action:@selector(cliockBtn:) forControlEvents:UIControlEventTouchUpInside];
        [classBtn setTitleColor:COLORWITHRGB(74, 74, 74) forState:UIControlStateNormal];
        NSString * str = i == 0 ? @"卡券" : @"活动";
        if (i == 0) {
            [classBtn setTitleColor:[Tool appRedColor] forState:UIControlStateNormal];
        }
        [classBtn setTitle:str forState:UIControlStateNormal];
        [self addSubview:classBtn];
    }
}
- (void)cliockBtn:(UIButton *)btn{
    NSLog(@"做动画");
    UIButton * button = [self viewWithTag:100];
    UIButton * button1 = [self viewWithTag:101];
    [button setTitleColor:COLORWITHRGB(74, 74, 74) forState:UIControlStateNormal];
    [button1 setTitleColor:COLORWITHRGB(74, 74, 74) forState:UIControlStateNormal];
    [btn setTitleColor:[Tool appRedColor] forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint point = _lineView.center;
        point.x = btn.center.x;
        _lineView.center = point;
    } completion:^(BOOL finished) {
        if (_delegate && [_delegate respondsToSelector:@selector(chooseTopbarClass:)]) {
            [_delegate chooseTopbarClass:btn.tag];
        }
    }];
}



@end
