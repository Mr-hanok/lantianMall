//
//  NSString+Calculate.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Calculate)
/**
 *  字符串长度计算
 *
 *  @param string 内容
 *  @param font   字体
 *  @param height 高度
 *  @param weight 宽度
 *
 *  @return
 */
+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font maxHeight:(float) height maxWeight :(float)weight;

+(NSString*)caculater:(NSString*)StoreValue goodValue:(NSString*)goodsValue;


/** 中文编码 */
+(NSString*)encodeString:(NSString*)unencodedString;

-(NSString*)caculateFloatValue;

@end
