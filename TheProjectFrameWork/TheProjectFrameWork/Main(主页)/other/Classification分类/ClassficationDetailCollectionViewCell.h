//
//  ClassficationDetailCollectionViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/4.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassficationDetailCollectionViewCell : UICollectionViewCell
/** 详情图片 */
@property (weak, nonatomic) IBOutlet UIImageView *detialImageView;
/** 详情内容 */
@property (weak, nonatomic) IBOutlet UILabel *detialContentLabel;

@end
