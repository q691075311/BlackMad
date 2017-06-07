//
//  NavBar.m
//  blackmad
//
//  Created by taobo on 17/3/8.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "NavBar.h"

@interface NavBar()

@end

@implementation NavBar
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        NavBar * bar = [[[NSBundle mainBundle] loadNibNamed:@"NavBar" owner:self options:nil] lastObject];
        bar.frame = frame;
        bar.autoresizingMask = self.autoresizingMask;
        return bar;
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    _rigthBtn.hidden = YES;
    _leftBtn.hidden = YES;
    
}
- (void)configNavBarTitle:(NSString *)title WithLeftView:(NSString *)leftImageName WithRigthView:(NSString *)rigthImageName{
    //添加灰色的导航栏线条
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 63, DWIDTH, 1)];
    view.backgroundColor = COLORWITHRGB(238, 238, 238);
    [self addSubview:view];
    if (_isAppearLineView == NO) {
        view.hidden = YES;
    }else{
        view.hidden = NO;
    }
    //配置导航栏数据
    _title.text = title;
    _rigthBtn.hidden = NO;
    _leftBtn.hidden = NO;
    if (leftImageName) {
        [_leftBtn setBackgroundImage:[UIImage imageNamed:leftImageName] forState:UIControlStateNormal];
    }
    if (rigthImageName) {
        [_rigthBtn setBackgroundImage:[UIImage imageNamed:rigthImageName] forState:UIControlStateNormal];
    }
}
- (IBAction)leftBtn:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(touchLeftBtn)]) {
        [_delegate touchLeftBtn];
    }
}
- (IBAction)rigthBtn:(UIButton *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(touchRigthBtn)]) {
        [_delegate touchRigthBtn];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
