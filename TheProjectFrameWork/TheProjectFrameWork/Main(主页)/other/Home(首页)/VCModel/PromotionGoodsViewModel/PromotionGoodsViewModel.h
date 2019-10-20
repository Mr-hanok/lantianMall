//
//  PromotionGoodsViewModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/27.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^completeBlock) (id error);
@class PromotionGoodsModel,PromotionGoodsScrollModel;
@interface PromotionGoodsViewModel : NSObject
@property (nonatomic , strong) NSMutableArray <PromotionGoodsModel *> * dataArray;
@property (nonatomic , strong) NSArray <PromotionGoodsScrollModel *>* scrollIconArray;
@property (nonatomic, assign) BOOL isFirstPage;
/**
 *  获取活动商品数据
 *
 *  @param promotionID <#promotionID description#>
 *  @param block       <#block description#>
 */
- (void)getPromotionGoodsWithID:(NSInteger)promotionID Complete:(completeBlock)block;

/**
 *  搜索获得的活动商品数据
 *
 *  @param content <#content description#>
 *  @param block   <#block description#>
 */
- (void)searchPromotionGoodsWithSearchContent:(NSString *)content complete:(completeBlock)block;

/**
 *  获取(下拉)分页后的商品数据
 *
 *  @param block <#block description#>
 */
- (void)getPromotionGoodsPageInfoComplete:(completeBlock)block;

/**
 *  上拉刷新当前数据
 *
 *  @param completed <#completed description#>
 */
- (void)getHeaderGoodsInfoCompleted:(completeBlock)completed;
@end
