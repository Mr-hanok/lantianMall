//
//  NavigationBarView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/22.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "NavigationBarView.h"

@implementation NavigationBarView
+(id)loadView{
    NavigationBarView * view = [super loadView];
    [view SetIamgeView];
    return view;
}
-(void)SetIamgeView
{
    if (kIsChiHuoApp) {
        self.logoImageView.hidden = YES;
        return;
    }
//    self.logoImageView.image = [UIImage imageNamed:@"logo"];
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:[UserAccountManager shareUserAccountManager].logoImageUrl] placeholderImage:[UIImage imageNamed:@"logo"]];
}
-(CGSize)intrinsicContentSize{
    if (kIsChiHuoApp) {
        return CGSizeMake(32, 32);
    }
    return CGSizeMake(64, 32);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
