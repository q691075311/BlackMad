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
#define VIEWWIDTH ([UIScreen mainScreen].bounds.size.width-4)/5
@interface ViewController ()<MainBtnViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet XRCarouselView *XRCarouselView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet MainheadView *headView;
@property (nonatomic,strong) MainBtnView * btnView;
@property (nonatomic,strong) UIView * lineView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = YES;
    [self.navBar configNavBarTitle:@"疯趣" WithLeftView:@"mainLeft" WithRigthView:nil];
    [self loadXRCarouselView];
    [self setFristLineView];
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    _btnView = [[MainBtnView alloc]initWithFrame:CGRectMake(0, 190, DWIDTH, 88)];
    _btnView.delegate = self;
    [_headView addSubview:_btnView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = _headView;
    self.navigationController.navigationBar.hidden = YES;
    
}
- (void)setFristLineView{
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 278, VIEWWIDTH, 1)];
    _lineView.backgroundColor = [UIColor whiteColor];
    [_headView addSubview:_lineView];
}
#pragma mark--MainBtnViewDelegate
- (void)touchBtnWithBtn:(UIButton *)btn{
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
    NSArray * arr = @[[UIImage imageNamed:@"userback"],
                      [UIImage imageNamed:@"userback"],
                      [UIImage imageNamed:@"userback"],
                      [UIImage imageNamed:@"userback"]];
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
- (void)touchLeftBtn{
    //进入个人中心
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UserInfoController * vc = [sb instantiateViewControllerWithIdentifier:@"UserInfoController"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
