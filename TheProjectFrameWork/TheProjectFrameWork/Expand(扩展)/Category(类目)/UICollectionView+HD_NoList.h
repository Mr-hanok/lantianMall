//
//  UICollectionView+HD_NoList.h
//  TheProjectFrameWork
//
//  Created by yuntai on 2017/12/15.
//  Copyright © 2017年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (HD_NoList)

-(void)showNoView:(NSString *)title image:(UIImage *)placeImage certer:(CGPoint)p isShow:(BOOL)isShow;
-(void)dismissNoView;


///
@property(nonatomic,assign,readonly,getter=isShowNoView)BOOL showNoView;


@end
