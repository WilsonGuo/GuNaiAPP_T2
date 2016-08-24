//
//  MainViewController.h
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/1/18.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GNDevice.h"
@interface MainViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleView;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIImageView *circleView;
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


@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIImageView *view3_radio_1;
@property (weak, nonatomic) IBOutlet UIImageView *view3_radio_2;
@property (weak, nonatomic) IBOutlet UIImageView *view3_radio_3;




@property (weak, nonatomic) IBOutlet UISlider *slider3;
@property (weak, nonatomic) IBOutlet UILabel *slider3_lable;
@property (weak, nonatomic) IBOutlet UIView *timeSetView;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker1;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker2;
//新风
@property (weak, nonatomic) IBOutlet UIButton *sliderBtn1;
//恒热
@property (weak, nonatomic) IBOutlet UIButton *sliderBtn3;

@property (weak, nonatomic) IBOutlet UIView *sliderLayoutView3;

@property(nonatomic,strong) GNDevice *device;
@property (weak, nonatomic) IBOutlet UIButton *windNew;
@property (weak, nonatomic) IBOutlet UIButton *paiFeng;
@property (weak, nonatomic) IBOutlet UIButton *fuRe;
@property (weak, nonatomic) IBOutlet UIButton *fuYang;
@property (weak, nonatomic) IBOutlet UIButton *wifiState;
@property (weak, nonatomic) IBOutlet UILabel *leverNum;

@property (weak, nonatomic) IBOutlet UILabel *indoorHuim;
@property (weak, nonatomic) IBOutlet UILabel *outdoorHuim;
@property (weak, nonatomic) IBOutlet UILabel *indoorTemp;
@property (weak, nonatomic) IBOutlet UILabel *outdoorTemp;
@property (weak, nonatomic) IBOutlet UIButton *hengShiBtn;
@property (weak, nonatomic) IBOutlet UILabel *timerTimeEnd;
@property (weak, nonatomic) IBOutlet UIButton *lvWangBrn;

@property (weak, nonatomic) IBOutlet UILabel *curTime;
@property (weak, nonatomic) IBOutlet UILabel *timerTime;
@property (weak, nonatomic) IBOutlet UILabel *runState;
@property (weak, nonatomic) IBOutlet UILabel *runTime;
@property (weak, nonatomic) IBOutlet UIButton *runTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *windIn;
@property (weak, nonatomic) IBOutlet UILabel *windOut;
@property (weak, nonatomic) IBOutlet UIButton *fenImg;


- (void)setStartHour:(NSDate *)date;
- (void)setStartMin:(NSDate *)date;

- (void)setEndHour:(NSDate *)date;
- (void)setEndMin:(NSDate *)date;




@end
