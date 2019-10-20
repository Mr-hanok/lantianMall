//
//  PopShopTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/6.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PopShopTableViewCell;
@protocol PopShopTableViewCellDelegate <NSObject>

-(void)didSelectedwith:(NSIndexPath*)indexpath PopShopTableViewCell:(PopShopTableViewCell*)cell;

@end
@interface PopShopTableViewCell : UITableViewCell

@property(weak,nonatomic) id<PopShopTableViewCellDelegate>delegate;

@property(assign,nonatomic) NSInteger section;

@property (weak, nonatomic) IBOutlet UICollectionView *popShoptableViewCell;
/** 数组 */
@property(strong,nonatomic) NSMutableArray * dataArray;
/** 加载collectionView */
-(void)loadCollectionViewWith:(NSArray*)array WithSection:(NSInteger)section type:(NSString *)type;


@end
