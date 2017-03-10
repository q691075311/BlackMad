//
//  LoginController.m
//  blackmad
//
//  Created by taobo on 17/3/10.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "LoginController.h"


@interface LoginController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UITextField *loginPhone;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    [self.navBar configNavBarTitle:@"账户登录" WithLeftView:nil WithRigthView:nil];
    _loginPhone.delegate = self;
    _pwdField.delegate = self;
    [self initUI];
    
}
- (void)initUI{
    _headImage.layer.masksToBounds = YES;
    _headImage.layer.cornerRadius = 60;
    //设置用户名的textfield的左边框
    UIView * view = [self textFildLeftViewWithImage:@"user"];
    _loginPhone.layer.masksToBounds = YES;
    _loginPhone.layer.cornerRadius = 24;
    _loginPhone.layer.borderWidth = 1;
    //红色
    _loginPhone.layer.borderColor = COLORWITHRGB(205, 48, 44).CGColor;
    _loginPhone.leftView = view;
    _loginPhone.leftViewMode = UITextFieldViewModeAlways;
    
    //设置密码的textfield的左边框
    UIView * view1 = [self textFildLeftViewWithImage:@"pwdh"];
    _pwdField.layer.masksToBounds = YES;
    _pwdField.layer.cornerRadius = 24;
    _pwdField.layer.borderWidth = 1;
    //灰色
    _pwdField.layer.borderColor = COLORWITHRGB(192, 192, 192).CGColor;
    _pwdField.leftView = view1;
    _pwdField.leftViewMode = UITextFieldViewModeAlways;
    
    //设置登录btn的边框
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.cornerRadius = 24;
    
}
#pragma mark--UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField == _pwdField) {
        //如果选中密码框
        [self changeTextFieldStyleWith:_loginPhone WithLeftView:@"userh" WithR:192 WithG:192 WithB:192];
        [self changeTextFieldStyleWith:_pwdField WithLeftView:@"pwdleft" WithR:205 WithG:48 WithB:44];
    }else{
        [self changeTextFieldStyleWith:_loginPhone WithLeftView:@"user" WithR:205 WithG:48 WithB:44];
        [self changeTextFieldStyleWith:_pwdField WithLeftView:@"pwdh" WithR:192 WithG:192 WithB:192];
    }
}

- (void)changeTextFieldStyleWith:(UITextField *)textField WithLeftView:(NSString *)imageURL WithR:(int)R WithG:(int)G WithB:(int)B{
    UIView * view = [self textFildLeftViewWithImage:imageURL];
    textField.leftView = view;
    textField.layer.borderColor = COLORWITHRGB(R, G, B).CGColor;
}

#pragma mark--自定义UITextField的leftView
- (UIView *)textFildLeftViewWithImage:(NSString *)imageURL{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 24)];
    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 24)];
//    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageURL]];
    UIImageView * imageView = [[UIImageView alloc] init];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/logo_white_fe6da1ec.png"]];
    imageView.frame = CGRectMake(20, 0, 24, 24);
    [view addSubview:leftView];
    [view addSubview:imageView];
    return view;
}
/**
 *  登录
 *
 *  @param sender
 */
- (IBAction)login:(UIButton *)sender {
    
    
    
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
