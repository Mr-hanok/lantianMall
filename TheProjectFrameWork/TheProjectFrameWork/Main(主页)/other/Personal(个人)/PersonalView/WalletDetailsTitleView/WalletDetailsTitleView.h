//
//  WalletDetailsTitleView.h
//  TheProjectFrameWork
//
//  Created by ZengPengYuan on 16/7/9.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WalletDetailsTitle,OrderTypeItem,WalletDetailsUnfoldView,DropdownListView;

/**
 *  titleview
 */
@interface WalletDetailsTitleView : UIButton

@end

@protocol WalletDetailsUnfoldViewDelegate <NSObject>
@optional
/**
 *  返回点击的视图的索引值
 */
- (void)walletdetaileTitleFrom:(NSInteger)from to:(NSInteger)to;
- (void)orderTypeView:(WalletDetailsUnfoldView *)view type:(NSInteger)type title:(NSString *)title;
@end

@interface DropdownListView : UIView
@property (nonatomic , weak) UIView * displayView;

- (void)unfold;
- (void)fold;

@end
/**
 *  展开内容(订单类型)
 */
@interface WalletDetailsUnfoldView : DropdownListView

@property (nonatomic , weak) id <WalletDetailsUnfoldViewDelegate> delegate;

- (instancetype)initWithTitles:(NSArray *)titles;
- (instancetype)initWithItems:(NSArray *)items defaultItemIndex:(NSInteger)index;

@end




@protocol WalletDetailsTitleDelegate <NSObject>
@optional
/**
 *  点击返回
 */
- (void)walletTitle:(WalletDetailsTitle *)title;

@end
@interface WalletDetailsTitle : UIView
@property (nonatomic , copy) NSString * title;
@property (nonatomic , assign) BOOL check;
@property (nonatomic , weak) id <WalletDetailsTitleDelegate> delegate;
@end


@protocol OrderTypeItemDelegate <NSObject>

@optional
- (void)orderTypeClickWithItem:(OrderTypeItem *)item;

@end
@interface OrderTypeItem : UILabel
@property (nonatomic , assign) BOOL selected;
@property (nonatomic , weak) id <OrderTypeItemDelegate> delegate;

@end

