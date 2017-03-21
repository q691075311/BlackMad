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

#define VIEWWIDTH ([UIScreen mainScreen].bounds.size.width-4)/5
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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = YES;
    [self.navBar configNavBarTitle:@"疯趣" WithLeftView:@"mainLeft" WithRigthView:nil];
    [self setFristLineView];
    _mainBtnListArr = [[NSMutableArray alloc] init];
    _productImageArr = [[NSMutableArray alloc] init];
    _productTitleArr = [[NSMutableArray alloc] init];
    _productIDArr = [[NSMutableArray alloc] init];
    _bannerListArr = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = _headView;
    self.navigationController.navigationBar.hidden = YES;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self netWorkRequest];
    
}

//加载首页btn的view
- (void)loadMainBtnView{
    [_productImageArr removeAllObjects];
    [_productTitleArr removeAllObjects];
    [_productIDArr removeAllObjects];
    for (MainBtnListModle * modle in _mainBtnListArr) {
        [_productIDArr addObject:@(modle.productListID)];
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
- (void)touchBtnWithBtn:(UIButton *)btn WithProductID:(int)productID{
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
    };
}
#pragma mark--UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MainCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 230;
}
#pragma mark--左btn按钮
- (void)touchLeftBtn{
    //进入个人中心
    [self pushToController:@"UserInfoController"
            WithStoyBordID:@"Main"
                  WithForm:self
                  WithInfo:@{}];
    
}
#pragma mark--网络请求

- (void)netWorkRequest{
    //请求产品类型列表
    [AFNRequest requestWithDataURL:productList
                      WithComplete:^(NSDictionary *dic) {
                          [_mainBtnListArr removeAllObjects];
                          NSDictionary * mainDic = dic[@"attribute"];
                          NSArray * arr = mainDic[@"list"];
                          for (NSDictionary * dic1 in arr) {
                              MainBtnListModle * modle = [[MainBtnListModle alloc] initWithDic:dic1];
                              [_mainBtnListArr addObject:modle];
                          }
                          
                          [self loadMainBtnView];
                      }];
    //请求banner产品的列表
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
