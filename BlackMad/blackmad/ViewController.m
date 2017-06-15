//
//  ViewController.m
//  blackmad
//
//  Created by taobo on 17/3/8.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "ViewController.h"
#import "XRCarouselView.h"
#import "MainheadView.h"
#import "MainBtnView.h"
#import "MainCell.h"
#import "UserInfoController.h"
#import "MainBtnListModle.h"
#import "BannerListModle.h"
#import "BlackWebController.h"
#import "MJRefresh.h"
#import "MainProductModle.h"
#import "LoginController.h"
#import "MainItemView.h"
#import "ActProductList.h"
#import "MyTicketModle.h"
#import "TicketInfoController.h"



typedef enum:NSUInteger{
    refreshing,
    notRefresh
}RefreshType;

@interface ViewController ()<MainBtnViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,MainItemDelegate>
@property (weak, nonatomic) IBOutlet XRCarouselView *XRCarouselView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet MainheadView *headView;
@property (nonatomic,strong) MainBtnView * btnView;
@property (nonatomic,strong) UIView * lineView;
@property (nonatomic,strong) NSMutableArray * mainBtnListArr;
//@property (nonatomic,strong) NSMutableArray * productIDArr;
//@property (nonatomic,strong) NSMutableArray * productImageArr;
//@property (nonatomic,strong) NSMutableArray * productTitleArr;
@property (nonatomic,strong) NSMutableArray * bannerListArr;
@property (nonatomic,strong) NSMutableArray * mainProductArr;
@property (nonatomic,assign) RefreshType refreshType;
@property (nonatomic,copy) NSString * lastID;//记录上个产品ID
@property (nonatomic,copy) NSString * currentId;
@property (nonatomic,assign) int pageNum;
@property (nonatomic,strong) NSMutableArray * mainBtnArr;
@property (nonatomic,strong) NSMutableArray * ticketArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = YES;
    [self.navBar configNavBarTitle:@"疯趣" WithLeftView:nil WithRigthView:nil];
    self.view.backgroundColor = COLORWITHRGB(238, 238, 238);
//    [self setMJRefreshFooter];
    _refreshType = notRefresh;
    [self initDateAndTableView];
    [self netWorkRequest];
    [self requestBannerProductType];
    [self loadTableViewHeadTitle];
    [self loadSearchBar];
    [self requestProductListWithCurrentPage:@"" WithProductTypeId:@""];
    
}
- (void)initDateAndTableView{
    _mainBtnListArr = [[NSMutableArray alloc] init];
    _bannerListArr = [[NSMutableArray alloc] init];
    _mainProductArr = [[NSMutableArray alloc] init];
    _mainBtnArr = [NSMutableArray array];
    _ticketArr = [NSMutableArray array];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = _headView;
    self.tableView.backgroundColor = COLORWITHRGB(255, 255, 255);
    self.tableView.sectionHeaderHeight = 32;
    
}

- (void)setMJRefreshFooter{
    if ([self.tableView.mj_footer isRefreshing]) {
        return;
    }
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        _refreshType = refreshing;
        NSLog(@"上拉获取新数据");
        _pageNum++;
        NSLog(@"%d",_pageNum);
//        [self requestProductListWithCurrentPage:[NSString stringWithFormat:@"%d",_pageNum] WithProductTypeId:_currentId];
    }];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

