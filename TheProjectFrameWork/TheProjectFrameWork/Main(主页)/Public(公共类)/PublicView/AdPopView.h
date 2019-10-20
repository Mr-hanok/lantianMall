//
//  AdPopView.h
//  TheProjectFrameWork
//
//  Created by yuntai on 2019/1/22.
//  Copyright © 2019年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdPopView : UIView

@property (nonatomic, copy) void (^didSelBlock)(void);
- (instancetype)initWithImageUrl:(NSString *)imageUrl showInView:(UIView *)fatherView;
@end
