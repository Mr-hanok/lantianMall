//
//  AdressAreaModel.h
//  TheProjectFrameWork
//
//  Created by yuntai on 16/8/20.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
/**省市信息 Model*/
@interface AdressAreaModel : NSObject

@property (nonatomic, copy) NSString *areaId;
@property (nonatomic, copy) NSString *areaName;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, copy) NSString *zip;
@property (nonatomic, strong) NSMutableArray *childs;
@property (nonatomic, strong) AdressAreaModel *childMArea;
@end
