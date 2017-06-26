//
//  MyCollectionController.m
//  blackmad
//
//  Created by taobo on 17/5/31.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "MyCollectionController.h"
#import "MyCollectionCell.h"
#import "MyTicketModle.h"
#import "TicketInfoController.h"

@interface MyCollectionController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray * collectionArr;
@end

@implementation MyCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.isAppearLineView = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navBar configNavBarTitle:@"我的收藏" WithLeftView:@"back" WithRigthView:nil];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.collectionArr = [NSMutableArray array];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self collectionListRequest];
}

#pragma mark--UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.collectionArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyCollectionCell" forIndexPath:indexPath];
    cell.collectionCancleBtn.tag = indexPath.row + 100;
    cell.ticketModle = self.collectionArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MyTicketModle * ticket = self.collectionArr[indexPath.row];
    
    TicketInfoController * ticketInfo = [[TicketInfoController alloc] init];
    ticketInfo.ticketModleID = ticket.ID;
    [self.navigationController pushViewController:ticketInfo animated:YES];
}

#pragma mark -- network
- (void)collectionListRequest{
    [AFNRequest getCollectionListDataWithComplete:^(NSDictionary *dic) {
        NSDictionary * diction = dic[@"attribute"];
        NSArray * arr = diction[@"list"];
        for (NSDictionary * dictionary in arr) {
            MyTicketModle * ticket = [[MyTicketModle alloc] initWithDic:dictionary];
            [self.collectionArr addObject:ticket];
        }
        [self.tableView reloadData];
    }];
}

#pragma mark--取消收藏Btn
- (IBAction)cancleCollection:(UIButton *)sender {
    NSLog(@"%ld",(long)sender.tag);
    MyTicketModle * ticket = self.collectionArr[sender.tag-100];
    [self cancelCollectionRequestWithproductID:[NSString stringWithFormat:@"%@",ticket.ID] withIndex:sender.tag];
}

- (void)cancelCollectionRequestWithproductID:(NSString *)productID withIndex:(NSInteger)index{
    [AFNRequest cancelCollectionWithCardVolumeId:productID withComplete:^(NSDictionary *dic) {
        [SVProgressHUD showSuccessWithStatus:@"成功取消收藏"];
        [_collectionArr removeObjectAtIndex:index-100];
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
