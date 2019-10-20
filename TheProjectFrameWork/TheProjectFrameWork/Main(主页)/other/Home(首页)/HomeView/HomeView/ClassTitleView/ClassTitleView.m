//
//  ClassTitleView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/24.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ClassTitleView.h"

@implementation ClassTitleView
+(ClassTitleView *)CreatClassTitleViewWithIndex:(NSInteger)section{
    ClassTitleView * view = [[[NSBundle mainBundle] loadNibNamed:@"ClassTitleView" owner:nil options:nil] firstObject];
    view.section = section;
    return view;
}
- (IBAction)detialButtonClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(DetialButtonClickedWith:)]) {
        [self.delegate DetialButtonClickedWith:self.section];
    }
}


@end
