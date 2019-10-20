//
//  BaseModel.m
//  BaseModel
//
//  Created by maple on 16/3/17.
//  Copyright © 2016年 MapleDong. All rights reserved.
//
#import <objc/runtime.h>
#import "BaseModel.h"

@implementation BaseModel
-(NSMutableArray*)getUnDefineKey{
  return   self.undefineValueArray;
}
/**
 *  获取所有的类名放到数组当中
 *
 *  @return
 */
- (NSArray*)propertyKeys
{    ///存储属性的个数
    unsigned int outCount, i;
    ///通过运行时获取当前类的属性
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    ///存储所有的属性名称
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outCount];
    for (i = 0; i < outCount; i++) {
        ///取出第一个属性
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
    }
    free(properties);
    return keys;
}
/**
 *  通过iOS反射 将字典中的Key Value 存放到类中返回
 *
 *  @param dataSource <#dataSource description#>
 *
 *  @return <#return value description#>
 */
-(BOOL)CreatClasswithNSObject:(NSObject*)dataSource
{
    
    BOOL ret = NO;
    for (NSString *key in [self propertyKeys]) {
        if ([dataSource isKindOfClass:[NSDictionary class]])
        {
            ret = ([dataSource valueForKey:key]==nil)?NO:YES;
        }
        else
        {
            ret = [dataSource respondsToSelector:NSSelectorFromString(key)];
        }
        if (ret)
        {
            id propertyValue = [dataSource valueForKey:key];
            //该值不为NSNULL，并且也不为nil
            if (![propertyValue isKindOfClass:[NSNull class]] && propertyValue!=nil) {
                [self setValue:propertyValue forKey:key];
            }
        }
        else
        {
            if ([self valueForUnDefine]&&[self valueForUnDefine][key])
            {
                    [self setValue:[dataSource valueForKey:[self valueForUnDefine][key]] forKey:key];
            }
            else{
                if (self.undefineValueArray.count ) {
                    [self.undefineValueArray addObject:key];
                }
                else{
                    self.undefineValueArray = [NSMutableArray array];
                    [self.undefineValueArray addObject:key];
                }

            }
            
//            if ([self changgeWith:key]) {
//                [self setValue:[dataSource valueForKey:[self changgeWith:key]] forKey:key];
//            }
//            else{
//                NSLog(@"-------%@没有找到的属性",key);
//            }
        }
    }
    return ret;
    
    
}

/**
 *  将jeson 存放到可变数组中
 *
 *  @param jseonData 网络请求下来的
 *
 *  @return
 */
+(NSMutableArray*)ArrayWithJesonData:(id)jseonData
{
    if ([jseonData isKindOfClass:[NSArray class]]) {
        NSMutableArray * array = [NSMutableArray array];
        for (NSDictionary * dic in jseonData) {
            id  test = [[[self class] alloc] init];
            [test CreatClasswithNSObject:dic];
            [array addObject:test];
        }
        return array;
    }
    else if ([jseonData isKindOfClass:[NSDictionary class]])
    {
        NSMutableArray * array = [NSMutableArray array];
        id  test = [[[self class] alloc] init];
        [test CreatClasswithNSObject:jseonData];
        [array addObject:test];
        return array;
    }
    else{
        return nil;
    }
    
}

/**
 *  设置字典的返回参数
 *
 *  @param key 是类本身属性 Value是字典中model
 *
 *  @return
 */
-(NSString*)changgeWith:(NSString*)key{
    NSDictionary * dic =@{@"类本身属性名称":@"jeson字典中名称"};
    return([dic valueForKey:key]==nil)?nil:dic[key];
}

-(NSDictionary*)valueForUnDefine{
    NSDictionary * dic =@{@"类本身属性名称":@"jeson字典中名称"};
    return dic;
}

- (void)runTests
{
    unsigned int count;
    Method *methods = class_copyMethodList([self class], &count);
    
    for (int i = 0; i < count; i++)
    {
        Method method = methods[i];
        SEL selector = method_getName(method);
        NSString *name = NSStringFromSelector(selector);
        //        if ([name hasPrefix:@"test"])
        NSLog(@"方法 名字 ==== %@",name);
        if (name)
        {
            //avoid arc warning by using c runtime
            //            objc_msgSend(self, selector);
        }
        
        NSLog(@"Test '%@' completed successfuly", [name substringFromIndex:4]);
    }
}

@end
