//
//  ShopGoodsClassViewController.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/9/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"
#import "BaseSpaceTableViewCell.h"
@class ShopGoodsClassAllCell;
@class ShopGoodsClassItem;
@class ShopClassItemModel;
typedef void(^netWorkComplete) (id error);
typedef void(^clickClassBlock) (id class_id , NSString * className);

@interface ShopGoodsClassViewController : LeftViewController
@property (nonatomic , copy) NSString * store_id;

@property (nonatomic , copy) clickClassBlock clickBack;

- (instancetype)initWithClickClass:(clickClassBlock)block;
@end



@interface ShopGoodsClassAllCell : BaseSpaceTableViewCell

@property (nonatomic , copy) NSString * cellTitle;

@end
@protocol ShopGoodsClassCellDelegate <NSObject>
@optional

- (void)shopGoodsClassClickEvent:(id)info;

@end
@interface ShopGoodsClassCell : BaseSpaceTableViewCell
@property (nonatomic , weak) id<ShopGoodsClassCellDelegate> delegate;

@property (nonatomic , strong) NSArray <ShopClassItemModel *>* classArray;
@end



@protocol ShopGoodsClassItemDelegate <NSObject>

@optional
- (void)shopGoodsClassClick:(ShopGoodsClassItem *)item;
@end
@interface ShopGoodsClassItem : UIButton
@property (nonatomic , weak) id <ShopGoodsClassItemDelegate> delegate;

@property (nonatomic , strong) ShopClassItemModel * model;
@end


@interface ShopGoodsClassViewModel : NSObject
@property (nonatomic , strong) NSArray<ShopClassItemModel *> * items;
- (void)getShopGoodsClassInfoWithStoreId:(NSString *)storeid completed:(netWorkComplete)complete;
@end

@interface ShopClassItemModel : NSObject
@property (nonatomic , copy) NSString * categoryName;
@property (nonatomic , copy) NSString * classId;


@end