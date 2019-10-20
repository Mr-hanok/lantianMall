//
//  HomeTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/4.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeTableViewCellDelegate <NSObject>

-(void)HomeTableViewCellDidSelected:(NSIndexPath*)indexpath withmodel:(id)model;


@end

@interface HomeTableViewCell : UITableViewCell
/**  首页ImageView */
@property (weak, nonatomic) IBOutlet UICollectionView *detialCollectionView;
/** 分区 */
@property(assign,nonatomic) NSInteger  section;

@property(weak,nonatomic) id<HomeTableViewCellDelegate> delegate;

-(void)loadCollectionViewWith:(NSArray*)array withSection:(NSInteger)section;
@end
