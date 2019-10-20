//
//  ShoppingNotView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/9/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ShoppingNotView.h"

@implementation ShoppingNotView

-(void)LoadNetWorkError:(BOOL)isShow
{
    if (!isShow)
    {
        self.placeImageView.image = [UIImage imageNamed:@"3-0-3购物车-0"];
        self.titleLabel.text =LaguageControl(@"购物车是空的,什么都没有哦");
        self.contentLabel.text = @"";
    }
    else
    {
        self.placeImageView.image = [UIImage imageNamed:@"无网络"];
        self.titleLabel.text =LaguageControl(@"网络请求失败");
        self.contentLabel.text = LaguageControl(@"请检查网络");
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
