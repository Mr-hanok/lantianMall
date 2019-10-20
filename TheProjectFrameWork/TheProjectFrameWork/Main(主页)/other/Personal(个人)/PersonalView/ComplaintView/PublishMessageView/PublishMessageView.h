//
//  PublishMessageView.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PublishMessageViewDelegate <NSObject>
- (void)pulishMessageComplete:(NSString *)text;
@end
@interface PublishMessageView : UIView
@property (nonatomic , weak) id <PublishMessageViewDelegate> delegate;

@property (nonatomic , weak) UITextView * textField;

@end
