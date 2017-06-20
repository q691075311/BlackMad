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
#import "ClassTypeList.h"


typedef enum :NSUInteger{
    Type_Act,
    Type_Ticket
}contentType;

@interface ClassDetailController ()<UITableViewDelegate,UITableViewDataSource,ClassHeadViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) contentType type;
@property (nonatomic,strong) NSMutableArray * actArr;
@property (nonatomic,strong) NSMutableArray * ticketArr;
@property (nonatomic,strong) NSMutableArray * classType;
@property (nonatomic,copy) NSArray * orderTicketArr;
@property (nonatomic,copy) NSArray * orderClassArr;
@property (nonatomic,assign) int pageNum;
//搜索内容
@property (nonatomic,copy) NSString * searchStr;
//productID
@property (nonatomic,copy) NSString * productIDNum;
//排序方式
@property (nonatomic,copy) NSString * orderContent;
//排序类型
@property (nonatomic,copy) NSString * orderType;

@end

@implementation ClassDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.isAppearLineView = YES;
    self.actArr = [NSMutableArray array];
    self.ticketArr = [NSMutableArray array];
    self.classType = [NSMutableArray array];
    _orderTicketArr = @[@"recommended_level desc",@"card_type desc",@"create_date desc",@"card_volume_present_price asc"];
    _orderClassArr = @[@"recommended_level desc",@"product_name desc",@"create_date desc"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _pageNum = 1;
    //初始化页面全部变量的值
    _orderContent = @"";
    if (self.userInfo[@"productID"] == nil) {
        _productIDNum = @"";
    }else{
        _productIDNum = self.userInfo[@"productID"];
    }
    if (self.userInfo[@"parameter"] == nil) {
        _searchStr = @"";
    }else{
        _searchStr = self.userInfo[@"parameter"];
    }
    
    [self setNavBarData];
    [self getClassMoreListRequest];
    [self setMJRefreshFooter];
    
}


//获取请求的数据（设置导航栏）
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
                                 withSearchName:_searchStr];
    }else if ([self.userInfo[@"flg"] isEqualToString:@"tick"]){
        //分类-卡券-More
        self.type = Type_Ticket;
        [self.navBar configNavBarTitle:@"分类" WithLeftView:@"back" WithRigthView:nil];
        [self hotRecommendSearchWithCurrentPage:@"1"
                               withItemsperpage:@"100"
                                 withOrderGuize:@""
                              withProductTypeId:_productIDNum
                                 withSearchName:@""];
    }else{
        //分类-活动-More
        self.type = Type_Act;
        [self.navBar configNavBarTitle:@"分类" WithLeftView:@"back" WithRigthView:nil];
        [_actArr removeAllObjects];
        [self getActOrQuanInfoRequestWithPage:@"1"
                                withProductID:_productIDNum
                               withOrderGuize:@""];
    }
}
//设置上拉加载的逻辑
- (void)setMJRefreshFooter{
    if ([self.tableView.mj_footer isRefreshing]) {
        return;
    }
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"上拉获取新数据");
        _pageNum++;
        if (_type == Type_Act) {
            //分类-活动-More
            [self getActOrQuanInfoRequestWithPage:[NSString stringWithFormat:@"%d",_pageNum]
                                    withProductID:_productIDNum
                                   withOrderGuize:_orderContent];
        }else{
            if ([self.userInfo[@"form"] isEqualToString:@"Main"]) {
                //搜索界面跳转过来的
                [self hotRecommendSearchWithCurrentPage:[NSString stringWithFormat:@"%d",_pageNum]
                                       withItemsperpage:@"100"
                                         withOrderGuize:_orderContent
                                      withProductTypeId:_productIDNum
                                         withSearchName:_searchStr];
            }else if ([self.userInfo[@"flg"] isEqualToString:@"tick"]){
                //分类-卡券-More
                [self hotRecommendSearchWithCurrentPage:[NSString stringWithFormat:@"%d",_pageNum]
                                       withItemsperpage:@"100"
                                         withOrderGuize:_orderContent
                                      withProductTypeId:_productIDNum
                                         withSearchName:_searchStr];
            }
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}



