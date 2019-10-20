//
//  SellerRegisterTFView.h
//  TheProjectFrameWork
//
//  Created by yuntai on 16/8/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellerRegisterTFView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *contentTF;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, assign) CGRect fm;
+ (instancetype)initWithText:(NSString *)text
                 placeholder:(NSString *)placeholder
                       frame:(CGRect)frame;
@end
