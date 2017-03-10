//
//  LaunchController.m
//  blackmad
//
//  Created by taobo on 17/3/10.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "LaunchController.h"
#import "ViewController.h"
@interface LaunchController ()
@property (weak, nonatomic) IBOutlet UIButton *mainBtn;

@end

@implementation LaunchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)launchBtn:(UIButton *)sender {
    [UIView animateWithDuration:0.3 animations:^{
        _mainBtn.alpha = 0;
    } completion:^(BOOL finished) {
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        ViewController * vc = [sb instantiateViewControllerWithIdentifier:@"ViewController"];
        UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc];
        UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
        window.rootViewController = nav;
    }];
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
