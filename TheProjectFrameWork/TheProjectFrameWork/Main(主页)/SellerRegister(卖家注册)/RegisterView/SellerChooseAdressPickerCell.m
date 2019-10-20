//
//  SellerChooseAdressPickerCell.m
//  TheProjectFrameWork
//
//  Created by yuntai on 16/8/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "SellerChooseAdressPickerCell.h"

@implementation SellerChooseAdressPickerCell

+ (instancetype)initWithText:(NSString *)text{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"SellerRegisterTFView" owner:self options:nil];
    SellerChooseAdressPickerCell *tfview =[nibView objectAtIndex:0];
    tfview.titleLabel.text = text;
    //    [tfview setFrame:frame];
    return tfview;
}


@end
