//
//  TransactionDetailsModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/4.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
/**兑换model*/
@interface TransactionDetailsModel : NSObject
@property (nonatomic , assign) NSInteger amount;
@property (nonatomic , copy) NSString * describe;
@property (nonatomic , copy) NSString * date;
@property (nonatomic , copy) NSString * type;



@end
