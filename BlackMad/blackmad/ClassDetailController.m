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
#import "ClassInfo.h"
#import "MJRefresh.h"
#import "MyTicketModle.h"
#import "TicketInfoController.h"
#import "DataModels.h"
#import "TicketDataModels.h"

typedef enum :NSUInteger{
    Type_Act,
    Type_Ticket
}contentType;

@interface ClassDetailController ()<UITableViewDelegate,UITableViewDataSource,ClassHeadViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) contentType type;
@property (nonatomic,strong) NSMutableArray * actArr;
@property (nonatomic,strong) NSMutableArray * ticketArr;
@property (nonatomic,assign) int pageNum;
@end

@implementation ClassDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.isAppearLineView = YES;
    self.actArr = [NSMutableArray array];
    self.ticketArr = [NSMutableArray array];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _pageNum = 1;
    [self setNavBarData];
    [self loadTopBarView];
    [self setMJRefreshFooter];
    
}

- (void)setNavBarData{
    if ([self.userInfo[@"form"] isEqualToString:@"Main"]) {
        //搜索界面跳转过来的
        self.type = Type_Ticket;
        self.navBar.isAppearSearchView = YES;
        [self.navBar configNavBarTitle:@"分类" WithLeftView:@"back" WithRigthView:@"搜索"];
        [self hotRecommendSearchWithCurrentPage:@"1"
                               withItemsperpage:@"100"
                                 withOrderGuize:@""
                              withProductTypeId:@""
                                 withSearchName:self.userInfo[@"parameter"]];
    }else if ([self.userInfo[@"flg"] isEqualToString:@"tick"]){
        //分类-卡券-More
        self.type = Type_Ticket;
        [self.navBar configNavBarTitle:@"分类" WithLeftView:@"back" WithRigthView:nil];
        [self hotRecommendSearchWithCurrentPage:@"1"
                               withItemsperpage:@"100"
                                 withOrderGuize:@""
                              withProductTypeId:self.userInfo[@"productID"]
                                 withSearchName:@""];
    }else{
        //分类-活动-More
        self.type = Type_Act;
        [self.navBar configNavBarTitle:@"分类" WithLeftView:@"back" WithRigthView:nil];
        [_actArr removeAllObjects];
        NSString * productID = self.userInfo[@"productID"];
        [self getActOrQuanInfoRequestWithPage:@"1"
                                withProductID:productID
                               withOrderGuize:@"create_date desc"];
    }
}

