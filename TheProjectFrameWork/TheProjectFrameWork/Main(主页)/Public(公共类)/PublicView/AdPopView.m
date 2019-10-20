//
//  AdPopView.m
//  TheProjectFrameWork
//
//  Created by yuntai on 2019/1/22.
//  Copyright © 2019年 MapleDongSen. All rights reserved.
//

#import "AdPopView.h"
#import "CountDownButton.h"

@interface AdPopView ()

@property (nonatomic,copy)NSString *imageUrl ;
@property (nonatomic,strong)UIImageView *imageView ;
@property (nonatomic,strong)UIButton *closeBtn;
@property (nonatomic, strong) UILabel *countBtn;
@end

@implementation AdPopView


- (instancetype)initWithImageUrl:(NSString *)imageUrl showInView:(UIView *)fatherView{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.5];
        self.frame = fatherView.bounds;

        
        self.imageView = [[UIImageView alloc]init];
        self.imageView.userInteractionEnabled = YES;
        [self.imageView setContentMode:UIViewContentModeScaleToFill];
        __weak typeof(UIImageView) *weakImageView = self.imageView;
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            weakImageView.mj_h = (KSCREEN_WIDTH-100)*image.size.height/image.size.width;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageview)];
            [weakImageView addGestureRecognizer:tap];
            
        }];
        CGRect imgFrame;
        imgFrame.size.width = imgFrame.size.height = KSCREEN_WIDTH-100;
        self.imageView.frame = imgFrame;
        self.imageView.center = CGPointMake(self.center.x, self.center.y-20);
        self.imageView.layer.cornerRadius = 5.f;
        self.imageView.layer.masksToBounds = YES;
        
        self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [ self.closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        self.closeBtn.mj_w= 30;
        self.closeBtn.mj_h = 30;
        self.closeBtn.mj_x = KSCREEN_WIDTH-50-15;
        self.closeBtn.mj_y = self.imageView.mj_y-15;
        [self.closeBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
        
        
        self.countBtn = [[UILabel alloc]init];
        [self.countBtn setBackgroundColor:[[UIColor blackColor]colorWithAlphaComponent:.5]];
        self.countBtn.text = @"倒计时:8s";
        self.countBtn.frame = CGRectMake(self.imageView.mj_origin.x+10, self.imageView.mj_origin.y+10, 60, 20);
        self.countBtn.font = [UIFont systemFontOfSize:10];
        [self.countBtn setTextAlignment:NSTextAlignmentCenter];
        self.countBtn.textColor = [UIColor whiteColor];
        self.countBtn.layer.cornerRadius = 2.f;
        self.countBtn.layer.masksToBounds = YES;
        
        
        [self addSubview:self.imageView];
        [self addSubview:self.closeBtn];
        [self addSubview:self.countBtn];
        
        __weak typeof(UIView) *weakFatherView = fatherView;
        [weakFatherView addSubview:self];
        self.alpha = 0;
        [UIView animateWithDuration:.5 animations:^{
            self.alpha= 1;
        } completion:^(BOOL finished) {
            [self createTimer];
        }];
        
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.5];
        
    }
    return self;
}
- (void)closeView{
    [UIView animateWithDuration:.4 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)tapImageview{
    if (self.didSelBlock) {
        self.didSelBlock();
    }
    [self closeView];
}

#pragma mark - 定时器 (GCD)
- (void)createTimer {
    
    //设置倒计时时间
    //通过检验发现，方法调用后，timeout会先自动-1，所以如果从15秒开始倒计时timeout应该写16
    //__block 如果修饰指针时，指针相当于弱引用，指针对指向的对象不产生引用计数的影响
    __block int timeout = 8;
    
    //获取全局队列
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //创建一个定时器，并将定时器的任务交给全局队列执行(并行，不会造成主线程阻塞)
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, global);
    
    // 设置触发的间隔时间
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    //1.0 * NSEC_PER_SEC  代表设置定时器触发的时间间隔为1s
    //0 * NSEC_PER_SEC    代表时间允许的误差是 0s
    
    //block内部 如果对当前对象的强引用属性修改 应该使用__weak typeof(self)weakSelf 修饰  避免循环调用
    __weak typeof(self)weakSelf = self;
    //设置定时器的触发事件
    dispatch_source_set_event_handler(timer, ^{
        
        //倒计时  刷新button上的title ，当倒计时时间为0时，结束倒计时
        
        //1. 每调用一次 时间-1s
        timeout --;
        
        //2.对timeout进行判断时间是停止倒计时，还是修改button的title
        if (timeout <= 0) {
            
            //停止倒计时，button打开交互，背景颜色还原，title还原
            
            //关闭定时器
            dispatch_source_cancel(timer);
            
            //MRC下需要释放，这里不需要
            //            dispatch_realse(timer);
            
            //button上的相关设置
            //注意: button是属于UI，在iOS中多线程处理时，UI控件的操作必须是交给主线程(主队列)
            //在主线程中对button进行修改操作
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf closeView];
            });
        }else {
            
            //处于正在倒计时，在主线程中刷新button上的title，时间-1秒
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSString * title = [NSString stringWithFormat:@"倒计时:%ds",timeout];
                
                weakSelf.countBtn.text = title; ;
            });
        }
    });
    
    dispatch_resume(timer);
}
@end
