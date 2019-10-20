//
//  DistributionTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/27.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DistributionTableViewCell : UITableViewCell
/** 配送信息 */
@property (weak, nonatomic) IBOutlet UILabel *ShippinginformationLabel;
/** 配送方式 */
@property (weak, nonatomic) IBOutlet UILabel *distributionLabel;
/** 普通快递 */
@property (weak, nonatomic) IBOutlet UILabel *normaldeliveryLabel;
/** 配送时间 */
@property (weak, nonatomic) IBOutlet UILabel *deliverytimeLabel;
/** 时间*/
@property (weak, nonatomic) IBOutlet UILabel *timelabel;

@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *TheNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *companyLabel;

@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end