//加载搜索框
- (void)loadSearchBar{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 180, DWIDTH, 60)];
    view.backgroundColor = [UIColor whiteColor];
    UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 10, DWIDTH-20, 60-20)];
    UIView * leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90+11, 60)];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(9, 19, 62, 18)];
    label.text = @"疯趣热搜";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [Tool appRedColor];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(75, 20, 15, 15)];
    imageView.image = [UIImage imageNamed:@"searchLeft"];
    [leftView addSubview:label];
    [leftView addSubview:imageView];
    textField.backgroundColor = COLORWITHRGB(244, 244, 244);
    textField.layer.masksToBounds = YES;
    textField.layer.cornerRadius = 5;
    textField.leftView = leftView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeySearch;
    textField.placeholder = @"千万产品任君挑选";
    textField.font = [UIFont systemFontOfSize:14];
    [view addSubview:textField];
    [_headView addSubview:view];
}
//加载tableView的标题
- (void)loadTableViewHeadTitle{
    UIView * view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 386, DWIDTH, 32);
    view.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 70, 22)];
    label.text = @"热门推荐";
    label.textColor = COLORWITHRGB(169, 143, 93);
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:16];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(DWIDTH-55, 10, 45, 20);
    btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    [btn setTitleColor:COLORWITHRGB(169, 143, 93) forState:UIControlStateNormal];
    [btn setTitle:@"More>" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(moreBtn) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    [view addSubview:label];
    [_headView addSubview:view];
}
#pragma mark -- More点击事件
- (void)moreBtn{
    NSLog(@"首页moreBtn");
}
#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self pushToController:@"ClassDetailController"
            WithStoyBordID:@"class"
                  WithForm:self
                  WithInfo:@{@"form":@"Main"}];
    return YES;
}
#pragma mark -- MainItemDelegate
- (void)chooseBtnTag:(NSInteger)tag{
    ActProductList * actPro = [[ActProductList alloc] initWithDictionary:_mainBtnArr[tag]];
    [self pushToController:@"BlackWebController"
            WithStoyBordID:@"Main"
                  WithForm:self
                  WithInfo:@{@"webviewURL":actPro.promotionalWapLink}];
    
    NSLog(@"%ld",(long)tag);
}

#pragma mark--MainBtnViewDelegate
- (void)touchBtnWithBtn:(UIButton *)btn WithProductID:(NSNumber *)productID{
    [self setMJRefreshFooter];
    _refreshType = refreshing;
    //判断是否是上拉刷新
    if (_refreshType == notRefresh || ![_lastID isEqualToString:[NSString stringWithFormat:@"%@",productID]]) {
        //不是上拉加载或者是新点击的ID
        [_mainProductArr removeAllObjects];
        _lastID = [NSString stringWithFormat:@"%@",productID];
    }else if ([_lastID isEqualToString:[NSString stringWithFormat:@"%@",productID]]) {
        [_mainProductArr removeAllObjects];
    }
    NSLog(@"产品类型的ID%@",productID);
    self.currentId = [NSString stringWithFormat:@"%@",productID];
    [self requestProductListWithCurrentPage:@"1"
                          WithProductTypeId:[NSString stringWithFormat:@"%@",productID]];
    _pageNum = 1;
}

//加载广告页
- (void)loadXRCarouselView{
    NSMutableArray * arr = [[NSMutableArray alloc] init];
    for (BannerListModle * bannerm in _bannerListArr) {
        NSString * imageURL = [NSString stringWithFormat:@"%@%@",IMAGEURL,bannerm.bannerPicturePath];
        [arr addObject:imageURL];
    }
    _XRCarouselView.imageArray = arr;
    _XRCarouselView.time = 2;
    _XRCarouselView.changeMode = ChangeModeDefault;
    _XRCarouselView.imageClickBlock = ^(NSInteger index){
        NSLog(@"点击了第%ld张图",(long)index);
        if ([LoginUser shareUser].isLogin) {
            BannerListModle * ban = _bannerListArr[index];
            NSLog(@"%@",ban.bannerWapLink);
            [self pushToController:@"BlackWebController"
                    WithStoyBordID:@"Main"
                          WithForm:self
                          WithInfo:@{@"webviewURL":ban.bannerWapLink}];
        }else{
            [self toLogin];
        }
    };
}
#pragma mark--UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _ticketArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell" forIndexPath:indexPath];
    cell.ticketModle = _ticketArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([LoginUser shareUser].isLogin) {
        MyTicketModle * ticketModle = _ticketArr[indexPath.row];
        TicketInfoController * ticketInfo = [[TicketInfoController alloc] init];
        ticketInfo.ticketModle = ticketModle;
        [self.navigationController pushViewController:ticketInfo animated:YES];
    }else{
        [self toLogin];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 202;
}
#pragma mark--跳转登录页面
- (void)toLogin{
    [Tool presentLoginViewWithStr:@"isLogin" WithViewController:self];
}
#pragma mark--左btn按钮
- (void)touchLeftBtn{
    
}
#pragma mark--网络请求

