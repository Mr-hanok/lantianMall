//
//  MyWalletFootView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MyWalletFootView.h"

@implementation MyWalletFootView

-(void)loadData:(id)model with:(BOOL)isSelected
{
    if (isSelected)
    {
        self.selectedButton.selected = isSelected;
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
