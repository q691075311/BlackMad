//
//  ChangeUserInfoController.m
//  blackmad
//
//  Created by taobo on 17/3/13.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "ChangeUserInfoController.h"
#import "ChooseGenderView.h"
#import "ChooseBirthdayView.h"
#import "ChooseAdressView.h"
#import "ChooseHeadTypeView.h"
#import <AVFoundation/AVFoundation.h>
#import "UserInfo.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ChangeUserInfoController ()
@property (nonatomic,strong) ChangeUserInfoContainerController * containaVC;

@end

@implementation ChangeUserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.isAppearLineView = YES;
    [self.navBar configNavBarTitle:@"完善个人信息" WithLeftView:@"back" WithRigthView:nil];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end

@interface ChangeUserInfoContainerController()<UITableViewDelegate,UITableViewDataSource,ChooseGenderDelegate,ChooseBirthdayDelegate,UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ChooseHeadTypeViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *footView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;//保存btn
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;//修改Btn
@property (nonatomic,assign) BOOL isGetUserInfo;//是否获取到用户信息
@property (nonatomic,strong) UIImagePickerController * imagePickController;
@property (nonatomic,copy) NSString * headImageStr;//头像地址

@end

@implementation ChangeUserInfoContainerController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //获取城市
    [[CitiesDataTool sharedManager] requestGetData];
    [WINDOWS addSubview:self.cover];
    _isGetUserInfo = NO;
    self.saveBtn.layer.masksToBounds = YES;
    self.saveBtn.layer.cornerRadius = 24;
    self.changeBtn.layer.masksToBounds = YES;
    self.changeBtn.layer.cornerRadius = 24;
    self.tableView.tableFooterView = self.footView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.headImage.layer.masksToBounds = YES;
    self.headImage.layer.cornerRadius = 26;
    [self setUserInfoTextWithColor:COLORWITHRGB(120, 120, 120)];
    [self setUserInteractionEnabledWith:NO];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SVProgressHUD show];
    [self getUserInfoRequest];
    
}
//更新界面内容
- (void)updataUI{
    NSURL * headURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,[LoginUser shareUser].user.headImage]];
    NSString * gender;
    if ([[LoginUser shareUser].user.sex isEqualToString:@"1"]) {
        gender = @"男";
    }else if ([[LoginUser shareUser].user.sex isEqualToString:@"2"]){
        gender = @"女";
    }else if ([[LoginUser shareUser].user.sex isEqualToString:@"3"]){
        gender = @"保密";
    }else{
        gender = @"";
    }
    [_headImage sd_setImageWithURL:headURL placeholderImage:[UIImage imageNamed:@"headimage"]];
    _nickName.text = [LoginUser shareUser].user.nickname;
    _gender.text = gender;
    _birthday.text = [LoginUser shareUser].user.birthday;
    _adress.text = [LoginUser shareUser].user.city;
}
#pragma mark--UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 72;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        //选择头像
        [self chooseHeadImage];
    }else if (indexPath.row == 2){
        //选择性别
        [self chooseGender];
    }else if (indexPath.row == 3){
        //选择生日
        [self chooseBirthday];
    }else if (indexPath.row == 4){
        //选择地区
        [self chooseAdress];
    }
}
#pragma mark--选择个人信息
/**
 *  选择头像
 */
