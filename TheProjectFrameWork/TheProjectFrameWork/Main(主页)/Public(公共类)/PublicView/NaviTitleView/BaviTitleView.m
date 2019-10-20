//
//  BaviTitleView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaviTitleView.h"

@implementation BaviTitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(CGSize)intrinsicContentSize{
    return CGSizeMake(KScreenBoundWidth*0.75, 30);
}
@end
