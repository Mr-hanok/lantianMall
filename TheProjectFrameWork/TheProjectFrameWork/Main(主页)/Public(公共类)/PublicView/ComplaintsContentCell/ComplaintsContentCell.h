//
//  ComplaintsContentCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/21.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ComplaintItemsView.h"
#import "BaseSpaceTableViewCell.h"
@class ComplaintsContentCell,ComplaintItemsView,ComplaintItemsViewDelegate,PhotoView,ShootingPhotoCell,PhotoViews;
@protocol ComplaintsContentCellDelegate <NSObject>
@optional
/**
 *  点击选择投诉主题
 */
- (void)complaintsSubjectSelectWithCell:(ComplaintsContentCell *)cell;
/**
 *  投诉内容
 */
- (void)complaintContentWithContent:(NSString *)content;
/**
 *  投诉描述
 */
- (void)complaintDescribeWithDescribe:(NSString *)describe;
@end

@interface ComplaintsContentCell : BaseSpaceTableViewCell<ComplaintItemsViewDelegate>
@property (nonatomic , weak) id <ComplaintsContentCellDelegate> delegate;
@property (nonatomic , copy) NSString * subjectTitle;
@property (nonatomic , assign) NSInteger subjectRow;
@end

@protocol ShootingPhotoCellDelegate <NSObject>
- (void)shootPhoto:(ShootingPhotoCell *)cell tag:(NSInteger)tag residual:(NSInteger)residual;
@end
/**
 *  取证照片拍摄
 */
@interface ShootingPhotoCell : BaseSpaceTableViewCell
/**
 *  获取image 给相片赋值
 */
- (void)setPhotoImage:(UIImage *)image;
- (NSArray *)allImages;
@property (nonatomic , weak) id <ShootingPhotoCellDelegate> delegate;

@end

@protocol PhotoViewsDelegate <NSObject>
@optional
- (void)PhotoViews:(PhotoViews *)view tag:(NSInteger)tag residual:(NSInteger)residual;


- (void)photoViews:(PhotoViews *)view showRect:(CGRect)rect index:(NSInteger)index photo:(UIView *)photo;

@end
@interface PhotoViews : UIView
@property (nonatomic , weak) id <PhotoViewsDelegate> delegate;
@property (nonatomic , strong) NSArray * allImage;
@property (nonatomic , strong) NSArray * nowImages;
@property (nonatomic , strong) NSArray * imagePaths;
@property (nonatomic , assign) BOOL show;
- (instancetype)initWithPhotos:(NSArray *)array;
- (void)setSelectPhotoImage:(UIImage *)image;

@end

@protocol PhotoViewDelegate <NSObject>

/**
 *  点击投诉相片
 */
- (void)photoClickWithPhoto:(PhotoView *)photo;
@end
@interface PhotoView : UIImageView
@property (nonatomic , strong) UIImage * photo;
@property (nonatomic , assign) BOOL evaluate;
@property (nonatomic , weak) id <PhotoViewDelegate> delegate;

@end
