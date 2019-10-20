//
//  OrderTableHeadView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/20.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTableHeadView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UIButton *selVipPriceBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shopNameWidth;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
-(void)LoadData:(id)model with:(OrderTypes)type;
@property (nonatomic, copy) void (^selectVipPrictBlock)(NSInteger section);
@property (nonatomic, copy) void (^shopbtnClickBlock)(NSInteger section);
@end
