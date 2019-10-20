//
//  ConstTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/22.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConstTableViewCell : UITableViewCell
/** 商品总价 */
@property (weak, nonatomic) IBOutlet UILabel *CommoditypriceLabel;
/** 运费 */
@property (weak, nonatomic) IBOutlet UILabel *ThefreightLabel;
/** 活动满减金额 */
@property (weak, nonatomic) IBOutlet UILabel *TaxesandfeesLabel;
/** 实付款 */
@property (weak, nonatomic) IBOutlet UILabel *RealpaymentLabel;
/** 会员等级 */
@property (weak, nonatomic) IBOutlet UILabel *MembershipgradeLabel;
/** 会员详情 */
@property (weak, nonatomic) IBOutlet UILabel *MembershipdetailsLabel;
/** 商品总价 */
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
/** 运费 */
@property (weak, nonatomic) IBOutlet UILabel *shipPriceLabel;
/** 税费 */
@property (weak, nonatomic) IBOutlet UILabel *taxesPriceLabel;
/** 实付款 */
@property (weak, nonatomic) IBOutlet UILabel *payPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopVipLabel;
@property (weak, nonatomic) IBOutlet UILabel *mallVipLabel;
@property (weak, nonatomic) IBOutlet UILabel *mallVipPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopVipPriceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mallViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shopViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *manJianViewHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VipHeight;
-(void)LoadDataWith:(id)model andisSeller:(BOOL)seller;
@end
