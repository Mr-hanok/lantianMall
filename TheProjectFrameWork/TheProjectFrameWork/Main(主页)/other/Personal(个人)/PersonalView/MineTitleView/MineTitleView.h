//
//  MineTitleView.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/30.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MineTitleView;
@protocol MineTitleViewDelegate <NSObject>
@optional
- (void)mineTitleViewClick:(MineTitleView *)view;
@end
@interface MineTitleView : UIView

@property (nonatomic , copy) NSString * title;

@property (nonatomic , strong) UIImage * image;

@property (nonatomic , weak) id <MineTitleViewDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image;
@end
