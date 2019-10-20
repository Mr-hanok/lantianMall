//
//  MineIconView.h
//  test
//
//  Created by TheMacBook on 16/6/28.
//  Copyright © 2016年 TheMacBook. All rights reserved.
//  用户头像信息

#import <UIKit/UIKit.h>
@protocol MineIconViewDelegate <NSObject>
/**
 *  点击用户信息
 */
- (void)iconClickIconEvent;
@end
@interface MineIconView : UIView
@property (nonatomic , strong) UIImage * image;
@property (nonatomic , copy) NSString * userName;
@property (nonatomic , copy) NSString * userRank;

@property (nonatomic , weak) id <MineIconViewDelegate> delegate;///< delegate

@end
