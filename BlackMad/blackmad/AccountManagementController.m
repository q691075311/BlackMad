//
//  AccountManagementController.m
//  blackmad
//
//  Created by taobo on 17/3/13.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "AccountManagementController.h"

@interface AccountManagementController ()
@property (weak, nonatomic) IBOutlet UIButton *outLoginBtn;
@property (weak, nonatomic) IBOutlet UILabel *userAccount;

@end

@implementation AccountManagementController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.isAppearLineView = YES;
    [self.navBar configNavBarTitle:@"账户管理" WithLeftView:@"back" WithRigthView:nil];
    _outLoginBtn.layer.masksToBounds = YES;
    _outLoginBtn.layer.cornerRadius = YES;
    self.view.backgroundColor = COLORWITHRGB(237, 236, 237);
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