//
//  ImageCollectionViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/5.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *evaluationImageView;
@property (nonatomic , weak) NSArray * dataArray;
@property (nonatomic , assign) NSInteger indexRow;
@end
