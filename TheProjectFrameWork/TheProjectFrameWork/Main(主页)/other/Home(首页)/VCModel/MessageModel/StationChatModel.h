//
//  StationChatModel.h
//  TheProjectFrameWork
//
//  Created by maple on 16/10/25.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StationChatModel : NSObject
/** <#注释#> */
@property(strong,nonatomic) NSString * toUserId;
/** <#注释#> */
@property(strong,nonatomic) NSString * content;
/** <#注释#> */
@property(strong,nonatomic) NSString * fromUserId;
/** <#注释#> */
@property(strong,nonatomic) NSString * addTime;
@end
