//
//  NSDictionary+write.h
//  TheProjectFrameWork
//
//  Created by maple on 2017/2/8.
//  Copyright © 2017年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (write)

-(BOOL)ds_writefiletohomePath:(NSString*)path;
+(NSDictionary*)ds_readfiletohomePath:(NSString*)path;
@end
