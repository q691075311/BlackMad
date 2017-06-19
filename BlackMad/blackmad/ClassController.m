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
#import "TicketDataModels.h"
#import "TicketInfoController.h"

typedef enum : NSUInteger {
    class_ACT,
    class_TICKET,
} classType;

@interface ClassController ()<UITableViewDelegate,UITableViewDataSource,ClassDelegate,ClassTopViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray * actArr;
@property (nonatomic,strong) NSMutableArray * ticketArr;
@property (nonatomic,assign) classType type;
@end

@implementation ClassController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navBar.isAppearLineView = YES;
    self.actArr = [NSMutableArray array];
    self.ticketArr = [NSMutableArray array];
    self.type = class_ACT;
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
    headView.delegate = self;
    [self.view addSubview:headView];
}
#pragma mark --UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_type == class_ACT) {
        return _actArr.count;
    }else if (_type == class_TICKET){
        return _ticketArr.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ClassCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ClassCell" forIndexPath:indexPath];
    cell.delegate = self;
    if (_type == class_ACT) {
        cell.actList = _actArr[indexPath.row];
    }else if (_type == class_TICKET){
        cell.ticketList = _ticketArr[indexPath.row];
    }
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
- (void)getTicketListRequest{
    [self.ticketArr removeAllObjects];
    [AFNRequest classTicketListWithComplete:^(id responseObject) {
        TicketTicketList2 * ticket = (TicketTicketList2 *)[TicketTicketList2 yy_modelWithJSON:responseObject];
        for (NSDictionary * dic in ticket.attribute.list) {
            TicketList * ticketList = [TicketList modelObjectWithDictionary:dic];
            [_ticketArr addObject:ticketList];
        }
        [self.tableView reloadData];
    }];
}

#pragma mark -- ClassDelegate
- (void)cilckMoreBtn:(UIButton *)btn{
    NSInteger proID;
    NSInteger tag = btn.tag;
    NSString * flg;
    NSArray * dataArr = [NSArray array];
    //获取productTypeID
    if (_type == class_ACT) {
        dataArr = _actArr;
        ActList *list = _actArr[tag];
        proID = list.listIdentifier;
        flg = @"";
    }else{
        flg = @"tick";
        dataArr = _ticketArr;
        TicketList * ticketList = _ticketArr[tag];
        proID = ticketList.listIdentifier;
    }
    [self pushToController:@"ClassDetailController"
            WithStoyBordID:@"class"
                  WithForm:self
                  WithInfo:@{@"productID":@(proID),@"titleArr":dataArr,@"flg":flg}];
}
//活动的点击事件
- (void)cilckCellBtnWithActProductList:(ActProductList *)actPro{
    [self pushToController:@"BlackWebController"
            WithStoyBordID:@"Main"
                  WithForm:self
                  WithInfo:@{@"webviewURL":actPro.promotionalWapLink}];
}
//卡券的点击事件
- (void)cilckCellBtnWithTicketList:(TicketCardVolumeList *)tickCard{
    if ([LoginUser shareUser].isLogin) {
        //获取productTypeID
        TicketInfoController * ticketInfo = [[TicketInfoController alloc] init];
        ticketInfo.ticketModleID = [[NSNumber alloc] initWithDouble:tickCard.cardVolumeListIdentifier];
        [self.navigationController pushViewController:ticketInfo animated:YES];
    }else{
        [Tool presentLoginViewWithStr:@"islogin" WithViewController:self];
    }
}
#pragma mark -- ClassTopViewDelegate
- (void)chooseTopbarClass:(NSInteger)classType{
    //选择的类型   0活动    1卡券
    if (classType == 0) {
        _type = class_ACT;
        [self getClassActRequest];
    }else if (classType == 1){
        _type = class_TICKET;
        [self getTicketListRequest];
    }
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