- (void)netWorkRequest{
    [AFNRequest recommendProductItemWithCurrentPage:@""
                                     withOrderGuize:@"create_date desc"
                                  withProductTypeId:@""
                                       withComplete:^(NSDictionary *dic) {
                                           
                                           NSDictionary * diction = dic[@"attribute"];
                                           NSArray * arr = diction[@"list"];
                                           for (NSDictionary * dictionary in arr) {
                                               ActProductList * actPro = (ActProductList *)dictionary;
                                               [_mainBtnArr addObject:actPro];
                                           }
                                           //加载首页Btn
                                           MainItemView * view = [[MainItemView alloc] initWithData:_mainBtnArr];
                                           view.delegate = self;
                                           [_headView addSubview:view];
                                       }];

    
    //请求产品类型列表
//    [AFNRequest requestWithDataURL:productTypeList
//                      WithComplete:^(NSDictionary *dic) {
//                          [_mainBtnListArr removeAllObjects];
//                          NSDictionary * mainDic = dic[@"attribute"];
//                          NSArray * arr = mainDic[@"list"];
//                          for (NSDictionary * dic1 in arr) {
//                              MainBtnListModle * modle = [[MainBtnListModle alloc] initWithDic:dic1];
//                              [_mainBtnListArr addObject:modle];
//                          }
//                          //添加全部的分类
//                          MainBtnListModle * allModle = [[MainBtnListModle alloc] init];
//                          allModle.productListID = @(-1);
//                          allModle.productListImage = @"";
//                          allModle.productListTitle = @"全部";
//                          [_mainBtnListArr insertObject:allModle atIndex:0];
//                          
//                          MainBtnListModle * modle = _mainBtnListArr[0];
//                          [self loadMainBtnView];
//                          [self requestProductListWithCurrentPage:@"1"
//                                                WithProductTypeId:@""];
//                          self.lastID = [NSString stringWithFormat:@"%@",modle.productListID];
//                          self.currentId = [NSString stringWithFormat:@"%@",modle.productListID];
//                          self.pageNum = 1;
//                      }];
}
//请求banner产品的列表
- (void)requestBannerProductType{
    [AFNRequest requestWithBannerURL:banner
                        WithComplete:^(NSDictionary *dic) {
                            [_bannerListArr removeAllObjects];
                            NSDictionary * dic1 = dic[@"attribute"];
                            NSArray * arr = dic1[@"list"];
                            for (NSDictionary * dic2 in arr) {
                                BannerListModle * bannerm = [[BannerListModle alloc] initWithDic:dic2];
                                [_bannerListArr addObject:bannerm];
                            }
                            [self loadXRCarouselView];
                        }];
}
//请求产品的列表内容
- (void)requestProductListWithCurrentPage:(NSString *)currentPage WithProductTypeId:(NSString *)productTypeId{
    [AFNRequest hotRecommendWithCurrentPage:@"1"
                           withItemsperpage:@"100"
                             withOrderGuize:@"recommended_level desc"
                          withProductTypeId:@""
                             withSearchName:@""
                               withComplete:^(NSDictionary *dic) {
                                   NSDictionary * diction = dic[@"attribute"];
                                   NSArray * arr = diction[@"list"];
                                   for (NSDictionary * dictionary in arr) {
                                       MyTicketModle * ticket = [[MyTicketModle alloc] initWithDic:dictionary];
                                       [_ticketArr addObject:ticket];
                                   }
                                   NSLog(@"%@",_ticketArr);
                                   [self.tableView reloadData];
                               }];
    
    
    
    
//    [AFNRequest requestProductListWithURL:RECOMMEND
//                          WithCurrentPage:currentPage
//                        WithProductTypeId:productTypeId
//                             WithComplete:^(NSDictionary *dic) {
//                                 NSLog(@"%@",dic);
//                                 [self.tableView.mj_footer endRefreshing];
//                                 NSDictionary * dic1 = dic[@"attribute"];
//                                 NSArray * arr = dic1[@"list"];
//                                 if (arr.count > 0) {
//                                     for (NSDictionary * dic2 in arr) {
//                                         MainProductModle * proModle = [[MainProductModle alloc] initWithDic:dic2];
//                                         [_mainProductArr addObject:proModle];
//                                     }
//                                 }else{
//                                     NSLog(@"没有更多数据了");
//                                     [self.tableView.mj_footer endRefreshingWithNoMoreData];
//                                 }
//                                 
//                                 [self.tableView reloadData];
//                             }];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
