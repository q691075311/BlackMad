//
//  ClassDetailController.m
//  blackmad
//
//  Created by taobo on 17/6/7.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "ClassDetailController.h"
#import "ClassDetailCell.h"
#import "ClassDetailHeadView.h"

@interface ClassDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ClassDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.isAppearLineView = YES;
    if ([self.userInfo[@"form"] isEqualToString:@"Main"]) {
        self.navBar.isAppearSearchView = YES;
        [self.navBar configNavBarTitle:@"分类" WithLeftView:@"back" WithRigthView:@"搜索"];
    }else{
        [self.navBar configNavBarTitle:@"分类" WithLeftView:@"back" WithRigthView:nil];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadTopBarView];
    
}
//加载顶部View
- (void)loadTopBarView{
    ClassDetailHeadView * topView = [[ClassDetailHeadView alloc] initWithFrame:CGRectMake(0, 64, DWIDTH, 40)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
}
#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ClassDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ClassDetailCell" forIndexPath:indexPath];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark -- touchRigth
- (void)touchRigthBtn{
    NSLog(@"搜索！！！！");
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
