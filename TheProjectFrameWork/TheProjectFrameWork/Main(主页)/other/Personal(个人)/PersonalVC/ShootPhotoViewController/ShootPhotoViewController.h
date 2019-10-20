//
//  ShootPhotoViewController.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/15.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"
typedef NS_ENUM(NSInteger , IdentityPhotoTypes) {
    /**
     *  手持
     */
    IdentityPhotoTypeHand = 0,
    /**
     *  正面
     */
    IdentityPhotoTypeFront = 1,
    /**
     *  背面
     */
    IdentityPhotoTypeBack = 2,
};
/**
 *  拍摄照片
 */
@interface ShootPhotoViewController : LeftViewController

@end

@protocol IDPhotosViewDelegate <NSObject>

@optional
/**
 *  通过点击返回的枚举值
 */
- (void)photoWithType:(IdentityPhotoTypes)type;

@end
/**
 *  身份证照片信息
 */
@interface IDPhotosView : UIView

@property (nonatomic , weak) id <IDPhotosViewDelegate> delegate;
/**
 *  通过枚举值给图片赋值
 *
 *  @param type  <#type description#>
 *  @param image <#image description#>
 */
- (void)photoWithType:(IdentityPhotoTypes)type
            image:(UIImage *)image;
@end



@protocol PhotosViewDelegate <NSObject>
@optional
- (void)photos:(id)photo;


@end
@interface PhotosView : UIImageView

@property (nonatomic , assign) IdentityPhotoTypes type;
@property (nonatomic , weak) id <PhotosViewDelegate> delegate;
@property (nonatomic , strong) UIImage * photoImage;

- (instancetype)initWithType:(IdentityPhotoTypes)type;
@end