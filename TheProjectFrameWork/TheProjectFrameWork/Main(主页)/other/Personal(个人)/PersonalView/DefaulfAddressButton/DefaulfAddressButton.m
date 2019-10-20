//
//  DefaulfAddressButton.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/5.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "DefaulfAddressButton.h"

@implementation DefaulfAddressButton


- (void)setImage:(NSString *)image
{
    [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:[image stringByAppendingString:@"_select"]] forState:UIControlStateSelected];
    
}
@end
