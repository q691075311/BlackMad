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
#import "DataModels.h"
#import "YYModel.h"

@interface ClassController ()<UITableViewDelegate,UITableViewDataSource,ClassDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray * actArr;
@end

@implementation ClassController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navBar.isAppearLineView = YES;
    self.actArr = [NSMutableArray array];
    [self.navBar configNavBarTitle:@"分类" WithLeftView:nil WithRigthView:nil];
    [self initTableViewHeadView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getClassActRequest];
}
//初始化tableView的头视图
- (void)initTableViewHeadView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    ClassHeadView * headView = [[ClassHeadView alloc]initWithFrame:CGRectMake(0, 64, DWIDTH, 52)];
    [self.view addSubview:headView];
}
#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _actArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ClassCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ClassCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.actList = _actArr[indexPath.row];
    cell.moreBtn.tag = indexPath.row;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 165;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark -- network
- (void)getClassActRequest{
    [self.actArr removeAllObjects];
    [AFNRequest classActWithComplete:^(id responseObject) {
        ActClassActModle *act = (ActClassActModle *)[ActClassActModle yy_modelWithJSON:responseObject];
        for (NSDictionary *dic in act.attribute.list) {
            ActList *list = [ActList modelObjectWithDictionary:dic];
            [self.actArr addObject:list];
        }
        [self.tableView reloadData];
    }];
}


#pragma mark -- ClassDelegate
- (void)cilckMoreBtn:(UIButton *)btn{
    //获取productTypeID
    NSInteger tag = btn.tag;
    ActList *list = _actArr[tag];
    NSInteger actID = list.listIdentifier;
    [self pushToController:@"ClassDetailController"
            WithStoyBordID:@"class"
                  WithForm:self
                  WithInfo:@{@"productID":@(actID)}];
}
- (void)cilckCellBtnWithActProductList:(ActProductList *)actPro{
    [self pushToController:@"BlackWebController"
            WithStoyBordID:@"Main"
                  WithForm:self
                  WithInfo:@{@"webviewURL":actPro.promotionalWapLink}];
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
