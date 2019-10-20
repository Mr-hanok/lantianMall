//
//  BaseView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

+(id)loadView{
    id view  = [[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:nil options:nil]firstObject];
    return view;
}
-(void)updataNewData:(UIScrollView*)scroller
{
    scroller.mj_header = self.header;
    scroller.mj_footer = self.footer;
    __weak typeof(self) weakSelf = self;
    [[LaguageControl shareControl] languageChangeComplete:^{
        [weakSelf.footer reloadFooterTitle];
    }];
}

-(void)beginRefresh
{
    //    [self.header beginRefreshing];
}
-(void)updateHeadView{
        [self endRefresh];
}
-(void)updateFootView
{
        [self endRefresh];
}
-(void)endRefresh
{
    [self.header endRefreshing];
    [self.footer endRefreshing];
}



- (AppAsiaRefreshHeader *)header
{
    if(!_header)
    {
        __weak typeof(self) weakSelf = self;
        _header = [AppAsiaRefreshHeader AppAsiaRefreshHeaderHandleBlock:^{
            [weakSelf updateHeadView];
        }];
    }
    return _header;
}
- (AppAsiaRefreshFooter *)footer
{
    if(!_footer)
    {
        __weak typeof(self) weakSelf = self;
        _footer = [AppAsiaRefreshFooter footerWithRefreshingBlock:^{
            [weakSelf updateFootView];
        }];
    }
    return _footer;
}
@end
