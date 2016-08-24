//
//  CenterViewController.h
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/5/8.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GNDevice.h"
@interface CenterViewController : UIViewController

@property(nonatomic,strong) GNDevice *device;

@property (weak, nonatomic) IBOutlet UILabel *timerTimeEnd;

@property (weak, nonatomic) IBOutlet UILabel *curTime;
@property (weak, nonatomic) IBOutlet UILabel *timerTime;



@property (weak, nonatomic) IBOutlet UIButton *windNew;
@property (weak, nonatomic) IBOutlet UIButton *paiFeng;
@property (weak, nonatomic) IBOutlet UIButton *fuRe;
@property (weak, nonatomic) IBOutlet UIButton *fuYang;
@property (weak, nonatomic) IBOutlet UIButton *yiJun;
@property (weak, nonatomic) IBOutlet UIButton *quWei;

@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *humLabel;
@property (weak, nonatomic) IBOutlet UILabel *airWindLabel;
@property (weak, nonatomic) IBOutlet UILabel *airTempLabel;


@property (weak, nonatomic) IBOutlet UIButton *leverMidBtn;
@property (weak, nonatomic) IBOutlet UIButton *leverLowBtn;
@property (weak, nonatomic) IBOutlet UIButton *leverHighBtn;
@property (weak, nonatomic) IBOutlet UIButton *leverNoneBtn;


@property (weak, nonatomic) IBOutlet UILabel *pmLabel;
@property (weak, nonatomic) IBOutlet UILabel *co2Label;
@property (weak, nonatomic) IBOutlet UILabel *tvosLabel;
@property (weak, nonatomic) IBOutlet UILabel *formLabel;
@property (weak, nonatomic) IBOutlet UIButton *modelBtn;



@property (weak, nonatomic) IBOutlet UIView *view_1;
@property (weak, nonatomic) IBOutlet UILabel *view_1_label_1;
@property (weak, nonatomic) IBOutlet UILabel *view_1_label_2;
@property (weak, nonatomic) IBOutlet UISlider *view_1_progress_1;
@property (weak, nonatomic) IBOutlet UISlider *view_1_progress_2;



@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIImageView *view_2_radio_4;
@property (weak, nonatomic) IBOutlet UIImageView *view_2_radio_3;
@property (weak, nonatomic) IBOutlet UIImageView *view_2_radio_2;
@property (weak, nonatomic) IBOutlet UIImageView *view_2_radio_1;
@property (weak, nonatomic) IBOutlet UIImageView *view_2_radio_5;

@property (weak, nonatomic) IBOutlet UIView *timeSetView;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker1;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker2;

@property (weak, nonatomic) IBOutlet UIButton *fenImg;

@property (weak, nonatomic) IBOutlet UILabel *runTime;
@property (weak, nonatomic) IBOutlet UILabel *airLabel;
@property (weak, nonatomic) IBOutlet UILabel *wind_in;
@property (weak, nonatomic) IBOutlet UILabel *wind_out;
@property (weak, nonatomic) IBOutlet UIImageView *airMainLever;
@property (weak, nonatomic) IBOutlet UIImageView *leverImg;
@end
