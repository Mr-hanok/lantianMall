//
//  OtherButton.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/27.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OtherButtonDelegate <NSObject>
- (void)clickButtonWithTitle:(NSString *)title;
@end
@interface OtherButton : UIView

@property (nonatomic , weak) id <OtherButtonDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title
                   titleColor:(UIColor *)color
                        image:(UIImage *)image;
@end
