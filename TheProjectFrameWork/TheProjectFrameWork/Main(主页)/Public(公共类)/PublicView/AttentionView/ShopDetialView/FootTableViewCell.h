//
//  FootTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/17.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FootTableViewCell : UITableViewCell
/** 联系卖家 */
@property (weak, nonatomic) IBOutlet UILabel *connectSellerLabel;
/** 管理类型 */
@property (weak, nonatomic) IBOutlet UILabel *ManagementTypeLabel;
/** 信用等级 */
@property (weak, nonatomic) IBOutlet UILabel *creditRatingLabel;
/** 信用等级View */
@property (weak, nonatomic) IBOutlet UIView *creditRatingView;
/** 店铺动态评分 */
@property (weak, nonatomic) IBOutlet UILabel *shopatomicScoreLabel;
/** 描述 */
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
/** 服务态度 */
@property (weak, nonatomic) IBOutlet UILabel *serviceLabel;
/** 发货速度 */
@property (weak, nonatomic) IBOutlet UILabel *deliverySpeedLabel;
/** 描述View */
@property (weak, nonatomic) IBOutlet UIView *descriptionView;
/** 服务 */
@property (weak, nonatomic) IBOutlet UIView *serviceView;
/** 发货速度 */
@property (weak, nonatomic) IBOutlet UIView *deliverySpeedView;
/** 经营类型 */
@property (weak, nonatomic) IBOutlet UILabel *severTypeLabel;
@property (weak, nonatomic) IBOutlet UIButton *connectSeverButton;
/** 描述分数 */
@property (weak, nonatomic) IBOutlet UILabel *descriptionscoreLabel;
/** 服务态度 */
@property (weak, nonatomic) IBOutlet UILabel *servicescoreLabel;
/** 发货速度 */
@property (weak, nonatomic) IBOutlet UILabel *deliverspeedscoreLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *descriptionLabelwidth;

-(void)LoadModel:(id)Model;

@end
