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
@property (nonatomic,copy) NSArray *titleOfSectionArr;
@property (nonatomic,copy) NSArray *imageOfSectionArr;
@property (nonatomic,copy) NSArray *pushArr;
@property (nonatomic,copy) NSArray *imageArr;
@property (nonatomic,strong) UserInfoView *headView;
@end

@implementation UserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navBar configNavBarTitle:@"个人中心" WithLeftView:nil WithRigthView:nil];
    _headView = [[UserInfoView alloc] initWithFrame:CGRectMake(0, 0, DWIDTH, 140)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    _tableView.tableHeaderView = _headView;
    _tableView.tableFooterView.frame = CGRectZero;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self initViewData];
}

- (void)initViewData{
    //页面title
    NSArray *oneTitleArr = @[@"完善个人信息",
                             @"我的券",
                             @"账户管理",
                             @"我的收藏"];
    NSArray *twoTitleArr = @[@"新手帮助",
                             @"投诉建议"];
    _titleOfSectionArr = @[oneTitleArr,twoTitleArr];
    //页面图片
    NSArray *oneImageArr= @[[UIImage imageNamed:@"userinfo"],
                            [UIImage imageNamed:@"myjuan"],
                            [UIImage imageNamed:@"userguanli"],
                            [UIImage imageNamed:@"collect"]];
    NSArray *twoImageArr = @[[UIImage imageNamed:@"help"],
                             [UIImage imageNamed:@"advice"]];
    _imageOfSectionArr = @[oneImageArr,twoImageArr];
    NSArray * pushOneArr= @[@"ChangeUserInfoController",
                            @"MyTicketController",
                            @"AccountManagementController",
                            @"MyCollectionController"];
    NSArray * pushtwoArr = @[@"HelpController",
                             @"AdviceViewController",];
    _pushArr = @[pushOneArr,pushtwoArr];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([LoginUser shareUser].isLogin == YES) {
        [self getUserInfoRequest];
    }else{
        [Tool presentLoginViewWithStr:@"isLogin" WithViewController:self];
    }
}
#pragma mark--UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray * arr = _titleOfSectionArr[section];
    return arr.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 10;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoCell" forIndexPath:indexPath];
    cell.setTitle.text = _titleOfSectionArr[indexPath.section][indexPath.row];
    cell.setImage.image = _imageOfSectionArr[indexPath.section][indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString * str;
    //这是卡券页面
    NSIndexPath * index = [NSIndexPath indexPathForRow:1 inSection:0];
    if (indexPath == index) {
        str = @"Main";
    }else{
        str = @"User";
    }
    [self pushToController:_pushArr[indexPath.section][indexPath.row]
            WithStoyBordID:str
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
