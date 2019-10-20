//
//  HomeHeadViewCollectionViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/21.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeHeadViewCollectionViewCell : UICollectionViewCell
/** 视图 */
@property (weak, nonatomic) IBOutlet UIImageView *collectionImageView;
/** 详细内容 */
@property (weak, nonatomic) IBOutlet UILabel *collectionDetialLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelWidth;
@property (nonatomic , copy) NSString * imagePath;
@end
