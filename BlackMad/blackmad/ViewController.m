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

typedef enum:NSUInteger{
    refreshing,
    notRefresh
}RefreshType;

@interface ViewController ()<MainBtnViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet XRCarouselView *XRCarouselView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet MainheadView *headView;
@property (nonatomic,strong) MainBtnView * btnView;
@property (nonatomic,strong) UIView * lineView;
@property (nonatomic,strong) NSMutableArray * mainBtnListArr;
@property (nonatomic,strong) NSMutableArray * productIDArr;
@property (nonatomic,strong) NSMutableArray * productImageArr;
@property (nonatomic,strong) NSMutableArray * productTitleArr;
@property (nonatomic,strong) NSMutableArray * bannerListArr;
@property (nonatomic,strong) NSMutableArray * mainProductArr;
@property (nonatomic,assign) RefreshType refreshType;
@property (nonatomic,copy) NSString * lastID;//记录上个产品ID
@property (nonatomic,copy) NSString * currentId;
@property (nonatomic,assign) int pageNum;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = YES;
    [self.navBar configNavBarTitle:@"疯趣" WithLeftView:@"mainLeft" WithRigthView:nil];
    [self setFristLineView];
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    self.tableView.backgroundColor = COLORWITHRGB(246, 246, 246);
    [self setMJRefreshFooter];
    _refreshType = notRefresh;
    _mainBtnListArr = [[NSMutableArray alloc] init];
    _productImageArr = [[NSMutableArray alloc] init];
    _productTitleArr = [[NSMutableArray alloc] init];
    _productIDArr = [[NSMutableArray alloc] init];
    _bannerListArr = [[NSMutableArray alloc] init];
    _mainProductArr = [[NSMutableArray alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = _headView;
    self.navigationController.navigationBar.hidden = YES;
    
    [self netWorkRequest];
    [self requestBannerProductType];
    [self isShowLogin];
    
}
- (void)isShowLogin{
    if ([self.isAD isEqualToString:@"FormAD"]) {
        [self presentLoginViewWithStr:@"isReg"];
    }else{
        
    }
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
        [self requestProductListWithCurrentPage:[NSString stringWithFormat:@"%d",_pageNum] WithProductTypeId:_currentId];
    }];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self starAnimateWithBtnTag:0];
    
}

//加载首页btn的view
- (void)loadMainBtnView{
    [_productImageArr removeAllObjects];
    [_productTitleArr removeAllObjects];
    [_productIDArr removeAllObjects];
    for (MainBtnListModle * modle in _mainBtnListArr) {
        [_productIDArr addObject:modle.productListID];
        [_productTitleArr addObject:modle.productListTitle];
        [_productImageArr addObject:modle.productListImage];
    }
    _btnView = [[MainBtnView alloc] initWithFrame:CGRectMake(0, 190, DWIDTH, 88)
                                    WithProductID:_productIDArr
                                 WithProductImage:_productImageArr
                              WithProductTitleArr:_productTitleArr];
    _btnView.delegate = self;
    [_headView addSubview:_btnView];
}

- (void)setFristLineView{
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 278, VIEWWIDTH, 1)];
    _lineView.backgroundColor = [UIColor whiteColor];
    [_headView addSubview:_lineView];
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
    [self starAnimateWithBtnTag:btn.tag-100];
}
- (void)starAnimateWithBtnTag:(long)i{
    [UIView animateWithDuration:0.3 animations:^{
        _lineView.backgroundColor = [UIColor whiteColor];
        _lineView.frame = CGRectMake(i*(VIEWWIDTH+1), 278, VIEWWIDTH, 1);
    }];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mainProductArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell" forIndexPath:indexPath];
    cell.productModle = _mainProductArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([LoginUser shareUser].isLogin) {
        MainProductModle * modle = _mainProductArr[indexPath.row];
        [self pushToController:@"BlackWebController"
                WithStoyBordID:@"Main"
                      WithForm:self
                      WithInfo:@{@"webviewURL":modle.promotionalWapLink}];
    }else{
        [self toLogin];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 250;
}
#pragma mark--跳转登录页面
- (void)toLogin{
    [self pushToController:@"LoginController"
            WithStoyBordID:@"Main"
                  WithForm:self
                  WithInfo:@{}];
}
#pragma mark--左btn按钮
- (void)touchLeftBtn{
    if ([LoginUser shareUser].isLogin) {
        //进入个人中心
        [self pushToController:@"UserInfoController"
                WithStoyBordID:@"Main"
                      WithForm:self
                      WithInfo:@{}];
    }else{
        //进入登录页面
//        [self pushToController:@"LoginController"
//                WithStoyBordID:@"Main"
//                      WithForm:self
//                      WithInfo:@{}];
        [self presentLoginViewWithStr:@"isLogin"];
    }
}
#pragma mark--网络请求

- (void)netWorkRequest{
    //请求产品类型列表
    [AFNRequest requestWithDataURL:productTypeList
                      WithComplete:^(NSDictionary *dic) {
                          [_mainBtnListArr removeAllObjects];
                          NSDictionary * mainDic = dic[@"attribute"];
                          NSArray * arr = mainDic[@"list"];
                          for (NSDictionary * dic1 in arr) {
                              MainBtnListModle * modle = [[MainBtnListModle alloc] initWithDic:dic1];
                              [_mainBtnListArr addObject:modle];
                          }
                          //添加全部的分类
                          MainBtnListModle * allModle = [[MainBtnListModle alloc] init];
                          allModle.productListID = @(-1);
                          allModle.productListImage = @"";
                          allModle.productListTitle = @"全部";
                          [_mainBtnListArr insertObject:allModle atIndex:0];
                          
                          MainBtnListModle * modle = _mainBtnListArr[0];
                          [self loadMainBtnView];
                          [self requestProductListWithCurrentPage:@"1"
                                                WithProductTypeId:@""];
                          self.lastID = [NSString stringWithFormat:@"%@",modle.productListID];
                          self.currentId = [NSString stringWithFormat:@"%@",modle.productListID];
                          self.pageNum = 1;
                      }];
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
    [AFNRequest requestProductListWithURL:ProductList
                          WithCurrentPage:currentPage
                        WithProductTypeId:productTypeId
                             WithComplete:^(NSDictionary *dic) {
                                 NSLog(@"%@",dic);
                                 [self.tableView.mj_footer endRefreshing];
                                 NSDictionary * dic1 = dic[@"attribute"];
                                 NSArray * arr = dic1[@"list"];
                                 if (arr.count > 0) {
                                     for (NSDictionary * dic2 in arr) {
                                         MainProductModle * proModle = [[MainProductModle alloc] initWithDic:dic2];
                                         [_mainProductArr addObject:proModle];
                                     }
                                 }else{
                                     NSLog(@"没有更多数据了");
                                     [self.tableView.mj_footer endRefreshingWithNoMoreData];
                                 }
                                 
                                 [self.tableView reloadData];
                             }];
}
//模态弹出登录界面
- (void)presentLoginViewWithStr:(NSString *)str{
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    LoginController * vc = [sb instantiateViewControllerWithIdentifier:@"LoginController"];
    if ([str isEqualToString:@"isReg"]) {
        vc.fromFlag = @"ad";
    }else{
        
    }
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
