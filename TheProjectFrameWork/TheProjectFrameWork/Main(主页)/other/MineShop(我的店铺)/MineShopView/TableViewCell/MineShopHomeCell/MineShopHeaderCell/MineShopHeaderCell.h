//
//  MineShopHeaderCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseTableViewCell.h"
@class MineShopHeaderCell,MineShopIcon,MineShopHeaderButton,ShopModel;
@protocol MineShopHeaderCellDelegate <NSObject>
/**
 *  查看相册
 */
- (void)mineShopHeaderPhotos;
/**
 *  账户管理
 */
- (void)mineShopHeaderAccount;
/**
 *  点击头像
 */
- (void)mineShopHeader:(MineShopHeaderCell *)cell icon:(UIImageView *)icon;
@end
@interface MineShopHeaderCell : BaseTableViewCell
@property (nonatomic , weak) id <MineShopHeaderCellDelegate> delegate;
@property (nonatomic , weak) ShopModel * model;

- (void)settingUserIcon:(UIImage *)icon;
@end


@protocol MineShopIconDelegate <NSObject>

- (void)mineShopIcon:(MineShopIcon *)icon;

@end
@interface MineShopIcon : UIImageView
@property (nonatomic , strong) UIImage * userIcon;
@property (nonatomic , weak) id <MineShopIconDelegate> delegate;

@end


@protocol MineShopHeaderButtonDelegate <NSObject>

- (void)clickMineShopHeader:(MineShopHeaderButton *)sender;

@end
@interface MineShopHeaderButton : UIView
@property (nonatomic , strong) UIFont * font;
@property (nonatomic , copy) NSString * title;
@property (nonatomic , weak) id <MineShopHeaderButtonDelegate> delegate;

@end