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

@end

@implementation UserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navBar configNavBarTitle:@"个人中心" WithLeftView:@"back" WithRigthView:nil];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1];
    UserInfoView * headView = [[UserInfoView alloc] initWithFrame:CGRectMake(0, 0, DWIDTH, 140)];
    _tableView.tableHeaderView = headView;
    _tableView.tableFooterView.frame = CGRectZero;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
#pragma mark--UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /**
     *  假数据
     */
    NSArray * titleArr = @[@"完善个人信息",
                           @"我的券",
                           @"账户管理"];
    NSArray * imageArr= @[@"userinfo",
                          @"myjuan",
                          @"userguanli"];
    
    /**
     *  假数据
     */
    UserInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoCell" forIndexPath:indexPath];
    cell.setTitle.text = titleArr[indexPath.row];
    cell.setImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArr[indexPath.row]]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52;
}

- (void)touchLeftBtn{
    [self.navigationController popViewControllerAnimated:YES];
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
