//
//  RefundApplyView.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/20.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseOrderPopView.h"

typedef void(^ResultBlock)(NSString*string);
/**
 *  申请退款弹出视图
 */
@interface RefundApplyView : BaseOrderPopView

@property(copy,nonatomic) ResultBlock block;
/** 获取内容 */
-(void)GetResultBlock:(ResultBlock)block;
@end
