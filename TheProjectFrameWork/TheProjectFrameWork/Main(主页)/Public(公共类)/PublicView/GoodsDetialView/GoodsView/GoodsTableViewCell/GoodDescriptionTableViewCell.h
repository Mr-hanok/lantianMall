//
//  GoodDescriptionTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/6.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodDescriptionTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *activitylable;
@property (weak, nonatomic) IBOutlet UILabel *activityDesLabel;

-(void)LoadData:(id)model;
@end
