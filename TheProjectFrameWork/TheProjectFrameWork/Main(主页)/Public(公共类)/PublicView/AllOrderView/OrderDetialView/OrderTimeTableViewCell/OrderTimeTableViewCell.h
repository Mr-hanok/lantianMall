//
//  OrderTimeTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/22.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTimeTableViewCell : UITableViewCell
/** 下单时间 */
@property (weak, nonatomic) IBOutlet UILabel *PlacetheorderoftimeLabel;
/** 详情时间 */
@property (weak, nonatomic) IBOutlet UILabel *timeDetialLabel;

@end
