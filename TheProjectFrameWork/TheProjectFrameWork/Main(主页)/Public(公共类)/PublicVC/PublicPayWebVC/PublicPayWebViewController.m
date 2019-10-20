//
//  PublicPayWebViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/11/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PublicPayWebViewController.h"
#import "PayOnLineViewController.h"

@interface PublicPayWebViewController ()<NSURLSessionDataDelegate,UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *payWebView;
@property(nonatomic,strong)NSMutableData *dataM;

@property(nonatomic,strong)NSURL *url;

@property(strong,nonatomic) NSString * loadedURL;


@end

@implementation PublicPayWebViewController
{
    BOOL isLoad;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.payWebView.delegate = self;
    self.payWebView.scrollView.bounces = NO;
    self.payWebView.scrollView.showsHorizontalScrollIndicator = NO;
    self.payWebView.scrollView.scrollEnabled = YES;
    [self.payWebView sizeToFit];
    [HUDManager showLoadingHUDView:self.view];
    NSString * urlStringUTF8 = [self.urlstirng stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    self.url= [NSURL URLWithString:urlStringUTF8];
    self.dataM = [NSMutableData new];
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    //发送请求
    [self.payWebView loadRequest:request];
//    [NSURLConnection connectionWithRequest:request delegate:self];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - NSURLSessionDataDelegate代理方法
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * __nullable credential))completionHandler
{
    NSLog(@"challenge = %@",challenge.protectionSpace.serverTrust);
    //判断是否是信任服务器证书
    if (challenge.protectionSpace.authenticationMethod ==NSURLAuthenticationMethodServerTrust)
    {
        //创建一个凭据对象
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        //告诉服务器客户端信任证书
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
        
    }
}
/**
 *  接收到服务器返回的数据时调用
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"接收到的数据%zd",data.length);
    [self.dataM appendData:data];
}
/**
 *  请求完毕
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *html = [[NSString alloc]initWithData:self.dataM encoding:NSUTF8StringEncoding];
    NSLog(@"请求完毕");
//    [self.payWebView loadHTMLString:html baseURL:self.url];
}
#pragma mark --
//
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    if (navigationType != UIWebViewNavigationTypeOther) {
//        self.loadedURL = request.URL.absoluteString;
//    }
//    if (!isLoad && [request.URL.absoluteString isEqualToString:self.loadedURL]) {
//        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//            if (connectionError || ([response respondsToSelector:@selector(statusCode)] && [((NSHTTPURLResponse *)response) statusCode] != 200 && [((NSHTTPURLResponse *)response) statusCode] != 302)) {
//                //Show error message
//            }else {
//                isLoad = YES;
//                [self openurl:request.URL.absoluteString];
//            }
//        }];
//        return NO;
//    }
//    isLoad = NO;
//    return YES;
//}
-(void)openurl:(NSString*)string
{
    PayOnLineViewController * view = [PayOnLineViewController new];
    view.payurls = string;
    [self.navigationController pushViewController:view animated:YES];
}
//
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//    if (navigationType != UIWebViewNavigationTypeOther)
//    {
//    
//        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//            if (connectionError || ([response respondsToSelector:@selector(statusCode)] && [((NSHTTPURLResponse *)response) statusCode] != 200 && [((NSHTTPURLResponse *)response) statusCode] != 302)) {
//                //Show error message
//            }else {
//                [self.payWebView loadRequest:request];
//            }
//        }];
//        return NO;
//    }
//    return YES;
//}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [HUDManager hideHUDView];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [HUDManager hideHUDView];
    [HUDManager showWarningWithText:error.description];
}



@end
