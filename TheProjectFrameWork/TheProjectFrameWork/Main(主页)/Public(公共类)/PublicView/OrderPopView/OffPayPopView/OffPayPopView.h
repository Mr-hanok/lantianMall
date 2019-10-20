//
//  OffPayPopView.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/20.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseOrderPopView.h"

typedef void(^Result)(NSString * result);
typedef void (^sureBlock) (NSString * content);
/**
 *  确认取消订单弹出视图
 */
@interface OffPayPopView : BaseOrderPopView
@property (nonatomic , copy) Result blcoks;
@property (nonatomic , copy) sureBlock sureEventBlock;
@property (nonatomic , strong) NSArray * issues; ///< 可选择内容数组
@property (nonatomic , copy) NSString * title; ///< 标题
@property (nonatomic , copy) NSString * orderID; ///< 订单号


- (void)getsureEventBlock:(sureBlock)block;
@end


@interface OffPayButton : UIButton
@end