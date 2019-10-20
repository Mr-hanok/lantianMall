//
//  IconLayer.h
//  test
//
//  Created by TheMacBook on 16/6/23.
//  Copyright © 2016年 TheMacBook. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface IconLayer : CALayer
@property (strong , nonatomic) UIImage * image;

- (instancetype)initWithImage:(UIImage *)image;
@end
