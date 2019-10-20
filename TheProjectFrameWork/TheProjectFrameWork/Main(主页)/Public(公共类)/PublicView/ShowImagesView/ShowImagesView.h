//
//  ShowImagesView.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/9/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^singleTap) ();
@interface ShowImagesView : UIView
/**
 *  图片路径
 */
@property (nonatomic , strong) NSArray * imagesPath;
@property (nonatomic , assign) NSInteger currentIndex;
@property (nonatomic , weak) UIView * selectView;
- (void)present;
@end



@interface ShowImageCell : UICollectionViewCell

@property (nonatomic , copy) NSString * url;
@property (nonatomic , copy) singleTap tapBlock;

@end