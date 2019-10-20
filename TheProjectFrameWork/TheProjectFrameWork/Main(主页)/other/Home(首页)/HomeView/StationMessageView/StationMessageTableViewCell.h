//
//  StationMessageTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/29.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol StationMessageTableViewCellDelegate <NSObject>

-(void)StationMessageTableViewCellButtonSelete:(NSIndexPath*)indexpath;

@end

@interface StationMessageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonWidth;

@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@property (weak, nonatomic) IBOutlet UIImageView *goodsDetialImageView;

@property (weak, nonatomic) IBOutlet UILabel *shopTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *badegValueLabel;

@property(weak,nonatomic) id <StationMessageTableViewCellDelegate> delegate;

@property(strong,nonatomic) NSIndexPath * indexPath;

-(void)editCell:(BOOL)isEdit;

-(void)loadModel:(id) model with:(NSIndexPath*)indexpath show:(BOOL)isSelected;


@end
