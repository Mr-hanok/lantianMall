//
//  ComplaintsViewController.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/21.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//
typedef void (^imageLoadCompleteBlock) (NSArray * imageInfoModel);
@class OrderGoodsModel;
@class BuyerOrderModel;
@class ComplaintSubjectItemModel;
#import "LeftViewController.h"
/**
 *  投诉
 */
@interface ComplaintsViewController : LeftViewController
@property (nonatomic , strong) BuyerOrderModel * buyerOrder;

@property (nonatomic , strong) NSArray<OrderGoodsModel *> * goodsModels;
@property (nonatomic , assign) BOOL buyer;
@end


/**
 *  投诉主题模型
 */
@interface ComplaintSubjectItemModel : NSObject

@property (nonatomic , copy) NSString * itemId;
@property (nonatomic , copy) NSString * title;
@property (nonatomic , copy) NSString * content;



@end