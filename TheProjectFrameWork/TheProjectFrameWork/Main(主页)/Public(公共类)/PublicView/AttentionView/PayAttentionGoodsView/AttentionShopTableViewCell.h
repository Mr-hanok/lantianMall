//
//  AttentionShopTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/13.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttentionDelegate.h"
@class AttentGoodsModel;
@class NewAttentionShopTableViewCell;
@interface AttentionShopTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *shopIogoImageView;

@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;

@property (weak, nonatomic) IBOutlet UIView *shopLevelView;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (weak, nonatomic) IBOutlet UIButton *delegateButton;

@property(strong,nonatomic) NSIndexPath * indexPath;

@property(weak,nonatomic) id <AttentionDelegate> deleagate;

-(void)loadDateWith:(id)model andindex:(NSIndexPath*)indexPath;

@end

@protocol NewAttentionShopTableViewCellDelegate <NSObject>

@optional
- (void)attentionShopTableViewCellShare:(NewAttentionShopTableViewCell *)cell;
- (void)attentionShopTableViewCellDelete:(NewAttentionShopTableViewCell *)cell;

@end
@interface NewAttentionShopTableViewCell : UITableViewCell
@property (nonatomic , weak) AttentGoodsModel * model;
@property (nonatomic , assign) NSInteger indexRow;
@property (nonatomic , weak) id <NewAttentionShopTableViewCellDelegate> delegate;

@end
