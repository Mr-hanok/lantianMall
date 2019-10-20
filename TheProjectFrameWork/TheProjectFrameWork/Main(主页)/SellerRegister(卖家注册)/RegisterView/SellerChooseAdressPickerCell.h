//
//  SellerChooseAdressPickerCell.h
//  TheProjectFrameWork
//
//  Created by yuntai on 16/8/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellerChooseAdressPickerCell : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
+ (instancetype)initWithText:(NSString *)text;
@end
