//
//  ComplaintItemsView.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/20.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ComplaintItemsViewDelegate <NSObject>
@optional
- (void)complaintItemWithTitle:(NSString *)title;
- (void)complaintItemWithTitle:(NSString *)title row:(NSInteger)row;
@end
@interface ComplaintItemsView : UIView
@property (nonatomic , strong) UIColor * toolColor;
@property (nonatomic , strong) UIColor * contentColor;
@property (nonatomic , strong) UIColor * buttonColor;
@property (nonatomic , weak) id <ComplaintItemsViewDelegate> delegate;
- (instancetype)initWithTitles:(NSArray *)titles;
- (void)displayToWindow;
@end
