//
//  MineShopAccountCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/2.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineShopBaseCell.h"
@class AccountItem,MineShopAccountCell,AccountView;
@protocol MineShopAccountCellDelegate <NSObject>

- (void)mineShopAccount:(MineShopAccountCell *)cell type:(NSInteger)type;
- (void)mineShopMineAccount:(MineShopAccountCell *)cell;
@end
/**
 *  我的店铺－我的账户
 */
@interface MineShopAccountCell : MineShopBaseCell
@property (nonatomic , weak) id <MineShopAccountCellDelegate> delegate;
@property (nonatomic , assign) CGFloat storeCredit;
@property (nonatomic , assign) CGFloat balance;
@property (nonatomic , assign) BOOL isReview;
@end

@protocol AccountViewDelegate <NSObject>

- (void)accountView:(AccountView *)view type:(NSInteger)type;

@end
@interface AccountView : UIView
@property (nonatomic , weak) id <AccountViewDelegate> delegate;
@property (nonatomic , assign) CGFloat storeCredit;
@property (nonatomic , assign) CGFloat balance;
@property (nonatomic , assign) BOOL isReview;
@end


@protocol AccountItemDelegate <NSObject>

- (void)accountItemClickWithItem:(AccountItem *)item;

@end
@interface AccountItem : UIView
@property (nonatomic , weak) id <AccountItemDelegate> delegate;

@property (nonatomic , copy) NSString * title;
@property (nonatomic , assign) CGFloat value;

@end