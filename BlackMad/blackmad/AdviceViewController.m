//
//  AdviceViewController.m
//  blackmad
//
//  Created by taobo on 17/5/31.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "AdviceViewController.h"

@interface AdviceViewController ()
@property (weak, nonatomic) IBOutlet UITextView *adviceText;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation AdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.navBar.isAppearLineView = YES;
    [self.navBar configNavBarTitle:@"投诉建议" WithLeftView:@"back" WithRigthView:nil];
    [self setViewUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)setViewUI{
    self.submitBtn.layer.masksToBounds = YES;
    self.submitBtn.layer.cornerRadius = self.submitBtn.bounds.size.height/2;
    self.adviceText.layer.masksToBounds = YES;
    self.adviceText.layer.cornerRadius = 5;
    self.adviceText.layer.borderWidth = 1;
    self.adviceText.layer.borderColor = [UIColor colorWithRed:212/255.0 green:200/255.0 blue:185/255.0 alpha:1].CGColor;
}

- (IBAction)submitClicok:(UIButton *)sender {
    [SVProgressHUD show];
    [AFNRequest complaintsWithContent:self.adviceText.text withComplete:^(NSDictionary *dic) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"提交成功！"];
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
