//
//  ShippingDetialsTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/25.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShippingDetialsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ShippingdetailsLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *ShippingCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
-(void)LoadDataWith:(id)model;
@end
