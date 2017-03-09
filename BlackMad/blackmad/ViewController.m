//
//  ViewController.m
//  blackmad
//
//  Created by taobo on 17/3/8.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "ViewController.h"
#import "XRCarouselView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet XRCarouselView *XRCarouselView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navBar configNavBarTitle:@"黑疯" WithLeftView:@"mainLeft" WithRigthView:nil];
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    [self loadXRCarouselView];
}
- (void)loadXRCarouselView{
    NSArray * arr = @[[UIImage imageNamed:@"image"],
                      [UIImage imageNamed:@"image"],
                      [UIImage imageNamed:@"image"],
                      [UIImage imageNamed:@"image"]];
    _XRCarouselView.imageArray = arr;
    _XRCarouselView.time = 2;
    _XRCarouselView.changeMode = ChangeModeDefault;
    _XRCarouselView.imageClickBlock = ^(NSInteger index){
        NSLog(@"点击了第%ld张图",(long)index);
    };
}
- (void)touchLeftBtn{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
