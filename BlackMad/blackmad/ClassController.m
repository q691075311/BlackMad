//
//  ClassController.m
//  blackmad
//
//  Created by taobo on 17/5/31.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "ClassController.h"
#import "ClassCell.h"
#import "ClassHeadView.h"

@interface ClassController ()<UITableViewDelegate,UITableViewDataSource,ClassDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ClassController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navBar.isAppearLineView = YES;
    [self.navBar configNavBarTitle:@"分类" WithLeftView:nil WithRigthView:nil];
    [self initTableViewHeadView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [AFNRequest classActWithComplete:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
    }];
}
//初始化tableView的头视图
- (void)initTableViewHeadView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    ClassHeadView * headView = [[ClassHeadView alloc]initWithFrame:CGRectMake(0, 0, DWIDTH, 52)];
    self.tableView.tableHeaderView = headView;
}
#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ClassCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ClassCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.moreBtn.tag = indexPath.row;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 165;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark -- ClassDelegate
- (void)cilckMoreBtn:(UIButton *)btn{
//    NSLog(@"%d",btn.tag);
    [self pushToController:@"ClassDetailController"
            WithStoyBordID:@"class"
                  WithForm:self
                  WithInfo:@{}];
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