- (void)chooseHeadImage{
    ChooseHeadTypeView * headTypeView = [[ChooseHeadTypeView alloc] initWithFrame:CGRectMake(0, 0, DWIDTH, DHIGTH)];
    headTypeView.delegate = self;
    [headTypeView show];
    _imagePickController = [[UIImagePickerController alloc] init];
    _imagePickController.delegate = self;
    _imagePickController.allowsEditing= YES;
}
#pragma mark--ChooseHeadTypeViewDelegate
//选择相机
- (void)chooseImageForCamera{
    NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        NSString *errorStr = @"应用相机权限受限,请在设置中启用";
        [SVProgressHUD showErrorWithStatus:errorStr];
        return;
    }
    
    _imagePickController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:_imagePickController animated:YES completion:^{
        
    }];
}
//选择图库
- (void)chooseImageForPhotoLibrary{
    _imagePickController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_imagePickController animated:YES completion:^{
        
    }];
}
#pragma mark--UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [_imagePickController dismissViewControllerAnimated:YES completion:^{
//        NSLog(@"%@",info);
        // 获取点击的图片
        UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        
        NSString * imageStr = [imageData base64Encoding];
        _headImage.image = image;
        //上传头像
        [self upHeadImageWith:imageStr];
        //将图片存入沙盒
        //[self saveImage:image withName:@"head.jpg"];
    }];
}
/**
 *  选择性别
 */
- (void)chooseGender{
    ChooseGenderView * view = [[ChooseGenderView alloc] initWithFrame:CGRectMake(0, 0, DWIDTH, DHIGTH)];
    view.delegate = self;
    [view show];
}
/**
 *  选择生日
 */
- (void)chooseBirthday{
    ChooseBirthdayView * view = [[ChooseBirthdayView alloc] initWithFrame:CGRectMake(0, 0, DWIDTH, DHIGTH)];
    view.delegate = self;
    [view show];
}
/**
 *  选择地区
 */
- (void)chooseAdress{
    [UIView animateWithDuration:0.25 animations:^{
//        self.view.transform =CGAffineTransformMakeScale(0.95, 0.95);
    }];
    self.cover.hidden = !self.cover.hidden;
    self.chooseLocationView.hidden = self.cover.hidden;
}
#pragma mark--保存
- (IBAction)saveBtn:(UIButton *)sender {
    [SVProgressHUD show];
    [self setUserInfoTextWithColor:COLORWITHRGB(120, 120, 120)];
    [self setUserInteractionEnabledWith:NO];
    //校验信息
    if (_adress.text == nil) {
        _adress.text = @"";
    }
    if (!_headImageStr) {
        if ([LoginUser shareUser].user.headImage.length == 0) {
            _headImageStr = @"";
        }else{
            _headImageStr = [LoginUser shareUser].user.headImage;
        }
    }
    
    NSString * gender = @"";
    if ([_gender.text isEqualToString:@"男"]) {
        gender = @"1";
    }else if ([_gender.text isEqualToString:@"女"]){
        gender = @"2";
    }
    NSLog(@"%@%@%@%@",_nickName.text,_gender.text,_birthday.text,_adress.text);
    NSMutableDictionary * mutableDic = [[NSMutableDictionary alloc] init];
    [mutableDic setValue:_birthday.text forKey:@"birthday"];
    [mutableDic setValue:_adress.text forKey:@"city"];
    [mutableDic setValue:@"中国" forKey:@"country"];
    [mutableDic setValue:_headImageStr forKey:@"headImage"];
    [mutableDic setValue:_nickName.text forKey:@"nickname"];
    [mutableDic setValue:@"" forKey:@"realName"];
    [mutableDic setValue:gender forKey:@"sex"];
    NSDictionary * dic = @{@"item":mutableDic};
    [self saveUserInfoWith:dic];
}
- (IBAction)changeInfo:(UIButton *)sender {
    [self setUserInteractionEnabledWith:YES];
    [self setUserInfoTextWithColor:COLORWITHRGB(0, 0, 0)];
}

#pragma mark--set用户信息字体颜色
- (void)setUserInfoTextWithColor:(UIColor *)color{
    _nickName.textColor = color;
    _gender.textColor = color;
    _birthday.textColor = color;
    _adress.textColor = color;
}
#pragma mark--set用户信息可交互性
- (void)setUserInteractionEnabledWith:(BOOL)booler{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:2 inSection:0];
    NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:3 inSection:0];
    NSIndexPath *indexPath3 = [NSIndexPath indexPathForRow:4 inSection:0];
    UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    UITableViewCell * cell1 = [self.tableView cellForRowAtIndexPath:indexPath1];
    UITableViewCell * cell2 = [self.tableView cellForRowAtIndexPath:indexPath2];
    UITableViewCell * cell3 = [self.tableView cellForRowAtIndexPath:indexPath3];
    cell.userInteractionEnabled = booler;
    cell1.userInteractionEnabled = booler;
    cell2.userInteractionEnabled = booler;
    cell3.userInteractionEnabled = booler;
    
    _nickName.userInteractionEnabled = booler;
    _gender.userInteractionEnabled = booler;
    _birthday.userInteractionEnabled = booler;
    _adress.userInteractionEnabled = booler;
}

