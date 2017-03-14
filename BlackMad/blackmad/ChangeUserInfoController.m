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

@interface ChangeUserInfoContainerController()<UITableViewDelegate,UITableViewDataSource,ChooseGenderDelegate>
@property (weak, nonatomic) IBOutlet UIView *footView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;//保存btn

@end

@implementation ChangeUserInfoContainerController

- (void)viewDidLoad{
    [super viewDidLoad];
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
    
}
/**
 *  选择地区
 */
- (void)chooseAdress{
    
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

@end

