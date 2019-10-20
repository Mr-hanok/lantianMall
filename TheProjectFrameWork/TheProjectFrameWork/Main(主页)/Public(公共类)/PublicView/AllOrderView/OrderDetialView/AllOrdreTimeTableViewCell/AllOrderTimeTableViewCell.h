//
//  AllOrderTimeTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/22.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AllOrderTimeTableViewCell : UITableViewCell
/** 下单时间 */
@property (weak, nonatomic) IBOutlet UILabel *PlacetheOrderLabel;
/** 支付时间 */
@property (weak, nonatomic) IBOutlet UILabel *payTimeLabel;
/** 成交时间 */
@property (weak, nonatomic) IBOutlet UILabel *ClinchadealthetimeLabel;
/** 发票号 */
@property (weak, nonatomic) IBOutlet UILabel *InvoiceNoLabel;
/** 下单时间 */
@property (weak, nonatomic) IBOutlet UILabel *placeordertimeLabel;
/** 支付时间 */
@property (weak, nonatomic) IBOutlet UILabel *buyerpaytimelabel;
/** 成交时间 */
@property (weak, nonatomic) IBOutlet UILabel *buyclinchadealtimeLabel;
/** 发票号 */
@property (weak, nonatomic) IBOutlet UILabel *invoicenomberLabel;

@end
