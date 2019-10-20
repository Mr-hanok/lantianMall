//
//  PayMentmethodTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayMentmethodTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bankcardlogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentmethodLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *goodsDetialCollectionView;

@end
