//
//  DialogueRecordView.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/5.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  对话记录
 */
@interface DialogueRecordView : UIView

@end


@interface DialogueItem : UITableViewCell
@property (nonatomic , copy) NSString * title;
@property (nonatomic , copy) NSString * contentStr;



@end


@protocol DialogueHandleViewDelegate <NSObject>

- (void)DialogueHandlePublish;
- (void)DialogueHandleReload;
- (void)DialogueHandleSubmit;

@end
@interface DialogueHandleView : UIView
@property (nonatomic , weak) id <DialogueHandleViewDelegate> delegate;
@property (nonatomic , assign) BOOL waitingArbitration;
@end
