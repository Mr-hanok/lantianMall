//
//  DistributionFootView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/25.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DistributionFootView;

@protocol DistributionFootViewDelegate <NSObject>

-(void)DistributionFootViewDidSelectedWithSection:(NSInteger)section andDistrbutionView:(DistributionFootView*)view;
-(void)TextFieldEndinputSelectedWithSection:(NSInteger)section andTextField:(UITextField*)textfield;
-(void)DistributionFootViewDidSelectedWithSection:(NSInteger)section andDistrbutionView:(DistributionFootView*)view selbtn:(UIButton *)btn;

@end


@interface DistributionFootView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sellerleaveLabelWidth;
@property(assign,nonatomic) NSInteger  section;
@property (weak, nonatomic) IBOutlet UILabel *sendWaysLabel;
/** 卖家留言 */
@property (weak, nonatomic) IBOutlet UILabel *sellerLeaveLabel;

@property (weak, nonatomic) IBOutlet UILabel *deliveryTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *deliveryTypeLabel;

@property (weak, nonatomic) IBOutlet UIButton *selectedButton;

@property (weak, nonatomic) IBOutlet UITextField *messagecontentTextField;

@property (weak, nonatomic) IBOutlet UIImageView *timeImageView;
@property (weak, nonatomic) IBOutlet UIView *vippriceView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vipPriceViewHeigth;

@property (weak, nonatomic) IBOutlet UIView *topIView;
@property(weak,nonatomic) id<DistributionFootViewDelegate>delegate;
-(void)LoadDataWith:(id)model andSection:(NSInteger)section;
@end
