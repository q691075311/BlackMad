//
//  LaunchController.m
//  blackmad
//
//  Created by taobo on 17/3/10.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "LaunchController.h"
#import "LoginController.h"
#import "ViewController.h"


@interface LaunchController ()
@property (nonatomic,copy) NSArray * launchImageArr;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation LaunchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _launchImageArr = @[@"launch1",
                        @"launch2",
                        @"launch3"];
    [self loadScrollView];
}
- (void)loadScrollView{
    _scrollView.contentSize = CGSizeMake(DWIDTH*3, DHIGTH);
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    [self loadLaunchImage];
}
- (void)loadLaunchImage{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(launchBtn)];
    for (int i = 0; i < _launchImageArr.count; i++) {
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(DWIDTH*i, 0, DWIDTH, DHIGTH);
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_launchImageArr[i]]];
        [self.scrollView addSubview:imageView];
        if (i == _launchImageArr.count - 1) {
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:tap];
        }
    }
}

- (void)launchBtn{
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.alpha = 0;
    } completion:^(BOOL finished) {
//        UITabBarController *tb=[[UITabBarController alloc]init];
//        //创建tabbar的视图
//        UIViewController *c1=[[UIViewController alloc]init];
//        c1.view.backgroundColor = [UIColor redColor];
//        c1.tabBarItem.title=@"分类";
//        c1.tabBarItem.image=[UIImage imageNamed:@"all.png"];
//        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//        ViewController * vc = [sb instantiateViewControllerWithIdentifier:@"ViewController"];
//        vc.isAD = @"FormAD";
//        vc.tabBarItem.title = @"精选";
//        vc.tabBarItem.image = [UIImage imageNamed:@"guodate"];
//        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
//        UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
//        [tb addChildViewController:nav];
//        [tb addChildViewController:c1];
//        window.rootViewController = tb;
        [Tool configTabBarItem];
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
