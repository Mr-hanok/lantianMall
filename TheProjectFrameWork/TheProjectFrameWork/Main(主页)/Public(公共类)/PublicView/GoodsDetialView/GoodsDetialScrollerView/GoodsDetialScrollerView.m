//
//  GoodsDetialScrollerView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "GoodsDetialScrollerView.h"

@interface GoodsDetialScrollerView ()<UIWebViewDelegate>

@end
@implementation GoodsDetialScrollerView

-(void)SetWebViewLoadUrl:(GoodsDetialModel*)model
{
    self.detialWebView.delegate = self;
    self.detialWebView.scrollView.showsVerticalScrollIndicator = NO;
    self.detialWebView.scrollView.scrollEnabled = YES;
    self.detialWebView.scrollView.bounces = NO;
    self.detialWebView.scrollView.showsHorizontalScrollIndicator = NO;
    [self.detialWebView setScalesPageToFit:YES];
    NSString * urls = [NSString stringWithFormat:@"%@/goods/get_product_detail?goods_id=%@",KAppRootUrl,model.goodsID];
    NSMutableURLRequest *requeset = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urls]];
    [requeset setHTTPMethod:@"POST"];
    [self.detialWebView loadRequest:requeset];

    
    if (!self.detialWebView)
    {
        self.detialWebView.delegate = self;
    }
    if (model)
    {
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
