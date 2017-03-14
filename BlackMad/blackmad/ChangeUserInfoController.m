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

@interface ChangeUserInfoContainerController()<UITableViewDelegate,UITableViewDataSource,ChooseGenderDelegate,ChooseBirthdayDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *footView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;//保存btn


@end

@implementation ChangeUserInfoContainerController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    //获取城市
    [[CitiesDataTool sharedManager] requestGetData];
    [WINDOWS addSubview:self.cover];
    
    self.saveBtn.layer.masksToBounds = YES;
    self.saveBtn.layer.cornerRadius = 24;
    self.tableView.tableFooterView = self.footView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
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
    NSLog(@"%@%@%@%@",_nickName.text,_gender.text,_birthday.text,_adress.text);
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
@end

