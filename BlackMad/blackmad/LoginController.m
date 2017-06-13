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
#import "UserInfo.h"
#import "LoginUser.h"

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
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *validationField;
@property (weak, nonatomic) IBOutlet UITextField *SMSValidationField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnH;
/**
 *  图形验证码
 */
@property (nonatomic,strong) UIImageView * verifyImage;
/**
 *  图形验证码ID
 */
@property (nonatomic,strong) NSString *verifyID;
@property (nonatomic,assign) userType type;
@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self.fromFlag isEqualToString:@"ad"]) {
        _type = userType_Registered;
        [self getVerifyImageRequestWithType:@"0"];
    }else{
        _type = userType_Login;
        [self getVerifyImageRequestWithType:@"3"];
    }
    self.navigationController.navigationBar.hidden = YES;
    _loginPhone.delegate = self;
    _pwdField.delegate = self;
    _validationField.delegate = self;
    _SMSValidationField.delegate = self;
    IQKeyboardReturnKeyHandler * returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] init];
    returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyNext;
    [self initUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 禁用 iOS7 返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([USERDEF objectForKey:@"username"]) {
        self.loginPhone.text = [USERDEF objectForKey:@"username"];
        self.pwdField.text = [USERDEF objectForKey:@"pwd"];
    }
}
//设置页面的UI
- (void)initUI{
    if (_type == userType_Login) {
        [self.navBar configNavBarTitle:@"账户登录" WithLeftView:nil WithRigthView:nil];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_registeredBtn setTitle:@"若已注册疯趣公众号请用公众号账号登录" forState:UIControlStateNormal];
        NSString * headImageStr = [USERDEF objectForKey:@"headImage"];
        [_headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,headImageStr]] placeholderImage:[UIImage imageNamed:@"headimage"]];
        _pwdField.placeholder = @"请输入密码";
        _btnH.constant = -48;
        _SMSValidationField.hidden = YES;
        _scrollView.contentSize = CGSizeMake(DWIDTH, 537);
    }else if (_type == userType_Registered){
        [self.navBar configNavBarTitle:@"账户注册" WithLeftView:nil WithRigthView:nil];
        [_loginBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registeredBtn setTitle:@"若已注册疯趣公众号请用公众号账号登录" forState:UIControlStateNormal];
        _headImage.image = [UIImage imageNamed:@"logo"];
        _pwdField.placeholder = @"请输入密码（6-18位字符）";
        _btnH.constant = 24;
        _SMSValidationField.hidden = NO;
        _scrollView.contentSize = CGSizeMake(DWIDTH, 600);
    }
    
//    _scrollView.contentSize = CGSizeMake(DWIDTH, 1500);
    //设置用户名的textfield的左边框
    [self changeTextFieldStyleWith:_loginPhone WithLeftView:@"user" WithR:205 WithG:48 WithB:44];
    [self changeTextFieldLayer:_loginPhone];
    _loginPhone.keyboardType = UIKeyboardTypePhonePad;
    //设置密码的textfield的左边框
    _pwdField.secureTextEntry = YES;
    [self changeTextFieldStyleWith:_pwdField WithLeftView:@"pwdh" WithR:192 WithG:192 WithB:192];
    [self changeTextFieldLayer:_pwdField];
    //设置图形验证码的textfield的左边框和右视图
    [self changeTextFieldLayer:_validationField];
    _validationField.leftView = [self validationFieldLeftView];
    _validationField.rightView = [self validationFieldRightView];
    //设置短信验证码的SMSValidationField的左边框和右视图
    [self changeTextFieldLayer:_SMSValidationField];
    [self changeTextFieldStyleWith:_SMSValidationField WithLeftView:@"SMSyanzheng" WithR:192 WithG:192 WithB:192];
    _SMSValidationField.rightView = [self addSMSValidationRightView];
    //设置登录btn的边框
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.cornerRadius = 24;
    _loginBtn.layer.borderWidth = 1;
    _loginBtn.layer.borderColor = COLORWITHRGB(166, 166, 166).CGColor;
    
    _headImage.layer.masksToBounds = YES;
    _headImage.layer.cornerRadius = 60;
    _headImage.layer.borderWidth = 1;
    _headImage.layer.borderColor = COLORWITHRGB(166, 166, 166).CGColor;
    
}
- (void)changeTextFieldLayer:(UITextField *)textField{
    textField.layer.masksToBounds = YES;
    textField.layer.cornerRadius = 24;
    textField.layer.borderWidth = 1;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.rightViewMode = UITextFieldViewModeAlways;
}
//改变UITextField的状态
- (void)changeTextFieldStyleWith:(UITextField *)textField WithLeftView:(NSString *)imageURL WithR:(int)R WithG:(int)G WithB:(int)B{
    UIView * view;
    if (textField == _validationField) {
        view = [self validationFieldLeftView];
    }else{
        view = [self textFildLeftViewWithImage:imageURL];
    }
    textField.leftView = view;
    textField.layer.borderColor = COLORWITHRGB(R, G, B).CGColor;
}

