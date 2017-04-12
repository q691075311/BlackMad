//
//  UserInfoController.m
//  blackmad
//
//  Created by taobo on 17/3/9.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "UserInfoController.h"
#import "UserInfoView.h"
#import "UserInfoCell.h"

@interface UserInfoController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,copy) NSArray *titleArr;
@property (nonatomic,copy) NSArray *imageArr;
@property (nonatomic,strong) UserInfoView *headView;
@end

@implementation UserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navBar configNavBarTitle:@"个人中心" WithLeftView:@"back" WithRigthView:nil];
    _headView = [[UserInfoView alloc] initWithFrame:CGRectMake(0, 0, DWIDTH, 140)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    _tableView.tableHeaderView = _headView;
    _tableView.tableFooterView.frame = CGRectZero;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _titleArr = @[@"完善个人信息",
                           @"我的券",
                           @"账户管理"];
    _imageArr= @[@"userinfo",
                          @"myjuan",
                          @"userguanli"];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SVProgressHUD show];
    [self getUserInfoRequest];
}
#pragma mark--UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoCell" forIndexPath:indexPath];
    cell.setTitle.text = _titleArr[indexPath.row];
    cell.setImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_imageArr[indexPath.row]]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray * arr= @[@"ChangeUserInfoController",
                     @"MyTicketController",
                     @"AccountManagementController"];
    [self pushToController:arr[indexPath.row]
            WithStoyBordID:@"Main"
                  WithForm:self
                  WithInfo:@{}];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52;
}

//左边按钮
- (void)touchLeftBtn{
    [self.navigationController popViewControllerAnimated:YES];
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
                              NSURL * headURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,[LoginUser shareUser].user.headImage]];
                              //设置头像 昵称  电话
                              [_headView.userImage sd_setImageWithURL:headURL placeholderImage:[UIImage imageNamed:@"headimage"]];
                              _headView.userName.text = [LoginUser shareUser].user.nickname;
                              _headView.userPhone.text = [USERDEF objectForKey:@"username"];
                              [SVProgressHUD dismiss];
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
