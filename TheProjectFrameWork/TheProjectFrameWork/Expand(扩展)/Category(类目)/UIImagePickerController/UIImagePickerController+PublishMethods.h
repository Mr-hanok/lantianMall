//
//  UIImagePickerController+PublishMethods.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImagePickerController (PublishMethods)

/**
 *  判断设备是否有摄像头
 *
 *  @return
 */
- (BOOL)isCameraAvailable;
/**
 *  <#Description#>
 *
 *  @return 前面的摄像头是否可用
 */
- (BOOL) isFrontCameraAvailable;
/**
 *   后面的摄像头是否可用
 *
 *  @return <#return value description#>
 */
- (BOOL) isRearCameraAvailable;
/**
 *  判断是否支持某种多媒体类型：拍照，视频
 *
 *  @param paramMediaType  paramMediaType description
 *  @param paramSourceType <#paramSourceType description#>
 *
 *  @return <#return value description#>
 */
- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType;
/**
 *  相册是否可用
 *
 *  @return <#return value description#>
 */
- (BOOL) isPhotoLibraryAvailable;

@end
