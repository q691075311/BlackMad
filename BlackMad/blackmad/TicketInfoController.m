//
//  TicketInfoController.m
//  blackmad
//
//  Created by taobo on 17/6/15.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "TicketInfoController.h"


@interface TicketInfoController ()
@property (nonatomic,assign) BOOL isCollect;
@property (nonatomic,strong) MyTicketModle * tickInfo;

@end

@implementation TicketInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLORWITHRGB(239, 239, 239);
    self.navBar.isAppearLineView = YES;
    [self.navBar configNavBarTitle:@"卡券详情" WithLeftView:@"back" WithRigthView:nil];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self gettickinfoDataRequest];
    
}
- (void)addSubView{
    CGFloat H;
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, DWIDTH, DHIGTH-64)];
    //创建图片
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, DWIDTH, 200)];
    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,_tickInfo.cardPictureAddress]]];
    [scrollView addSubview:imageView];
    H = imageView.bounds.size.height;
    H += 2;
    //创建标题条
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, H, DWIDTH, 46)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, DWIDTH-90, 46)];
    nameLable.text = _tickInfo.cardName;
    nameLable.textColor = COLORWITHRGB(169, 142, 90);
    nameLable.font = [UIFont systemFontOfSize:14];
    UILabel * pricelable = [[UILabel alloc] initWithFrame:CGRectMake(DWIDTH-75, 0, 65, 24)];
    pricelable.textColor = [Tool appRedColor];
    pricelable.text = [NSString stringWithFormat:@"￥%@.00",_tickInfo.cardVolumePresentPrice];
    pricelable.font = [UIFont systemFontOfSize:17];
    [view addSubview:pricelable];
    [view addSubview:nameLable];
    [scrollView addSubview:view];
    H += view.bounds.size.height+10;
    //创建详情内容
    CGFloat lableH = [Tool getLableHeigthWithText:_tickInfo.cardContent withLableWidth:DWIDTH-10-14 withTextFontOfSize:13];
    UIView * infoView = [[UIView alloc] initWithFrame:CGRectMake(0, H, DWIDTH, lableH+41+31)];
    infoView.backgroundColor = [UIColor whiteColor];
    UILabel * titlelable = [[UILabel alloc] initWithFrame:CGRectMake(9, 10, DWIDTH-100, 21)];
    titlelable.text = @"卡券详情";
    titlelable.textColor = COLORWITHRGB(74, 74, 74);
    titlelable.font = [UIFont systemFontOfSize:15];
    [infoView addSubview:titlelable];
    UILabel * infolable = [[UILabel alloc] initWithFrame:CGRectMake(10, 41, DWIDTH-10-14, lableH)];
    
    
    
    scrollView.contentSize = CGSizeMake(DWIDTH, H);
    [self.view addSubview:scrollView];
}


//获取卡券的详情
- (void)gettickinfoDataRequest{
    NSNumber * carID = _ticketModle.ID;
    NSString * carVoid = [NSString stringWithFormat:@"%@",carID];
    [AFNRequest ticketInfoWithCardVolumeId:carVoid withComplete:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
        NSDictionary * diction = dic[@"attribute"];
        NSDictionary * dictionary = diction[@"item"];
        _isCollect = diction[@"isCollection "];
        _tickInfo = [[MyTicketModle alloc] initWithDic:dictionary];
        [self addSubView];
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
