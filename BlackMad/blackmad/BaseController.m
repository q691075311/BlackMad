//
//  BaseController.m
//  blackmad
//
//  Created by taobo on 17/3/8.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "BaseController.h"

@interface BaseController ()<NavBarDelegate>

@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _navBar = [[NavBar alloc]initWithFrame:CGRectMake(0, 0, DWIDTH, 75)];
    _navBar.delegate = self;
    _navBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_navBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark---NavBarDelegate
- (void)touchRigthBtn{
    
}
- (void)touchLeftBtn{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark--跳转页面
- (BaseController *)pushToController:(NSString *)controllerID
                      WithStoyBordID:(NSString *)stoyBordID
                            WithForm:(BaseController *)formController
                            WithInfo:(NSDictionary *)info{
    UIStoryboard * sb = [UIStoryboard storyboardWithName:stoyBordID bundle:[NSBundle mainBundle]];
    BaseController * vc = [sb instantiateViewControllerWithIdentifier:controllerID];
    vc.userInfo = info;
    vc.hidesBottomBarWhenPushed = YES;
    [formController.navigationController pushViewController:vc animated:YES];
    return vc;
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
