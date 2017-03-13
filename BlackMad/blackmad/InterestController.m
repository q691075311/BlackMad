//
//  InterestController.m
//  blackmad
//
//  Created by taobo on 17/3/13.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "InterestController.h"
#import "InterestCell.h"


@interface InterestController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,copy) NSArray * imageArr;
@property (nonatomic,copy) NSArray * titleArr;
@property (nonatomic,strong) NSMutableArray * selectArr;//cell是否选中
@end

@implementation InterestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.isAppearLineView = YES;
    [self.navBar configNavBarTitle:@"兴趣调查" WithLeftView:nil WithRigthView:@"queren"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self initData];
}
/**
 *  初始化数组
 */
- (void)initData{
    //初始化cell选中的数组
    self.selectArr = [[NSMutableArray alloc] init];
    self.imageArr = @[[UIImage imageNamed:@"sheying"],
                      [UIImage imageNamed:@"lvyou"],
                      [UIImage imageNamed:@"yuedu"],
                      [UIImage imageNamed:@"meishi"],
                      [UIImage imageNamed:@"music"],
                      [UIImage imageNamed:@"yifu"],
                      [UIImage imageNamed:@"game"],
                      [UIImage imageNamed:@"movie"]];
    self.titleArr = @[@"摄影",
                      @"旅行",
                      @"阅读",
                      @"美食",
                      @"音乐",
                      @"服饰",
                      @"游戏",
                      @"影视"];
    for (int i = 0; i < self.titleArr.count; i++) {
        BOOL isSelect = NO;
        [self.selectArr addObject:@(isSelect)];
    }
}
#pragma mark--UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InterestCell * cell = [tableView dequeueReusableCellWithIdentifier:@"InterestCell" forIndexPath:indexPath];
    cell.image.image = self.imageArr[indexPath.row];
    cell.InterestLable.text = self.titleArr[indexPath.row];
    if ([self.selectArr[indexPath.row] isEqualToNumber:@(NO)]) {
        cell.flag.image = [UIImage imageNamed:@"hdui"];
    }else{
        cell.flag.image = [UIImage imageNamed:@"dui"];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 63;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    InterestCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([self.selectArr[indexPath.row] isEqual:@(NO)]) {
        [self.selectArr replaceObjectAtIndex:indexPath.row withObject:@(YES)];
        cell.flag.image = [UIImage imageNamed:@"dui"];
    }else{
        [self.selectArr replaceObjectAtIndex:indexPath.row withObject:@(NO)];
        cell.flag.image = [UIImage imageNamed:@"hdui"];
    }
    [tableView rectForRowAtIndexPath:indexPath];
    
}
- (void)touchRigthBtn{
    NSLog(@"点击确认");
    NSLog(@"%@",self.selectArr);
    for (int i = 0; i < self.selectArr.count; i++) {
        NSNumber * number = self.selectArr[i];
        if ([number isEqual:@(YES)]) {
            NSString * str = self.titleArr[i];
            NSLog(@"%@",str);
        }
    }
    [self pushToController:@"ViewController" WithStoyBordID:@"Main" WithForm:self WithInfo:@{}];
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
