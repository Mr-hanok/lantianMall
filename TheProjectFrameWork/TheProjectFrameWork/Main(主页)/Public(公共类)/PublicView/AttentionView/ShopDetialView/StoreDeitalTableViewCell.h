//
//  StoreDeitalTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/17.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreDeitalTableViewCell : UITableViewCell
/** 名称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 详情 */
@property (weak, nonatomic) IBOutlet UILabel *detialLabel;

@end