//加载顶部View
- (void)loadTopBarView{
    NSMutableArray * nameArr = [NSMutableArray array];
    ClassDetailHeadView * topView = [[ClassDetailHeadView alloc] initWithFrame:CGRectMake(0, 64, DWIDTH, 40)];
    if (_type == Type_Act) {
        topView.orderArr = @[@"默认",@"首字母排序",@"时间排序"];
    }else if (_type == Type_Ticket){
        topView.orderArr = @[@"默认",@"首字母排序",@"时间排序",@"价格排序"];
    }
    for (ClassTypeList * typeList in self.classType) {
        [nameArr addObject:typeList.typeName];
    }
    topView.classArr = nameArr;
    topView.backgroundColor = [UIColor whiteColor];
    topView.delegate = self;
    [self.view addSubview:topView];
}
#pragma mark -- ClassHeadViewDelegate
- (void)chooseClassBtnTag:(NSInteger)btnTag{
    //分类选项的选择
    [_actArr removeAllObjects];
    [_ticketArr removeAllObjects];
    _pageNum = 1;
    //获取ID
    ClassTypeList * typeList = _classType[btnTag];
    NSString * proID = [NSString stringWithFormat:@"%@",typeList.ID];
    if ([proID isEqualToString:@"-10086"]) {
        proID = @"";
    }
    _productIDNum = proID;
    if (_type == Type_Act) {
        [self getActOrQuanInfoRequestWithPage:@"1"
                                withProductID:_productIDNum
                               withOrderGuize:_orderContent];
    }else if (_type == Type_Ticket){
        if ([self.userInfo[@"form"] isEqualToString:@"Main"]) {
            //搜索界面跳转过来的
            [self hotRecommendSearchWithCurrentPage:@"1"
                                   withItemsperpage:@"100"
                                     withOrderGuize:_orderContent
                                  withProductTypeId:_productIDNum
                                     withSearchName:_searchStr];
        }else if ([self.userInfo[@"flg"] isEqualToString:@"tick"]){
            //分类-卡券-More
            [self hotRecommendSearchWithCurrentPage:@"1"
                                   withItemsperpage:@"100"
                                     withOrderGuize:_orderContent
                                  withProductTypeId:_productIDNum
                                     withSearchName:@""];
        }
    }
}
- (void)chooseOrderbtnTag:(NSInteger)btnTag{
    [_actArr removeAllObjects];
    [_ticketArr removeAllObjects];
    _pageNum = 1;
    //排序选项的选择
//    NSString * productID = self.userInfo[@"productID"];
    if (_type == Type_Act) {
        _orderContent = _orderClassArr[btnTag];
        [self getActOrQuanInfoRequestWithPage:@"1"
                                withProductID:_productIDNum
                               withOrderGuize:_orderContent];
    }else if (_type == Type_Ticket){
        _orderContent = _orderTicketArr[btnTag];
        if ([self.userInfo[@"form"] isEqualToString:@"Main"]) {
            //搜索页面
            [self hotRecommendSearchWithCurrentPage:@"1"
                                   withItemsperpage:@"100"
                                     withOrderGuize:_orderContent
                                  withProductTypeId:_productIDNum
                                     withSearchName:_searchStr];
        }else if ([self.userInfo[@"flg"] isEqualToString:@"tick"]){
            //分类卡券-More
            [self hotRecommendSearchWithCurrentPage:@"1"
                                   withItemsperpage:@"100"
                                     withOrderGuize:_orderContent
                                  withProductTypeId:_productIDNum
                                     withSearchName:@""];
        }
    }
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
                                     withOrderGuize:orderGuize
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
//搜索的方法   卡券的请求
- (void)hotRecommendSearchWithCurrentPage:(NSString *)currentPage withItemsperpage:(NSString *)itemsperpage withOrderGuize:(NSString *)orderGuize withProductTypeId:(NSString *)productTypeId withSearchName:(NSString *)searchName{
    [AFNRequest hotRecommendWithCurrentPage:currentPage
                           withItemsperpage:itemsperpage
                             withOrderGuize:orderGuize
                          withProductTypeId:productTypeId
                             withSearchName:searchName
                               withComplete:^(NSDictionary *dic) {
                                   NSLog(@"------------------%@",dic);
                                   [self.tableView.mj_footer endRefreshing];
                                   NSDictionary * diction = dic[@"attribute"];
                                   NSArray * arr = diction[@"list"];
                                   if (arr.count>0) {
                                       for (NSDictionary * dictionary in arr) {
                                           MyTicketModle * ticket = [[MyTicketModle alloc] initWithDic:dictionary];
                                           [_ticketArr addObject:ticket];
                                       }
                                   }else{
                                       [self.tableView.mj_footer endRefreshingWithNoMoreData];
                                   }
                                   
                                   [self.tableView reloadData];
                               }];
}

//获取topView的请求
- (void)getClassMoreListRequest{
    NSString * type;
    if (_type == Type_Act) {
        type = @"ACT";
    }else{
        type = @"CARD";
    }
    [AFNRequest getClassMoreTypeListWithType:type withComplete:^(NSDictionary *dic) {
        NSDictionary * diction = dic[@"attribute"];
        NSArray * arr = diction[@"list"];
        ClassTypeList * type0 = [[ClassTypeList alloc] init];
        type0.ID = @(-10086);
        type0.pictureAddress = @"";
        type0.typeName = @"全部";
        [self.classType insertObject:type0 atIndex:0];
        for (NSDictionary * dictionary in arr) {
            ClassTypeList * typeList = [[ClassTypeList alloc] initWithDic:dictionary];
            [self.classType addObject:typeList];
        }
        //加载topView
        [self loadTopBarView];
    }];
}

#pragma mark -- touchRigth
- (void)touchRigthBtn{
    NSLog(@"%@",self.navBar.searchBar.text);
    _pageNum = 1;
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
