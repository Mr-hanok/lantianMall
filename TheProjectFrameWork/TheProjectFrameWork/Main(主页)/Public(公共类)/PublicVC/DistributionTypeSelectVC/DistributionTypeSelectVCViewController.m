//
//  DistributionTypeSelectVCViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/25.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "DistributionTypeSelectVCViewController.h"
#import "DistributionDateView.h"

@interface DistributionTypeSelectVCViewController ()<DistributionDateViewDelegate>
/** 普通快递 */
@property (weak, nonatomic) IBOutlet UIButton *normaldeliveryButton;
/** 极速快递 */
@property (weak, nonatomic) IBOutlet UIButton *fastdeliveryButton;
@property (weak, nonatomic) IBOutlet UILabel *deliveryTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectTimeButton;
@property (weak, nonatomic) IBOutlet UILabel *specificationLabel;
@property (weak, nonatomic) IBOutlet UILabel *distributionLabel;


@end

@implementation DistributionTypeSelectVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.distributionLabel.text = LaguageControlAppend(@"配送方式")
    ;
    self.specificationLabel.text =LaguageControlAppend(@"配送时间");
    
    self.title =[LaguageControl languageWithString: @"选择配送方式"];
    
    [self.normaldeliveryButton setTitle:LaguageControl(@"普通快递") forState:UIControlStateNormal];
    
    [self.fastdeliveryButton setTitle:LaguageControl(@"急速快递") forState:UIControlStateNormal];
    self.normaldeliveryButton.layer.masksToBounds = YES;
    self.normaldeliveryButton.layer.cornerRadius = 5;
    self.normaldeliveryButton.layer.borderWidth = 1;
    self.normaldeliveryButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.fastdeliveryButton.layer.masksToBounds = YES;
    self.fastdeliveryButton.layer.cornerRadius = 5;
    self.fastdeliveryButton.layer.borderWidth = 1;
    self.fastdeliveryButton.layer.borderColor = kNavigationCGColor;
    if ([self.selectedType isEqualToString:@"2"]) {
        [self performSelector:@selector(buttonClicked:) withObject: self.fastdeliveryButton];
    }
    else{
        [self performSelector:@selector(buttonClicked:) withObject: self.normaldeliveryButton];
    }
    // Do any additional setup after loading the view from its nib.
}
-(void)load:(UIButton*)button with:(UIColor*)color
{
    if (color ==[UIColor darkGrayColor]) {
        button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    else{
        button.layer.borderColor = color.CGColor;
    }
    [button setTitleColor:color forState:UIControlStateNormal];
}
-(void)GetSendType:(GetType)block
{
    self.block = block;
}
-(void)backToPresentViewController
{

    if (self.deliveryTimeLabel.alpha ==1)
    {
        NSDictionary * dic =@{@"name":@"2" ,@"content":self.deliveryTimeLabel.text};
        if (self.deliveryTimeLabel.text.length) {
            self.block(dic,YES);
            [super backToPresentViewController];
        }
        else
        {
            [HUDManager showWarningWithText:@"选择时间"];
        }
    }
    else
    {
            NSDictionary * dic =@{@"name":@"1",@"content":self.deliveryTimeLabel.text};
            self.block(dic,NO);
            [super backToPresentViewController];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/** 快递方式选择 */
- (IBAction)buttonClicked:(UIButton *)sender
{
    if (sender==self.fastdeliveryButton)
    {
        self.selectTimeButton.alpha = 1;
        self.specificationLabel.alpha = 1;
        self.deliveryTimeLabel.alpha = 1;
        [self load:self.normaldeliveryButton with:[UIColor darkGrayColor]];
    }
    else
    {
        self.selectTimeButton.alpha = 0;
        self.specificationLabel.alpha = 0;
        self.deliveryTimeLabel.alpha = 0;
        [self load:self.fastdeliveryButton with:[UIColor darkGrayColor]];
    }
    [self load:sender with:kNavigationColor];

}
/** 选择时间 */
- (IBAction)selectedTimeButton:(UIButton *)sender
{
    DistributionDateView * view = [[DistributionDateView alloc] init];
    view.delegate = self;
    view.timeArray = self.array;
    [view displayToWindow];
}
#pragma mark ---DistributionDateViewDelegate

- (void)distributionDate:(DistributionDateView *)dateView
{
    self.deliveryTimeLabel.text = dateView.dateString;
    [dateView removeFromWindow];
}

@end
