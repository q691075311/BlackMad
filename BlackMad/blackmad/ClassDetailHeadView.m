//
//  ClassDetailHeadView.m
//  blackmad
//
//  Created by taobo on 17/6/7.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "ClassDetailHeadView.h"

@interface ClassDetailHeadView ()
@property (nonatomic,strong) UIView * classView;
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
//类别Btn
- (IBAction)classBtn:(UIButton *)sender {
    static BOOL isShow = YES;
    if (isShow == YES) {
        [self showSubView];
    }else{
        [_classView removeFromSuperview];
    }
    isShow = !isShow;
}
//排序btn
- (IBAction)sortingBtn:(UIButton *)sender {
    
}

- (void)showSubView{
    _classView = [[UIView alloc] initWithFrame:CGRectMake(10, 100, 30, 17*3)];
    _classView.backgroundColor = [UIColor redColor];
    [self.superview addSubview:_classView];
    [self.superview bringSubviewToFront:_classView];
    for (int i = 0; i<3; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, i*17, 30, 17);
        [_classView addSubview:btn];
    }
}
@end
