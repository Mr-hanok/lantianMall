
//
//  UIImage+Compression.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/19.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "UIImage+Compression.h"

@implementation UIImage (Compression)
- (UIImage *)imageWithScaledImage
{
    CGSize imagesize = self.size;
    if(imagesize.height>imagesize.width)
    {
        imagesize.height = 626;
        imagesize.width = 413;
    }else
    {
        imagesize.width = 626;
        imagesize.height = 413;
    }

    CGSize newSize = imagesize;

    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [self drawInRect:CGRectMake(0,0,newSize.height,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

- (UIImage *)handleImageWithURLStr:(NSString *)imageURLStr {
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURLStr]];
    NSData *newImageData = imageData;
    // 压缩图片data大小
    newImageData = UIImageJPEGRepresentation([UIImage imageWithData:newImageData scale:0.1], 0.1f);
    UIImage *image = [UIImage imageWithData:newImageData];
    
    // 压缩图片分辨率(因为data压缩到一定程度后，如果图片分辨率不缩小的话还是不行)
    CGSize newSize = CGSizeMake(200, 200);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,(NSInteger)newSize.width, (NSInteger)newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
// 压缩图片
- (UIImage *)scaleImageCompression:(UIImage *)image {
    CGFloat origanSize = [self getImageLengthWithImage:image];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1);
    if (origanSize > 1024) {
        imageData=UIImageJPEGRepresentation(image, 0.1);
    } else if (origanSize > 512) {
        imageData=UIImageJPEGRepresentation(image, 0.5);
    }
    UIImage *image1 = [UIImage imageWithData:imageData];
    return image1;
}

// 压缩图片尺寸
- (UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    NSInteger newWidth = (NSInteger)newSize.width;
    NSInteger newHeight = (NSInteger)newSize.height;
    if (image.size.width<=newWidth && image.size.height <=newHeight ) {
        return image;
    }
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    // Tell the old image to draw in this new context, with the desired
    // new size
    
    [image drawInRect:CGRectMake(0 , 0,newWidth, newHeight)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

- (CGFloat)getImageLengthWithImage:(UIImage *)image {
    NSData * imageData = UIImageJPEGRepresentation(image,1);
    CGFloat length = [imageData length]/1000;
    return length;
}
@end