#pragma mark--自定义UITextField的leftView和rightView
- (UIView *)textFildLeftViewWithImage:(NSString *)imageURL{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 24)];
    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 24)];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageURL]];
    imageView.frame = CGRectMake(20, 0, 24, 24);
    [view addSubview:leftView];
    [view addSubview:imageView];
    return view;
}
//验证码的左右视图
- (UILabel *)validationFieldLeftView{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 84, 48)];
    label.text = @"验证码：";
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentRight;
    label.textColor = COLORWITHRGB(74, 74, 74);
    _validationField.layer.borderColor = [Tool appGrayColor].CGColor;
    return label;
}
- (UIView *)validationFieldRightView{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeImageVerCode)];
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(_validationField.bounds.size.width-85, 7, 85, 34)];
    _verifyImage = [[UIImageView alloc] init];
    _verifyImage.frame = CGRectMake(0, 0, 69, 34);
    _verifyImage.userInteractionEnabled = YES;
    [_verifyImage addGestureRecognizer:tap];
    [bgView addSubview:_verifyImage];
    return bgView;
}
//add短信验证码的右视图
- (UIView *)addSMSValidationRightView{
    UIView * BGView = [[UIView alloc] initWithFrame:CGRectMake(_SMSValidationField.frame.size.width-102, 12, 102, 24)];
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 24)];
    lineView.backgroundColor = [Tool appGrayColor];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(9, 0, 80, 22);
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(getSMSValidationCode) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:COLORWITHRGB(74, 74, 74) forState:UIControlStateNormal];
    
    [BGView addSubview:btn];
    [BGView addSubview:lineView];
    return BGView;
}
#pragma mark--UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self changeTextFieldStyleWith:_loginPhone WithLeftView:@"userh" WithR:192 WithG:192 WithB:192];
    [self changeTextFieldStyleWith:_pwdField WithLeftView:@"pwdh" WithR:192 WithG:192 WithB:192];
    [self changeTextFieldStyleWith:_validationField WithLeftView:@"userh" WithR:192 WithG:192 WithB:192];
    [self changeTextFieldStyleWith:_SMSValidationField WithLeftView:@"SMSyanzheng" WithR:192 WithG:192 WithB:192];
    if (textField == _loginPhone) {
        [self changeTextFieldStyleWith:_loginPhone WithLeftView:@"user" WithR:205 WithG:48 WithB:44];
    }else if (textField == _pwdField){
        [self changeTextFieldStyleWith:_pwdField WithLeftView:@"pwdleft" WithR:205 WithG:48 WithB:44];
    }else if (textField == _validationField){
        [self changeTextFieldStyleWith:_validationField WithLeftView:@"userh" WithR:205 WithG:48 WithB:44];
    }else if (textField == _SMSValidationField){
        [self changeTextFieldStyleWith:_SMSValidationField WithLeftView:@"SMSyanzhengH" WithR:205 WithG:48 WithB:44];
    }
}

//切换图形验证码
- (void)changeImageVerCode{
    _type == userType_Login ? [self getVerifyImageRequestWithType:@"3"] : [self getVerifyImageRequestWithType:@"0"];
}

/**
 *  登录
 *
 *  @param sender
 */
