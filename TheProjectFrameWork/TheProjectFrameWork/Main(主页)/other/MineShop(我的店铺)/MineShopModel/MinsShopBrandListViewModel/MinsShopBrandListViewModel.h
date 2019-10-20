//
//  MinsShopBrandListViewModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/22.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BrandModel;
typedef void(^completeBlock) (id error);
@interface MinsShopBrandListViewModel : NSObject
@property (nonatomic , strong) NSMutableArray<BrandModel *> * dataArray;
- (void)getBrandListCompleteBlock:(completeBlock)block;
- (void)getPageListCompleteBlock:(completeBlock)block;
- (void)updateBrandListCompleteBlock:(completeBlock)block;
- (void)reloadBrandListPage;
@end
