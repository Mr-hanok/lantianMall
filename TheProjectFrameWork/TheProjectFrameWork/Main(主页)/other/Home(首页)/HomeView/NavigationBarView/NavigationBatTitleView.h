//
//  NavigationBatTitleView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/30.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseView.h"

@interface NavigationBatTitleView : BaseView

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonWidth;
@end