- (void)setMJRefreshFooter{
    NSString * productID = self.userInfo[@"productID"];
    if ([self.tableView.mj_footer isRefreshing]) {
        return;
    }
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"上拉获取新数据");
        _pageNum++;
        if (_type == Type_Act) {
            
            [self getActOrQuanInfoRequestWithPage:[NSString stringWithFormat:@"%d",_pageNum]
                                    withProductID:productID
                                   withOrderGuize:@"create_date desc"];
        }else{
            
            [self hotRecommendSearchWithCurrentPage:[NSString stringWithFormat:@"%d",_pageNum]
                                   withItemsperpage:@"100"
                                     withOrderGuize:@"create_date desc"
                                  withProductTypeId:@""
                                     withSearchName:self.userInfo[@"parameter"]];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


//加载顶部View
- (void)loadTopBarView{
    NSArray * arr = self.userInfo[@"titleArr"];
    NSMutableArray * nameArr = [NSMutableArray array];
    [nameArr insertObject:@"全部" atIndex:0];
    if (_type == Type_Act) {
        for (ActList *list in arr) {
            [nameArr addObject:list.typeName];
        }
    }else if (_type == Type_Ticket){
        for (TicketList * ticketList in arr) {
            [nameArr addObject:ticketList.typeName];
        }
    }
    ClassDetailHeadView * topView = [[ClassDetailHeadView alloc] initWithShowArr:nameArr];
    topView.classArr = nameArr;
    topView.orderArr = @[@"默认",@"首字母",@"时间",@"价格"];
    topView.backgroundColor = [UIColor whiteColor];
    topView.delegate = self;
    [self.view addSubview:topView];
}
#pragma mark -- ClassHeadViewDelegate
- (void)chooseClassBtnTag:(NSInteger)btnTag{
    NSLog(@"class---%d",btnTag);
}
- (void)chooseOrderbtnTag:(NSInteger)btnTag{
    NSLog(@"order---%d",btnTag);
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (_type == Type_Act) {
        return _actArr.count;
    }else{
        return _ticketArr.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ClassDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ClassDetailCell" forIndexPath:indexPath];
    if (_type == Type_Act) {
        cell.classInfo = _actArr[indexPath.row];
    }else{
        cell.ticketModle = _ticketArr[indexPath.row];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_type == Type_Act) {
        ClassInfo * info = self.actArr[indexPath.row];
        if ([LoginUser shareUser].isLogin) {
            [self pushToController:@"BlackWebController"
                    WithStoyBordID:@"Main"
                          WithForm:self
                          WithInfo:@{@"webviewURL":info.promotionalWapLink}];
        }else{
            [Tool presentLoginViewWithStr:@"isLogin" WithViewController:self];
        }
    }else{
        MyTicketModle * ticketModle = _ticketArr[indexPath.row];
        if ([LoginUser shareUser].isLogin) {
            TicketInfoController * ticketInfo = [[TicketInfoController alloc] init];
            ticketInfo.ticketModleID = ticketModle.ID;
            [self.navigationController pushViewController:ticketInfo animated:YES];
        }else{
            [Tool presentLoginViewWithStr:@"isLogin" WithViewController:self];
        }
    }
}

#pragma mark -- network
//推荐-产品列表
- (void)getActOrQuanInfoRequestWithPage:(NSString *)page withProductID:(NSString *)productID withOrderGuize:(NSString *)orderGuize{
    [AFNRequest recommendProductItemWithCurrentPage:@"1"
                                     withOrderGuize:@"create_date desc"
                                  withProductTypeId:productID
                                       withComplete:^(NSDictionary *dic) {
                                           [self.tableView.mj_footer endRefreshing];
                                           NSDictionary * diction = dic[@"attribute"];
                                           NSArray * arr = diction[@"list"];
                                           if (arr.count>0) {
                                               for (NSDictionary * dictionary in arr) {
                                                   ClassInfo * info = [[ClassInfo alloc] initWithdic:dictionary];
                                                   [_actArr addObject:info];
                                               }
                                           }else{
                                               [self.tableView.mj_footer endRefreshingWithNoMoreData];
                                           }
                                           [self.tableView reloadData];
                                       }];
}
//搜索的方法
- (void)hotRecommendSearchWithCurrentPage:(NSString *)currentPage withItemsperpage:(NSString *)itemsperpage withOrderGuize:(NSString *)orderGuize withProductTypeId:(NSString *)productTypeId withSearchName:(NSString *)searchName{
    [AFNRequest hotRecommendWithCurrentPage:currentPage
                           withItemsperpage:itemsperpage
                             withOrderGuize:orderGuize
                          withProductTypeId:productTypeId
                             withSearchName:searchName
                               withComplete:^(NSDictionary *dic) {
                                   NSLog(@"------------------%@",dic);
                                   NSDictionary * diction = dic[@"attribute"];
                                   NSArray * arr = diction[@"list"];
                                   for (NSDictionary * dictionary in arr) {
                                       MyTicketModle * ticket = [[MyTicketModle alloc] initWithDic:dictionary];
                                       [_ticketArr addObject:ticket];
                                   }
                                   [self.tableView reloadData];
                               }];
}

#pragma mark -- touchRigth
- (void)touchRigthBtn{
    NSLog(@"%@",self.navBar.searchBar.text);
    [_ticketArr removeAllObjects];
    [self hotRecommendSearchWithCurrentPage:@"1"
                           withItemsperpage:@"100"
                             withOrderGuize:@""
                          withProductTypeId:@""
                             withSearchName:self.navBar.searchBar.text];
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
