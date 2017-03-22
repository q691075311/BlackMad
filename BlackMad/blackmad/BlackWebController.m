//
//  BlackWebController.m
//  blackmad
//
//  Created by taobo on 17/3/22.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "BlackWebController.h"

@interface BlackWebController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation BlackWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navBar.isAppearLineView = YES;
    [self.navBar configNavBarTitle:@"正在连接..." WithLeftView:@"back" WithRigthView:nil];
    _webView.delegate = self;
    NSURL * URL = [NSURL URLWithString:self.userInfo[@"webviewURL"]];
    NSURLRequest * request = [NSURLRequest requestWithURL:URL];
    [_webView loadRequest:request];
}
#pragma mark--UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *theTitle=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self.navBar configNavBarTitle:theTitle WithLeftView:nil WithRigthView:nil];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return YES;
}
#pragma mark -- 左按钮
- (void)touchLeftBtn{
    if ([_webView canGoBack]) {
        [_webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
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
