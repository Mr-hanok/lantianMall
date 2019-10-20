//
//  UITableView+HD_NoList.h
//  houDaProject
//
//  Created by yuntai on 2017/10/26.
//  Copyright © 2017年 yuntai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (HD_NoList)


-(void)showNoView:(NSString *)title image:(UIImage *)placeImage certer:(CGPoint)p isShow:(BOOL)isShow;
-(void)dismissNoView;


///
@property(nonatomic,assign,readonly,getter=isShowNoView)BOOL showNoView;



@end
