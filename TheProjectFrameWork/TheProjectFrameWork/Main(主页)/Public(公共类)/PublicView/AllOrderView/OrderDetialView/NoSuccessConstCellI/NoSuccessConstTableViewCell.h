//
//  NoSuccessConstTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/2.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoSuccessConstTableViewCell : UITableViewCell
/** 下单时间 */
@property (weak, nonatomic) IBOutlet UILabel *PlacetheorderoftimeLabel;
/** 发票号 */
@property (weak, nonatomic) IBOutlet UILabel *InvoicenoLabel;
/** 支付时间 */
@property (weak, nonatomic) IBOutlet UILabel *PaymenttimeLabel;
/** 下单时间 */
@property (weak, nonatomic) IBOutlet UILabel *placeorderTimeLabel;

/** 支付时间 */
@property (weak, nonatomic) IBOutlet UILabel *paytimeLabel;

/** 发票号 */
@property (weak, nonatomic) IBOutlet UILabel *invoicenoumberLabel;

@end
