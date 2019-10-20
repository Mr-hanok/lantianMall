//
//  OrderMoreView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/22.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "OrderMoreView.h"
#import "NirKxMenu.h"
@implementation OrderMoreView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
   
        [KxMenu setTitleFont:[UIFont systemFontOfSize:kAppAsiaFontSize(12)]];
    }
    return self;
}
- (instancetype)initWithPoint:(CGPoint)point
{
    self = [super init];
    if(self)
    {
        Color tColor = {
            .R = 0,
            .B = 0,
            .G = 0
        };
        Color bag = {
            .R = 1,
            .B = 1,
            .G = 1
        };
        OptionalConfiguration option = {
            .arrowSize = 9,
            .marginXSpacing =  3,
            .marginYSpacing =  9,
            .intervalSpacing =  15,
            .menuCornerRadius =  6.5,
            .maskToBackground =  true,
            .shadowOfMenu =  false,
            .hasSeperatorLine =  true,
            .seperatorLineHasInsets =  false,
            .textColor =  tColor,
            .menuBackgroundColor = bag
        };
        [KxMenu setTitleFont:[UIFont systemFontOfSize:12]];
        [KxMenu showMenuInView:KeyWindow fromRect:CGRectMake(point.x, point.y, 100, 70) menuItems:@[[KxMenuItem menuItem:LaguageControl(@"联系卖家") image:nil target:self action:@selector(contact)],[KxMenuItem menuItem:@"投诉" image:nil target:self action:@selector(complaint)]] withOptions:option];
    }
    return self;
}
- (void)contact
{
}
- (void)complaint
{

}
@end
