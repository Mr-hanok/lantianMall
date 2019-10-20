//
//  BaseModel.h
//  BaseModel
//
//  Created by maple on 16/3/17.
//  Copyright © 2016年 MapleDong. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BaseModel : NSObject
@property (nonatomic, strong) NSMutableArray *undefineValueArray;
/**
 *  给类中的属性一一赋字典的值
 *
 *  @param dataSource <#dataSource description#>
 *
 *  @return <#return value description#>
 */
-(BOOL)CreatClasswithNSObject:(NSObject*)dataSource;
/**
 *  设置 属性中有但是字典中没有的字段名字
 *
 *  @param key <#key description#>
 *
 *  @return <#return value description#>
 */
-(NSString*)changgeWith:(NSString*)key;
/**
 *  通过jeseon字符串将字典转换为数组
 *
 *  @param jseonData <#jseonData description#>
 *
 *  @return <#return value description#>
 */
+(NSMutableArray*)ArrayWithJesonData:(id)jseonData;
/**
 *  Description
 *
 *  @return <#return value description#>
 */
-(NSDictionary*)valueForUnDefine;
/**
 *
 *
 *  @return <#return value description#>
 */
-(NSMutableArray*)getUnDefineKey;

@end
