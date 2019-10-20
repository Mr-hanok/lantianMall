//
//  HomeClassCollectionViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/30.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeClassCollectionViewCell : UICollectionViewCell
/** 详情图片 */
@property (weak, nonatomic) IBOutlet UIImageView *goodImageView;
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
