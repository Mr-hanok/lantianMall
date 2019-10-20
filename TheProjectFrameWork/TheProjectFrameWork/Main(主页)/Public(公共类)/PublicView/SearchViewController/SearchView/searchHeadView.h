//
//  searchHeadView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/5.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchHeadView : UITableViewHeaderFooterView
/** 搜索内容 */
@property (weak, nonatomic) IBOutlet UILabel *searchTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectedButton;

@end
