//
//  MineShopGoodsManagerViewModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/16.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ShopGoodsManagerModel;
typedef void(^completionHandleBlock) (id error);
@interface MineShopGoodsManagerViewModel : NSObject
@property (nonatomic , strong) NSMutableArray <ShopGoodsManagerModel *>* dataArray;
@property (nonatomic, assign) NSInteger currentPage;
;
/**
 *  获取商品管理信息
 *
 *  @param blcok <#blcok description#>
 *  @param url   <#url description#>
 */
- (void)getShopGoodsManagerCompletionHandle:(completionHandleBlock)blcok url:(NSString *)url;
/**
 *  搜索商品信息
 *
 *  @param text  <#text description#>
 *  @param block <#block description#>
 */
- (void)getSearchShopGoodsWithText:(NSString *)text complete:(completionHandleBlock)block  url:(NSString *)url;
/**
 *  商品管理信息分页
 *
 *  @param blcok <#blcok description#>
 */
- (void)getPageShopGoodsWithComplete:(completionHandleBlock)blcok;

/**
 *  删除商品
 *
 *  @param model <#model description#>
 *  @param block <#block description#>
 */
- (void)deleteShopGoodsWithModel:(ShopGoodsManagerModel *)model complete:(completionHandleBlock)block;

/**
 *  上架 下架商品
 *
 *  @param model <#model description#>
 *  @param block <#block description#>
 */
- (void)handleShopGoodsWithModel:(ShopGoodsManagerModel *)model complete:(completionHandleBlock)block;


/**
 *  推荐商品
 *
 *  @param model <#model description#>
 *  @param block <#block description#>
 */
- (void)recommendShopGoodsWithModel:(ShopGoodsManagerModel *)model complete:(completionHandleBlock)block;
@end
