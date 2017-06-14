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

@interface ClassDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray * actArr;
@property (nonatomic,assign) int pageNum;
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
    self.actArr = [NSMutableArray array];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _pageNum = 1;
    [self loadTopBarView];
    [self setMJRefreshFooter];
    
}

- (void)setMJRefreshFooter{
    NSString * productID = self.userInfo[@"productID"];
    if ([self.tableView.mj_footer isRefreshing]) {
        return;
    }
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"上拉获取新数据");
        _pageNum++;
        [self getActOrQuanInfoRequestWithPage:[NSString stringWithFormat:@"%d",_pageNum]
                                withProductID:productID
                               withOrderGuize:@"create_date desc"];
        
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_actArr removeAllObjects];
    NSString * productID = self.userInfo[@"productID"];
    [self getActOrQuanInfoRequestWithPage:@"1"
                            withProductID:productID
                           withOrderGuize:@"create_date desc"];
}


//加载顶部View
- (void)loadTopBarView{
    ClassDetailHeadView * topView = [[ClassDetailHeadView alloc] initWithFrame:CGRectMake(0, 64, DWIDTH, 40)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
}
#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _actArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ClassDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ClassDetailCell" forIndexPath:indexPath];
    cell.classInfo = _actArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ClassInfo * info = self.actArr[indexPath.row];
    [self pushToController:@"BlackWebController"
            WithStoyBordID:@"Main"
                  WithForm:self
                  WithInfo:@{@"webviewURL":info.promotionalWapLink}];
    
}

#pragma mark -- network
- (void)getActOrQuanInfoRequestWithPage:(NSString *)page withProductID:(NSString *)productID withOrderGuize:(NSString *)orderGuize{
    [AFNRequest recommendProductItemWithCurrentPage:@"1"
                                     withOrderGuize:@"create_date desc"
                                  withProductTypeId:@""
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
