//
//  PlaceholderTextView.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PlaceholderTextViewDelegate <NSObject>
@optional
- (void)placeholderTextViewContent:(NSString *)content;
@end
@interface PlaceholderTextView : UIView

@property (nonatomic , copy) NSString * placeholder;
@property (nonatomic , copy) NSString * text;
@property (nonatomic , strong) UIFont * font;
@property (nonatomic , weak) id<PlaceholderTextViewDelegate> delegate;

@end
