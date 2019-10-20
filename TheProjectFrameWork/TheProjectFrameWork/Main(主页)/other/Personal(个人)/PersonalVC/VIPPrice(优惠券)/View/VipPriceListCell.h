//
//  VipPriceListCell.h
//  TheProjectFrameWork
//
//  Created by yuntai on 2017/12/23.
//  Copyright © 2017年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VipPriceModel.h"

@interface VipPriceListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *vippriceTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *yangLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *vipPriceDeslabel;
@property (weak, nonatomic) IBOutlet UILabel *vipPriceNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;
@property (weak, nonatomic) IBOutlet UILabel *mandeslabel;
@property (nonatomic, assign) NSInteger type;
- (void)confitCellWithModel:(VipPriceModel *)model;
@end
