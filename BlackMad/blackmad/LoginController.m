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

@interface LoginController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UITextField *loginPhone;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registeredBtn;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    [self.navBar configNavBarTitle:@"账户登录" WithLeftView:nil WithRigthView:nil];
    _loginPhone.delegate = self;
    _pwdField.delegate = self;
    IQKeyboardReturnKeyHandler * returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] init];
    returnKeyHandler.lastTextFieldReturnKeyType = UIReturnKeyNext;
    [self initUI];
    
}
- (void)initUI{
    _headImage.layer.masksToBounds = YES;
    _headImage.layer.cornerRadius = 60;
    //设置用户名的textfield的左边框
    [self changeTextFieldStyleWith:_loginPhone WithLeftView:@"user" WithR:205 WithG:48 WithB:44];
    [self changeTextFieldLayer:_loginPhone];
    _loginPhone.keyboardType = UIKeyboardTypePhonePad;
    //设置密码的textfield的左边框
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
        
    }
    if (_pwdField.text.length != 0) {
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        ViewController * vc = [sb instantiateViewControllerWithIdentifier:@"ViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
/**
 *  注册
 *
 *  @param sender
 */
- (IBAction)registeredBtn:(UIButton *)sender {
    
    
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
