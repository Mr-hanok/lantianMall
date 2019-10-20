//
//  AppAsiaWebViewController.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/9/10.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AppAsiaWebViewController.h"
@interface AppAsiaWebViewController ()<UIWebViewDelegate>
@property (nonatomic , weak) UIWebView * webView;

@end
@implementation AppAsiaWebViewController
{
    NSURLRequest *_request;
    NSData * _parameData;
}

- (void)setUrl:(NSString *)url
{
    _url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
- (void)setParame:(NSDictionary *)parame
{
    _parame = parame;
//    _parameData = [NSData alloc] initw;
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{

    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"开始了");
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{

    NSLog(@"完成了");

}



- (UIWebView *)webView
{
    if(!_webView)
    {
        UIWebView * web = [[UIWebView alloc] initWithFrame:self.view.bounds];
        web.delegate = self;
        [self.view addSubview:web];
        _webView = web;
    }
    return _webView;
}
@end
