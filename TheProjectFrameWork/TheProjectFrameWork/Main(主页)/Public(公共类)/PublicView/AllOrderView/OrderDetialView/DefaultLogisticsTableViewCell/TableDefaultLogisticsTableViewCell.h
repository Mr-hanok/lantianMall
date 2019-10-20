//
//  TableDefaultLogisticsTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/22.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableDefaultLogisticsTableViewCell : UITableViewCell
/** 物流信息 */
@property (weak, nonatomic) IBOutlet UILabel *logisticNameLabel;
/** 物流时间 */
@property (weak, nonatomic) IBOutlet UILabel *logisetiTimeLabel;

@end
