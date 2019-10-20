//
//  ClassGoodsCollectionViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/30.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClassGoodsCollectionViewCellDelegate <NSObject>

-(void)ClassGoodsPayAttentButtonClickedbutton:(UIButton*)button index:(NSIndexPath*)indexPath;

@end

@interface ClassGoodsCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsStoreNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *payAttentButton;

@property(strong,nonatomic) NSIndexPath * index;
@property(weak,nonatomic) id <ClassGoodsCollectionViewCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *goodPreferentialpriceLabel;
@property (weak, nonatomic) IBOutlet UIView *yellowcommentView;

-(void)loadData:(id)model withIndex:(NSIndexPath*)indexPath;

@end
