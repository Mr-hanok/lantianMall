//
//  OtherLoginView.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/27.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OtherLoginViewDelegate <NSObject>

- (void)otherLoginWithTitle:(NSString *)title;
@end
@interface OtherLoginView : UIView

@property (nonatomic , weak) id<OtherLoginViewDelegate> delegate;

@end
