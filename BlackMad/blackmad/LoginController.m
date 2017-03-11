//
//  LoginController.m
//  blackmad
//
//  Created by taobo on 17/3/10.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "LoginController.h"
#import "IQKeyboardReturnKeyHandler.h"
#import "ViewController.h"


typedef enum :NSUInteger{
    userType_Login,
    userType_Registered
}userType;

@interface LoginController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UITextField *loginPhone;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registeredBtn;
@property (nonatomic,assign) userType type;
@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _type = userType_Login;
    self.navigationController.navigationBar.hidden = YES;
    
    _loginPhone.delegate = self;
    _pwdField.delegate = self;
    IQKeyboardReturnKeyHandler * returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] init];
    returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyNext;
    [self initUI];
    
}
- (void)initUI{
    if (_type == userType_Login) {
        [self.navBar configNavBarTitle:@"账户登录" WithLeftView:nil WithRigthView:nil];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_registeredBtn setTitle:@"点击注册" forState:UIControlStateNormal];
        _headImage.image = [UIImage imageNamed:@"headimage"];
        _pwdField.placeholder = @"请输入密码";
    }else if (_type == userType_Registered){
        [self.navBar configNavBarTitle:@"账户注册" WithLeftView:nil WithRigthView:nil];
        [_loginBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registeredBtn setTitle:@"有账号？返回登录" forState:UIControlStateNormal];
        _headImage.image = [UIImage imageNamed:@"logo"];
        _pwdField.placeholder = @"请输入密码（6-18位字符）";
    }
    _headImage.layer.masksToBounds = YES;
    _headImage.layer.cornerRadius = 60;
    //设置用户名的textfield的左边框
    [self changeTextFieldStyleWith:_loginPhone WithLeftView:@"user" WithR:205 WithG:48 WithB:44];
    [self changeTextFieldLayer:_loginPhone];
    _loginPhone.keyboardType = UIKeyboardTypePhonePad;
    //设置密码的textfield的左边框
    _pwdField.secureTextEntry = YES;
    [self changeTextFieldStyleWith:_pwdField WithLeftView:@"pwdh" WithR:192 WithG:192 WithB:192];
    [self changeTextFieldLayer:_pwdField];
    //设置登录btn的边框
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.cornerRadius = 24;
    
}
- (void)changeTextFieldLayer:(UITextField *)textField{
    textField.layer.masksToBounds = YES;
    textField.layer.cornerRadius = 24;
    textField.layer.borderWidth = 1;
    textField.leftViewMode = UITextFieldViewModeAlways;
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
//改变UITextField的状态
- (void)changeTextFieldStyleWith:(UITextField *)textField WithLeftView:(NSString *)imageURL WithR:(int)R WithG:(int)G WithB:(int)B{
    UIView * view = [self textFildLeftViewWithImage:imageURL];
    textField.leftView = view;
    textField.layer.borderColor = COLORWITHRGB(R, G, B).CGColor;
}

#pragma mark--自定义UITextField的leftView
- (UIView *)textFildLeftViewWithImage:(NSString *)imageURL{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 24)];
    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 24)];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageURL]];

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
    if (_loginPhone.text.length != 11) {
        [SVProgressHUD showErrorWithStatus:@"输入正确的手机号"];
        return;
    }
    if (_pwdField.text.length < 6 || _pwdField.text.length > 18) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码（6-18位字符）"];
        return;
    }
    if (_type == userType_Login) {
        //登录成功
        [self pushToController:@"ViewController" WithStoyBordID:@"Main" WithForm:self WithInfo:@{}];
    }else if (_type == userType_Registered){
        //注册成功
        _type = userType_Login;
        [self initUI];
        _loginPhone.text = @"";
        _pwdField.text = @"";
        [self.view endEditing:YES];
    }
}
/**
 *  注册
 *
 *  @param sender
 */
- (IBAction)registeredBtn:(UIButton *)sender {
    if (_type == userType_Login) {
        _type = userType_Registered;
    }else if (_type == userType_Registered){
        _type = userType_Login;
    }
    [self initUI];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
