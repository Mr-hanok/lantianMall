//
//  BrandModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/22.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
/**品牌model*/
@interface BrandModel : NSObject
@property (nonatomic , assign) NSInteger brandID;
@property (nonatomic , assign) NSInteger audit;
@property (nonatomic , copy) NSString * image;
@property (nonatomic , copy) NSString * name;


@end