#pragma mark--ChooseGenderDelegate
- (void)selectWithGender:(NSString *)gender{
    NSLog(@"%@",gender);
    _gender.text = gender;
}
#pragma mark--ChooseBirthdayDelegate
- (void)chooseDate:(NSString *)dateStr{
    _birthday.text = dateStr;
}
#pragma mark--UIGestureRecognizerDelegate
//return YES to allow both to recognize simultaneously同时
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    // locationInView 获取到的是手指点击屏幕实时的坐标点
    CGPoint point = [gestureRecognizer locationInView:gestureRecognizer.view];
    //BOOL contains = CGRectContainsPoint(CGRect rect, CGPoint point);判断一个CGPoint 是否包含再另一个UIView的CGRect里面,常用与测试给定的对象之间是否重叠
    if (CGRectContainsPoint(_chooseLocationView.frame, point)){
        return NO;
    }
    return YES;
}
- (void)tapCover:(UITapGestureRecognizer *)tap{
    
    if (_chooseLocationView.chooseFinish) {
        _chooseLocationView.chooseFinish();
    }
}
//地址选择View
- (ChooseLocationView *)chooseLocationView{
    
    if (!_chooseLocationView) {
        _chooseLocationView = [[ChooseLocationView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 212, [UIScreen mainScreen].bounds.size.width, 212)];
        
    }
    return _chooseLocationView;
}
//整个点击选择地址之后的界面View
- (UIView *)cover{
    
    if (!_cover) {
        _cover = [[UIView alloc]initWithFrame:CGRectMake(0, 0, DWIDTH, DHIGTH)];
        _cover.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        [_cover addSubview:self.chooseLocationView];
        __weak typeof (self) weakSelf = self;
        
        //选择地址之后点击_cover之后触发
        _chooseLocationView.chooseFinish = ^{
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.adress.text = weakSelf.chooseLocationView.address;
                weakSelf.view.transform = CGAffineTransformIdentity;
                weakSelf.cover.hidden = YES;
            }];
        };
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCover:)];
        [_cover addGestureRecognizer:tap];
        tap.delegate = self;
        _cover.hidden = YES;
    }
    return _cover;
}
#pragma mark - 保存图片至沙盒
- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 1);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
    UIImage *image = [UIImage imageWithContentsOfFile:fullPath];
    _headImage.image = image;
}
#pragma mark--网络请求
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
                              //设置页面属性
                              [self updataUI];
                              _isGetUserInfo = YES;
                              [SVProgressHUD dismiss];
                          }];
}
//上传头像的请求
- (void)upHeadImageWith:(NSString *)image{
    [AFNRequest requestUpheadImageWithURL:upImageURL
                                WithImage:image
                             WithComplete:^(NSDictionary *dic) {
                                 NSLog(@"%@",dic);
                                 NSDictionary * dic1 = dic[@"attribute"];
                                 _headImageStr = [NSString stringWithFormat:@"%@",dic1[@"fileUrl"]];
                                 [LoginUser shareUser].user.headImage = _headImageStr;
                             }];
}
//保存用户信息
- (void)saveUserInfoWith:(NSDictionary *)dic{
    [AFNRequest requestSaveUserInfoWithURL:SaveInfoURL WithUserInfo:dic WithComplete:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
        [SVProgressHUD dismiss];
        [SVProgressHUD showSuccessWithStatus:@"保存成功！"];
    }];
}

@end

