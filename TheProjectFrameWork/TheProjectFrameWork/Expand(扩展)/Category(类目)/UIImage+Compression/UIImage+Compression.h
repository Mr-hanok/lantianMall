//
//  UIImage+Compression.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/19.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Compression)
/**
 *  对图片进行压缩
 *
 *  @return <#return value description#>
 */
- (UIImage *)imageWithScaledImage;

- (UIImage *)handleImageWithURLStr:(NSString *)imageURLStr;
// 压缩图片
- (UIImage *)scaleImageCompression:(UIImage *)image;
// 压缩图片尺寸
- (UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

@end
