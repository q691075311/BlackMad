//
//  MyTicketController.m
//  blackmad
//
//  Created by taobo on 17/3/13.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "MyTicketController.h"
#import "MyTicketCell.h"
#import "MyTicketModle.h"
#import "MJRefresh.h"

#define BTN_HIGTH 22
#define BTN_WIDTH 50
#define BTN_DISTANTS (DWIDTH-(BTN_WIDTH*3))/6
typedef enum: NSUInteger{
    allType = 0,
    hasChangeType = 1,
    notChangeType = 2
}barType;

@interface MyTicketController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (nonatomic,strong) UIView * lineView;
@property (nonatomic,strong) UIButton * lastBtn;//记录上一个Btn
@property (nonatomic,assign) barType touchType;
@property (nonatomic,strong) NSMutableArray * myTicketArr;
@property (nonatomic,assign) int pageNum;

@end

@implementation MyTicketController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLORWITHRGB(235, 235, 235);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = COLORWITHRGB(238, 238, 238);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navBar.isAppearLineView = YES;
    self.touchType = allType;
    self.myTicketArr = [[NSMutableArray alloc] init];
    self.pageNum = 1;
    [self.navBar configNavBarTitle:@"我的券" WithLeftView:@"back" WithRigthView:nil];
    [self setMJRefreshFooter];
    [self addBarButton];
}

- (void)setMJRefreshFooter{
    if ([self.tableView.mj_footer isRefreshing]) return;
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"上拉获取新数据");
        _pageNum++;
        NSLog(@"%d",_pageNum);
        [self requestMyTicketWithPageNum:[NSString stringWithFormat:@"%d",_pageNum]];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestMyTicketWithPageNum:@"1"];
    
}
//添加列表头视图
- (void)addBarButton{
    NSArray * titleArr = @[@"全部",
                           @"已兑换",
                           @"未兑换"];
    for (int i = 0; i<3; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.center = CGPointMake((i*2+1)*BTN_DISTANTS + (i+0.5)*BTN_WIDTH, _headView.bounds.size.height/2);
        btn.bounds = CGRectMake(0, 0, BTN_WIDTH, BTN_HIGTH);
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn addTarget:self action:@selector(chooseType:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:COLORWITHRGB(74, 74, 74) forState:UIControlStateNormal];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        if (i == 0) {
            _lastBtn = btn;
            [btn setTitleColor:COLORWITHRGB(203, 50, 50) forState:UIControlStateNormal];
            _lineView = [[UIView alloc] init];
            _lineView.bounds = CGRectMake(0, 0, 20, 2);
            _lineView.backgroundColor = COLORWITHRGB(203, 50, 50);
            _lineView.center = CGPointMake(btn.center.x, btn.center.y + 11+3+1);
            [_headView addSubview:_lineView];
        }
        [_headView addSubview:btn];
    }
}
//改变btn的状态
- (void)chooseType:(UIButton *)btn{
    [UIView animateWithDuration:0.3 animations:^{
        _lineView.center = CGPointMake(btn.center.x, btn.center.y+11+3+1);
    }];
    [self changeBtnTypeWithBtnTag:btn.tag];
    [_lastBtn setTitleColor:COLORWITHRGB(74, 74, 74) forState:UIControlStateNormal];
    [btn setTitleColor:COLORWITHRGB(203, 50, 50) forState:UIControlStateNormal];
    _lastBtn = btn;
}
- (void)changeBtnTypeWithBtnTag:(NSInteger)tag{
    switch (tag) {
        case 0:
            [self requestMyTicketWithPageNum:@"1"];
            _touchType = allType;
            break;
        case 1:
            [_myTicketArr removeAllObjects];
            _touchType = hasChangeType;
            break;
        case 2:
            [_myTicketArr removeAllObjects];
            _touchType = notChangeType;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}
#pragma mark--UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _myTicketArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTicketCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyTicketCell"];
    MyTicketModle * modle = _myTicketArr[indexPath.row];
    cell.myTicketModle = modle;
    cell.exchangeBtn.tag = indexPath.row + 100;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTicketModle * modle = _myTicketArr[indexPath.row];
    CGRect rect = [self getLableRectWithText:modle.cardRemark];
    if (rect.size.height < 40) {
        return 200;
    }else{
        return 200+rect.size.height-40;
    }
    return 251;
}
- (IBAction)exchangeBtn:(UIButton *)sender {
    NSLog(@"%ld",(long)sender.tag);
}
/**
 *  动态计算lable高度
 */
- (CGRect)getLableRectWithText:(NSString *)str{
    CGRect rect = [str boundingRectWithSize:CGSizeMake(DWIDTH-121, MAXFLOAT)
                                                     options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}
                                                     context:nil];
    return rect;
}

#pragma mark--网络请求
- (void)requestMyTicketWithPageNum:(NSString *)pageNum{
    [AFNRequest requestMyTicketWithURL:MyTicketURL
                           WithpageNum:pageNum
                             WithToken:[LoginUser shareUser].token
                               WithUID:[LoginUser shareUser].uid
                          WithComplete:^(NSDictionary *dic) {
                              [self.tableView.mj_footer endRefreshing];
                              NSLog(@"%@",dic);
                              NSDictionary * dic1 = dic[@"attribute"];
                              NSArray * arr = dic1[@"list"];
                              if (arr.count>0) {
                                  for (NSDictionary * dic2 in arr) {
                                      MyTicketModle * modle = [[MyTicketModle alloc] initWithDic:dic2];
                                      [_myTicketArr addObject:modle];
                                  }
                              }else{
                                  [self.tableView.mj_footer endRefreshingWithNoMoreData];
                              }
                              [self.tableView reloadData];
                          }];
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
