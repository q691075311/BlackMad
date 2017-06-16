//
//  TicketInfoController.m
//  blackmad
//
//  Created by taobo on 17/6/15.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "TicketInfoController.h"

#define ITEMHEGHT DWIDTH/5

@interface TicketInfoController ()
@property (nonatomic,assign) BOOL isCollect;
@property (nonatomic,strong) MyTicketModle * tickInfo;
@property (nonatomic,strong) UIImageView * collectionView;
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
//添加页面视图
- (void)addSubView{
    CGFloat H;
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, DWIDTH, DHIGTH-64-50)];
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
    UILabel * pricelable = [[UILabel alloc] initWithFrame:CGRectMake(DWIDTH-75, 0, 65, 46)];
    pricelable.textColor = [Tool appRedColor];
    pricelable.text = [NSString stringWithFormat:@"￥%@.00",_tickInfo.cardVolumePresentPrice];
    pricelable.font = [UIFont systemFontOfSize:17];
    [view addSubview:pricelable];
    [view addSubview:nameLable];
    [scrollView addSubview:view];
    H += view.bounds.size.height+10;
    //创建详情内容
    CGFloat lableH = [Tool getLableHeigthWithText:_tickInfo.cardContent withLableWidth:DWIDTH-10-14-40 withTextFontOfSize:15];
    
    UIView * infoView = [[UIView alloc] initWithFrame:CGRectMake(0, H, DWIDTH, lableH+41+31)];
    infoView.backgroundColor = [UIColor whiteColor];
    
    UILabel * titlelable = [[UILabel alloc] initWithFrame:CGRectMake(9, 10, DWIDTH-100, 21)];
    titlelable.text = @"卡券详情";
    titlelable.textColor = COLORWITHRGB(74, 74, 74);
    titlelable.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
    [infoView addSubview:titlelable];
    
    UILabel * infolable = [[UILabel alloc] initWithFrame:CGRectMake(10, 41, DWIDTH-10-14, lableH)];
    infolable.text = _tickInfo.cardContent;
    infolable.font = [UIFont fontWithName:@"PingFangSC-Medium" size:13];
    infolable.numberOfLines = 0;
    infolable.textColor = COLORWITHRGB(74, 74, 74);
    [infoView addSubview:infolable];
    [scrollView addSubview:infoView];
    H += infoView.bounds.size.height;
    
    scrollView.contentSize = CGSizeMake(DWIDTH, H);
    [self.view addSubview:scrollView];
}
//添加下部tabbar
- (void)addTabbarView{
    NSArray * imageArr = @[@"mainnotselecter",
                           @"xinH",
                           @"usernotselecter"];
    NSArray * lableArr = @[@"精选",
                           @"收藏",
                           @"我的"];
    UIView * tabBarBGView = [[UIView alloc] initWithFrame:CGRectMake(0, DHIGTH-50, DWIDTH, 50)];
    tabBarBGView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tabBarBGView];
    
    for (int i = 0; i<3; i++) {
        UIView * itemView = [[UIView alloc] initWithFrame:CGRectMake(i*ITEMHEGHT, 0, ITEMHEGHT, 50)];
        itemView.backgroundColor = [UIColor whiteColor];
        //添加图片
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.center = CGPointMake(itemView.bounds.size.width/2, 17);
        imageView.bounds = CGRectMake(0, 0, 22, 22);
        imageView.image = [UIImage imageNamed:imageArr[i]];
        if (i == 1) {
            _collectionView = imageView;
        }
        //添加lable
        UILabel * lable = [[UILabel alloc] init];
        lable.center = CGPointMake(itemView.bounds.size.width/2, 32+13/2);
        lable.bounds = CGRectMake(0, 0, 21, 13);
        lable.font = [UIFont systemFontOfSize:10];
        lable.textColor = COLORWITHRGB(134, 134, 134);
        lable.text = lableArr[i];
        //添加点击Btn
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.center = CGPointMake(itemView.bounds.size.width/2, itemView.bounds.size.height/2);
        btn.bounds = CGRectMake(0, 0, itemView.bounds.size.width, itemView.bounds.size.height);
        [btn addTarget:self action:@selector(clickOtherBtn:) forControlEvents:UIControlEventTouchUpInside];
        //添加line线
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(itemView.bounds.size.width-1, 5, 1, 40)];
        lineView.backgroundColor = COLORWITHRGB(203, 203, 203);
        if (i == 2) {
            lineView.hidden = YES;
        }
        
        [itemView addSubview:lineView];
        [itemView addSubview:lable];
        [itemView addSubview:imageView];
        [itemView addSubview:btn];
        [tabBarBGView addSubview:itemView];
    }
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(DWIDTH-ITEMHEGHT*2, 0, ITEMHEGHT*2, 50);
    [btn setTitle:@"立即购买" forState:UIControlStateNormal];
    btn.backgroundColor = [Tool appRedColor];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    [btn addTarget:self action:@selector(clickPay) forControlEvents:UIControlEventTouchUpInside];
    [tabBarBGView addSubview:btn];
}
- (void)clickPay{
    
}

- (void)clickOtherBtn:(UIButton *)btn{
    if (btn.tag == 0) {
        //回到首页
        [Tool configTabBarItem];
    }else if (btn.tag == 1) {
        if (_isCollect) {
            [SVProgressHUD showErrorWithStatus:@"已经收藏过了"];
            return;
        }
        //收藏请求
        [self cardCollectionRequest];
    }else if (btn.tag == 2){
        self.tabBarController.selectedIndex = 2;
    }
}

//获取卡券的详情请求
- (void)gettickinfoDataRequest{
    NSNumber * carID = _ticketModle.ID;
    NSString * carVoid = [NSString stringWithFormat:@"%@",carID];
    [AFNRequest ticketInfoWithCardVolumeId:carVoid withComplete:^(NSDictionary *dic) {
        NSLog(@"%@",dic);
        NSDictionary * diction = dic[@"attribute"];
        NSDictionary * dictionary = diction[@"item"];
        if ([(NSNumber *)diction[@"isCollection"] isEqual:@(0)]) {
            _isCollect = NO;
        }else{
            _isCollect = YES;
        }
        _tickInfo = [[MyTicketModle alloc] initWithDic:dictionary];
        [self addSubView];
        [self addTabbarView];
        if (_isCollect) {
            _collectionView.image = [UIImage imageNamed:@"xin"];
        }else{
            _collectionView.image = [UIImage imageNamed:@"xinH"];
        }
    }];
}

- (void)cardCollectionRequest{
    NSNumber * carID = _ticketModle.ID;
    NSString * carVoid = [NSString stringWithFormat:@"%@",carID];
    [AFNRequest ticketCollectionWithCardID:carVoid withComplete:^(NSDictionary *dic) {
        [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
        _isCollect = YES;
        _collectionView.image = [UIImage imageNamed:@"xin"];
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
