//
//  ClassGoodsVerticalCollectionViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/30.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClassGoodsVerticalCollectionViewCellDelegate <NSObject>

-(void)PayAttentButtonClickedbutton:(UIButton*)button index:(NSIndexPath*)indexPath;

@end

@interface ClassGoodsVerticalCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodstitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsDetialLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *payAttentButton;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property(strong,nonatomic) NSIndexPath * index;

@property(weak,nonatomic) id <ClassGoodsVerticalCollectionViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *goodStarView;
/**
 *  <#Description#>
 *
 *  @param model     <#model description#>
 *  @param indexPath <#indexPath description#>
 */
-(void)loadData:(id)model withIndex:(NSIndexPath*)indexPath;

@end
