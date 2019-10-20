//
//  EvalutaionTypeContentAndImageTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/5.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EvalutaionTypeContentTableViewCellDelegate.h"

@interface EvalutaionTypeContentAndImageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *levelView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *starView;
@property (weak, nonatomic) IBOutlet UILabel *evalutaionLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *ImageCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *thumbUpButton;
@property (weak, nonatomic) IBOutlet UIButton *evalutaionButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLabelWidth;

@property(strong,nonatomic) NSIndexPath * indexPath;

@property(weak,nonatomic) id <EvalutaionTypeContentTableViewCellDelegate> delegate;

-(void)LoadData:(id)model WithIndexPath:(NSIndexPath*)indexPath With:(NSArray*)array;

@end
