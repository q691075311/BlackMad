//
//  InterestController.m
//  blackmad
//
//  Created by taobo on 17/3/13.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "InterestController.h"
#import "InterestCell.h"
#import "InterestModel.h"

@interface InterestController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (nonatomic,copy) NSArray * imageArr;
//@property (nonatomic,copy) NSArray * titleArr;
@property (nonatomic,strong) NSMutableArray * interestArr;//存储兴趣爱好的模型数组
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
    self.interestArr = [[NSMutableArray alloc] init];
    self.selectArr = [[NSMutableArray alloc] init];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestInterestList];
    
}


- (void)initData{
    //初始化cell选中的数组
    for (int i = 0; i < self.interestArr.count; i++) {
        BOOL isSelect = NO;
        [self.selectArr addObject:@(isSelect)];
    }
    [_tableView reloadData];
}
#pragma mark--UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.interestArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InterestCell * cell = [tableView dequeueReusableCellWithIdentifier:@"InterestCell" forIndexPath:indexPath];
    InterestModel * model = self.interestArr[indexPath.row];
    [cell.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,model.pictureAddress]] placeholderImage:[UIImage imageNamed:@"XRPlaceholder"]];
    cell.InterestLable.text = model.interestName;
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
    NSString * selectObject;//记录选中的兴趣
    for (int i = 0; i < self.selectArr.count; i++) {
        NSNumber * number = self.selectArr[i];
        if ([number isEqual:@(YES)]) {
            InterestModel * model = self.interestArr[i];
            NSString * str = [NSString stringWithFormat:@"%@",model.interestID];
            NSLog(@"%@",str);
            if (selectObject == nil) {
                selectObject = str;
            }else{
                selectObject = [NSString stringWithFormat:@"%@,%@",selectObject,str];
            }
        }
    }
    if (selectObject == nil) {
        [SVProgressHUD showErrorWithStatus:@"请选择兴趣"];
        return;
    }
    NSLog(@"%@",selectObject);
    [self saveInterestRequestWithSelectObject:selectObject];
    
}
//保存兴趣的请求
- (void)saveInterestRequestWithSelectObject:(NSString *)str{
    [AFNRequest requestSaveInterestWithUrl:saveinterestURL
                                 WithToken:USERTOKEN
                                   WithUid:USERID
                                  WithBody:str
                              WithComplete:^(NSDictionary *dic) {
                                  NSLog(@"%@",dic);
                                  [LoginUser shareUser].isSelectInterest = @(1);
                                  [self pushToController:@"ViewController" WithStoyBordID:@"Main" WithForm:self WithInfo:@{}];
                              }];
}

//请求兴趣列表
- (void)requestInterestList{
    [AFNRequest requestInterestWithUrl:interest
                             WithToken:[LoginUser shareUser].token
                               WithUid:[LoginUser shareUser].uid
                          WithComplete:^(NSDictionary *dic) {
                              [_interestArr removeAllObjects];
                              NSLog(@"%@",dic);
                              NSDictionary * dic1 = dic[@"attribute"];
                              NSArray * arr = dic1[@"list"];
                              for (NSDictionary * dic2 in arr) {
                                  InterestModel * interestM = [[InterestModel alloc] initWithDic:dic2];
                                  [_interestArr addObject:interestM];
                              }
                              [self initData];
                              
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
