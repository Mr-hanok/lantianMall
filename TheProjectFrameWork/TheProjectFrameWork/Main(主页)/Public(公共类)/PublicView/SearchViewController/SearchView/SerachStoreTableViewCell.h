//
//  SerachStoreTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/5.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SerachStoreTableViewCell;
@protocol SerachStoreTableViewCellDelegate <NSObject>

@optional
-(void)SerachStoreTableViewCellGoodsDidSelected:(NSIndexPath*)index;
-(void)SerachStoreTableViewCellComeToStore:(NSInteger)section;
- (void)serachStoreTableVIewCell:(SerachStoreTableViewCell *)cell goods_id:(NSString *)goods_id;
@end

@interface SerachStoreTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *stroeImageView;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *FocusonNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *comeInButton;
@property (weak, nonatomic) IBOutlet UICollectionView *goodsCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewWidth;
@property(weak,nonatomic) id<SerachStoreTableViewCellDelegate> delegate;
@property(strong,nonatomic) NSIndexPath * indexPath;
-(void)loadData:(id)model WithArray:(NSArray*)array andIndex:(NSIndexPath*)index;
@end



