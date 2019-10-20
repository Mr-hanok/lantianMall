//
//  MineShopBaseCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseSpaceTableViewCell.h"
@class MineShopManagerItem;
@interface MineShopBaseCell : BaseSpaceTableViewCell
@property (nonatomic , weak) UIView * line;
@property (nonatomic , copy) NSString * title;

@end

@protocol MineShopManagerItemDelegate <NSObject>

- (void)mineShopManagerItem:(MineShopManagerItem *)item;

@end
@interface MineShopManagerItem : UIView
- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image;
@property (nonatomic , weak) id <MineShopManagerItemDelegate> delegate;

@property (nonatomic , assign) NSInteger type;
@end