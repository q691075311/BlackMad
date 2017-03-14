//
//  MyTicketController.m
//  blackmad
//
//  Created by taobo on 17/3/13.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "MyTicketController.h"

#define BTN_HIGTH 22
#define BTN_WIDTH 50
#define BTN_DISTANTS (DWIDTH-(BTN_WIDTH*3))/6

@interface MyTicketController ()
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (nonatomic,strong) UIView * lineView;
@end

@implementation MyTicketController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLORWITHRGB(235, 235, 235);
    self.navBar.isAppearLineView = YES;
    [self.navBar configNavBarTitle:@"我的券" WithLeftView:@"back" WithRigthView:nil];
    [self addBarButton];
}
- (void)addBarButton{
    NSArray * titleArr = @[@"全部",
                           @"已兑换",
                           @"未兑换"];
    for (int i = 0; i<3; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.center = CGPointMake((i*2+1)*BTN_DISTANTS + (i+0.5)*BTN_WIDTH, _headView.bounds.size.height/2);
        btn.bounds = CGRectMake(0, 0, BTN_WIDTH, BTN_HIGTH);
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(chooseType:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:COLORWITHRGB(203, 50, 50) forState:UIControlStateNormal];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        if (i == 0) {
            _lineView = [[UIView alloc] init];
            _lineView.bounds = CGRectMake(0, 0, 20, 2);
            _lineView.backgroundColor = COLORWITHRGB(203, 50, 50);
            _lineView.center = CGPointMake(btn.center.x, btn.center.y + 11+3+1);
            [_headView addSubview:_lineView];
        }
        [_headView addSubview:btn];
    }
    
    
}

- (void)chooseType:(UIButton *)btn{
    [UIView animateWithDuration:0.3 animations:^{
        _lineView.center = CGPointMake(btn.center.x, btn.center.y+11+3+1);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
