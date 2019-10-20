//
//  ImageButton.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/6.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ImageButton;
@protocol ImageButtonDelegate <NSObject>
@optional
- (void)imageButton:(ImageButton *)button;

@end
@interface ImageButton : UIView
@property (nonatomic , weak) id <ImageButtonDelegate> delegate;
@property (nonatomic , copy) NSString * title;
@property (nonatomic , strong) UIImage * nowImage;
@property (nonatomic , assign) BOOL select;
@property (nonatomic , strong) UIColor * selectTextColor;
- (void)setImage:(UIImage *)normalImage
     selectImage:(UIImage *)selectImage
           title:(NSString *)title;
@end