- (IBAction)login:(UIButton *)sender {
    if (_loginPhone.text.length != 11 || _loginPhone.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"输入正确的手机号"];
        return;
    }
    if (_pwdField.text.length < 6 || _pwdField.text.length > 18 || _pwdField.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码（6-18位字符）"];
        return;
    }
    if (_type == userType_Login) {
        [self loginRequest];
    }else if (_type == userType_Registered){
        [self regRequest];
    }
}
//注册请求
- (void)regRequest{
    [SVProgressHUD show];
    [AFNRequest requestWithDataURL:registered
                      WithUserName:self.loginPhone.text
                          WithPwsd:self.pwdField.text
                      withVerifyId:_verifyID
                    withVerifyCode:_validationField.text
                       withSMSCode:_SMSValidationField.text
                      WithComplete:^(NSDictionary *dic) {
                          [SVProgressHUD dismiss];
                          [SVProgressHUD showSuccessWithStatus:@"注册成功"];
                          //注册成功
                          [USERDEF removeObjectForKey:@"headImage"];
                          [USERDEF synchronize];
                          _type = userType_Login;
                          _validationField.text = @"";
                          _SMSValidationField.text = @"";
                          [self initUI];
                          [self getVerifyImageRequestWithType:@"3"];
                          [self.view endEditing:YES];
                      }];
}
//登录请求
- (void)loginRequest{
    [AFNRequest requestLoginWithURL:loginURL
                       withVerifyID:_verifyID
                     withVerifyCode:_validationField.text
                       WithUserName:self.loginPhone.text
                           WithPwsd:self.pwdField.text
                       WithComplete:^(NSDictionary *dic) {
                           [SVProgressHUD dismiss];
                           NSLog(@"%@",dic);
                           NSDictionary * dic1 = dic[@"attribute"];
                           //清空用户信息
                           [LoginUser shareUser].user = nil;
                           [LoginUser shareUser].token = nil;
                           //存储账号密码
                           [USERDEF setObject:self.loginPhone.text forKey:@"username"];
                           [USERDEF setObject:self.pwdField.text forKey:@"pwd"];
                           [USERDEF synchronize];
                           [LoginUser shareUser].uid = [NSString stringWithFormat:@"%@",dic1[@"uid"]];
                           [LoginUser shareUser].token = (NSString *)dic1[@"token"];
                           [LoginUser shareUser].isLogin = YES;
                           if ([dic1[@"isSelectInterest"] isEqual:@(0)]) {
                               //没有接受兴趣调查
                               [LoginUser shareUser].isSelectInterest = @(0);
                           }else{
                               [LoginUser shareUser].isSelectInterest = @(1);
                           }
                           [self getUserInfoRequest];
                       }];
}

//获取用户信息的请求
- (void)getUserInfoRequest{
    
    [AFNRequest requestUserInfoWithURL:userinfo
                             WithToken:[LoginUser shareUser].token
                               WithUid:[LoginUser shareUser].uid
                          WithComplete:^(NSDictionary *dic) {
                              NSLog(@"%@",dic);
                              NSDictionary * dic1 = dic[@"attribute"];
                              NSDictionary * dic2 = dic1[@"item"];
                              UserInfo * user = [[UserInfo alloc] initWithDic:dic2];
                              [LoginUser shareUser].user = user;
                              [USERDEF setObject:user.headImage forKey:@"headImage"];
                              [USERDEF synchronize];
                              //判断是否跳转兴趣页面
                              if ([[LoginUser shareUser].isSelectInterest isEqual:@(0)]) {
                                  //登录成功跳兴趣爱好
                                  [self pushToController:@"InterestController" WithStoyBordID:@"Main" WithForm:self WithInfo:@{}];
                              }else{
                                  //登录成功回首页
                                  [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                              }
                          }];
}
//获取图形验证码请求
- (void)getVerifyImageRequestWithType:(NSString *)type{
    [SVProgressHUD show];
    [AFNRequest getImageVerifyCodeWithUseingID:type WithComplete:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
        NSDictionary * diction = dic[@"attribute"];
        NSString *verifyID = diction[@"verifyId"];
        _verifyID = verifyID;
        NSData * imageData = [[NSData alloc] initWithBase64Encoding:diction[@"imageBase"]];
        UIImage * image = [UIImage imageWithData:imageData];
        _verifyImage.image = image;
        [SVProgressHUD dismiss];
    }];
}
//获取短信验证码
- (void)getSMSValidationCode{
    [AFNRequest getSMSVerifyCodeWithUsering:@"0"
                                  withPhone:_loginPhone.text
                                 withUserId:@""
                               withComplete:^(NSDictionary *dic) {
                                   NSLog(@"%@",dic);
                                   NSString * smsCode = [dic[@"attribute"] objectForKey:@"smsCode"];
                                   _SMSValidationField.text = smsCode;
                               }];
}
/**
 *  切换注册登录页面
 *
 *  @param sender
 */
- (IBAction)registeredBtn:(UIButton *)sender {
    if (_type == userType_Login) {
        _type = userType_Registered;
        [self getVerifyImageRequestWithType:@"0"];
    }else if (_type == userType_Registered){
        _type = userType_Login;
        [self getVerifyImageRequestWithType:@"3"];
    }
    [self initUI];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)touchLeftBtn{
    
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
