//
//  NavigationBarView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/22.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"

@interface NavigationBarView : BaseView
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
-(void)SetIamgeView;
@end
