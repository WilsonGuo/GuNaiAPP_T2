//
//  CenterViewController.m
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/5/8.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import "CenterViewController.h"
#import "SetViewController.h"
#import "RegisterViewController.h"
#import "user_interface.h"
#import "AppDelegate.h"
#import "NetWorkManager.h"
#import "CMD.h"
#import "OpenViewController.h"
#import "ScreenViewController.h"

@interface CenterViewController ()

@end

@implementation CenterViewController{
    Byte startTime;
    Byte startMin;
    Byte endTime;
    Byte endMin;
    
    int slider_1_value;
    int slider_2_value;
    
    bool isShow;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view_1_progress_1 addTarget:self action:@selector(windSliderValueChanged:) forControlEvents:UIControlEventValueChanged];//添加滑动事件
    [self.view_1_progress_2 addTarget:self action:@selector(windSliderValueChanged:) forControlEvents:UIControlEventValueChanged];//添加滑动事件
    
    
    [self.timePicker1 addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    
    
    [self.timePicker2 addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getData:)
                                                 name:NOTICE_MAIN_MSG_TYPE_DATA object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(turnOff:)
                                                 name:UI_CMD_RESULT_STATUS_TURN_OFF object:nil];
    
    
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 2;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = HUGE_VALF;
    
    [self.fenImg.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    //self.device=[NetWorkManager sharedInstance].devInfo;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self ReflushUI];
    });
    
    
    if (self.device.devInfo.workMode==0) {
        OpenViewController *vc=[[OpenViewController alloc]init];
        vc.device=self.device;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//注销广播接收
- (void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)getData:(NSNotification *)notification{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self ReflushUI];
        
    });
    
}


-(void)turnOff:(NSNotification *)notification{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (!isShow) {
            DeviceInfo *info=[[notification userInfo] objectForKey:@"devID"];
            if(info!=nil){
                NSLog(@"turnOff>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>info.sn===%@,   id=%@",[NSString stringWithFormat:@"%x", info.sn],self.device.devId);
                if([[NSString stringWithFormat:@"%x", info.sn] isEqual:self.device.devId]){
                    OpenViewController *vc=[[OpenViewController alloc]init];
                    vc.device=self.device;
                    [self.navigationController pushViewController:vc animated:YES];
                    isShow=true;
                }
            }
          
        }
        
    });
    
    
    
    
}

- (IBAction)switchAction:(id)sender {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        int devID=strtoul([[self.device.devId substringWithRange:NSMakeRange(0, self.device.devId.length)] UTF8String],0,16);
        
        int result=[[NetWorkManager sharedInstance] airClose:devID];
        NSLog(@"airClose>>>>>>>>>>>>result＝%d",result);
        
    });
    
}



//添加滑动事件
-(void)windSliderValueChanged:(UISlider *)paramSender{
    int value=(int)paramSender.value;
    if ([paramSender isEqual:self.view_1_progress_1]){
        NSLog(@"view_1_progress_1 value=%f",paramSender.value);
        self.view_1_label_2.text=[NSString stringWithFormat:@"新风：%d",value];
        slider_1_value=value;
        
    }else if([paramSender isEqual:self.view_1_progress_2]){
        
        NSLog(@"view_1_progress_2 value=%f",paramSender.value);
        self.view_1_label_1.text=[NSString stringWithFormat:@"排风：%d",value];
        slider_2_value=value;
        
    }
}
-(void)dateChanged:(id)sender{
    UIDatePicker* control = (UIDatePicker*)sender;
    NSDate* _date = control.date;
    
    if ([sender isEqual:self.timePicker1]) {
        [self setStartHour:_date];
        [self setStartMin:_date];
        
    }else if ([sender isEqual:self.timePicker2]) {
        [self setEndHour:_date];
        [self setEndMin:_date];
    }
    
}



- (void)setStartHour:(NSDate *)date {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:kCFDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"HH"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    startTime=[dateString intValue];
}
- (void)setStartMin:(NSDate *)date {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:kCFDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"mm"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    startMin=[dateString intValue];
}

- (void)setEndHour:(NSDate *)date {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:kCFDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"HH"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    endTime=[dateString intValue];
}
- (void)setEndMin:(NSDate *)date {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:kCFDateFormatterFullStyle];
    [dateFormatter setDateFormat:@"mm"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    endMin=[dateString intValue];
}


- (IBAction)timeOKAction:(id)sender {
    if (self.device!=nil) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSDate *date1 = self.timePicker1.date;
            NSDate *date2 = self.timePicker2.date;
            [self setStartHour:date1];
            [self setStartMin:date1];
            [self setEndHour:date2];
            [self setEndMin:date2];
            
            
            int infoID=strtoul([[self.device.devId substringWithRange:NSMakeRange(0, self.device.devId.length)] UTF8String],0,16);
            [[NetWorkManager sharedInstance] airSetTimer:startTime withStartMin:startMin withEndHour:endTime withEndMin:endMin withID:infoID];
            
        });
        
    }
    self.timeSetView.hidden=YES;
}
- (IBAction)timeCancelAction:(id)sender {
    self.timeSetView.hidden=YES;
}


- (IBAction)bottomLeftAction:(id)sender {
    
    self.view_1.hidden=NO;
    self.view_1_label_1.text=[NSString stringWithFormat:@"新风：%d",self.device.devInfo.windInLevel];;
    self.view_1_label_2.text=[NSString stringWithFormat:@"排风：%d",self.device.devInfo.windOutLevel];
    [self.view_1_progress_2 setValue:self.device.devInfo.windInLevel];
    [self.view_1_progress_1 setValue:self.device.devInfo.windOutLevel];
    
}

- (IBAction)bottomRightAction:(id)sender {
    
    
    self.view2.hidden=NO;
}

- (IBAction)slider_1_Action:(id)sender {
    
    int infoID=strtoul([[self.device.devId substringWithRange:NSMakeRange(0, self.device.devId.length)] UTF8String],0,16);
    
    [[NetWorkManager sharedInstance] airSetWindOutLevel:slider_1_value withID:infoID];
    
}

- (IBAction)slider_2_Action:(id)sender {
    
    int infoID=strtoul([[self.device.devId substringWithRange:NSMakeRange(0, self.device.devId.length)] UTF8String],0,16);
    [[NetWorkManager sharedInstance] airSetWindInLevel:slider_2_value withID:infoID];
}




- (IBAction)setTimeAction:(id)sender {
    if (self.timeSetView.isHidden) {
        self.timeSetView.hidden=NO;
    }else{
        self.timeSetView.hidden=YES;
    }
    
}
- (IBAction)hideView_1:(id)sender {
    self.view_1.hidden=YES;
    
}
- (IBAction)hideView_2:(id)sender {
    
    self.view2.hidden=YES;
}
- (IBAction)view_2_choose_5:(id)sender {
    
    [self.view_2_radio_5 setImage:[UIImage imageNamed:@"radio_checked"]];
    [self.view_2_radio_4 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view_2_radio_3 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view_2_radio_2 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view_2_radio_1 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    
    int infoID=strtoul([[self.device.devId substringWithRange:NSMakeRange(0, self.device.devId.length)] UTF8String],0,16);
    [[NetWorkManager sharedInstance] airSetMode:CENTRAL_MODE_AUTO withID:infoID];
    self.view2.hidden=YES;
}

- (IBAction)view_2_choose_4:(id)sender {
    
    
    [self.view_2_radio_5 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view_2_radio_4 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view_2_radio_3 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view_2_radio_2 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view_2_radio_1 setImage:[UIImage imageNamed:@"radio_checked"]];
    
    int infoID=strtoul([[self.device.devId substringWithRange:NSMakeRange(0, self.device.devId.length)] UTF8String],0,16);
    [[NetWorkManager sharedInstance] airSetMode:CENTRAL_MODE_LOW_SPEED withID:infoID];
    self.view2.hidden=YES;
}

- (IBAction)view_2_choose_3:(id)sender {
    [self.view_2_radio_5 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view_2_radio_4 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view_2_radio_3 setImage:[UIImage imageNamed:@"radio_checked"]];
    [self.view_2_radio_2 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view_2_radio_1 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    
    int infoID=strtoul([[self.device.devId substringWithRange:NSMakeRange(0, self.device.devId.length)] UTF8String],0,16);
    [[NetWorkManager sharedInstance] airSetMode:CENTRAL_MODE_HIGH_SPEED withID:infoID];
    self.view2.hidden=YES;
}
- (IBAction)view_2_choose_2:(id)sender {
    [self.view_2_radio_5 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view_2_radio_4 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view_2_radio_3 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view_2_radio_2 setImage:[UIImage imageNamed:@"radio_checked"]];
    [self.view_2_radio_1 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    
    int infoID=strtoul([[self.device.devId substringWithRange:NSMakeRange(0, self.device.devId.length)] UTF8String],0,16);
    [[NetWorkManager sharedInstance] airSetMode:CENTRAL_MODE_MID_SPEED withID:infoID];
    self.view2.hidden=YES;
}
- (IBAction)view_2_choose_1:(id)sender {
    [self.view_2_radio_5 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view_2_radio_4 setImage:[UIImage imageNamed:@"radio_checked"]];
    [self.view_2_radio_3 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view_2_radio_2 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view_2_radio_1 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    
    int infoID=strtoul([[self.device.devId substringWithRange:NSMakeRange(0, self.device.devId.length)] UTF8String],0,16);
    [[NetWorkManager sharedInstance] airSetMode:CENTRAL_MODE_MANUAL withID:infoID];
    self.view2.hidden=YES;
    
}


- (IBAction)neWindAction:(id)sender {
    
    ScreenViewController *vc=[[ScreenViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)heatAction:(id)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if (self.device!=nil) {
            
            int infoID=strtoul([[self.device.devId substringWithRange:NSMakeRange(0, self.device.devId.length)] UTF8String],0,16);
            if(self.device.devInfo.heat){
                
                [[NetWorkManager sharedInstance] airCloseHeat:infoID];
                
            }else{
                if (self.device!=nil) {
                    [[NetWorkManager sharedInstance] airOpenHeat:infoID];
                }
            }
        }
        
    });
    
}

- (IBAction)paiwuAction:(id)sender {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if (self.device!=nil) {
            
            int infoID=strtoul([[self.device.devId substringWithRange:NSMakeRange(0, self.device.devId.length)] UTF8String],0,16);
            if (self.device.devInfo!=nil) {
                if(self.device.devInfo.windOut){
                    [[NetWorkManager sharedInstance] airCloseWindOut:infoID];
                }else{
                    
                    [[NetWorkManager sharedInstance] airOpenWindOut:infoID];
                }
            }
        }
        
    });
    
}
- (IBAction)jingqiAction:(id)sender {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if (self.device!=nil) {
            int infoID=strtoul([[self.device.devId substringWithRange:NSMakeRange(0, self.device.devId.length)] UTF8String],0,16);
            if(self.device.devInfo.windIn){
                [[NetWorkManager sharedInstance] airCloseWindIn:infoID];
                
            }else{
                
                [[NetWorkManager sharedInstance] airOpenWindIn:infoID];
            }
        }
        
    });
}
- (IBAction)fuyangAction:(id)sender {
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if (self.device!=nil) {
            
            int infoID=strtoul([[self.device.devId substringWithRange:NSMakeRange(0, self.device.devId.length)] UTF8String],0,16);
            if(self.device.devInfo.o1){
                [[NetWorkManager sharedInstance] airCloseO1:infoID];
            }else{
                
                [[NetWorkManager sharedInstance] airOpenO1:infoID];
                
            }
        }
        
    });
}


- (IBAction)yiJunAction:(id)sender {
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if (self.device!=nil) {
            
            int infoID=strtoul([[self.device.devId substringWithRange:NSMakeRange(0, self.device.devId.length)] UTF8String],0,16);
            if(self.device.devInfo.uv){
                [[NetWorkManager sharedInstance] airCloseUV:infoID];
            }else{
                
                [[NetWorkManager sharedInstance] airOpenUV:infoID];
                
            }
        }
        
    });
}

- (IBAction)quWeiAction:(id)sender {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        if (self.device!=nil) {
            
            int infoID=strtoul([[self.device.devId substringWithRange:NSMakeRange(0, self.device.devId.length)] UTF8String],0,16);
            if(self.device.devInfo.uv){
                [[NetWorkManager sharedInstance] airCloseO3:infoID];
            }else{
                
                [[NetWorkManager sharedInstance] airOpenO3:infoID];
                
            }
        }
        
    });
}









- (IBAction)leverNoneAction:(id)sender {
}
- (IBAction)leverLowAction:(id)sender {
    [self.leverImg setImage:[UIImage imageNamed:@"center_speed_low"]];
}
- (IBAction)leverHighAction:(id)sender {
    [self.leverImg setImage:[UIImage imageNamed:@"center_speed_high"]];
}
- (IBAction)leverMidAction:(id)sender {
    [self.leverImg setImage:[UIImage imageNamed:@"center_speed_mid"]];
}



-(void)ReflushUI{
    NSLog(@">>>>>>>>>>>>>>>>>>>>>ReflushUI<<<<<<<<<<<<<<<<<<<");
    //    DeviceInfo *info=[NetWorkManager sharedInstance].deviceInfo;
    DeviceInfo *info=self.device.devInfo;
    if (info!=nil) {
        
        
        
        if(info.air < 2)
        {
            
            [self.airMainLever setImage:[UIImage imageNamed:@"center_state_icon_good"]];
        }
        else if(info.air < 4)
        {
            [self.airMainLever setImage:[UIImage imageNamed:@"center_state_icon_fresh"]];
        }
        else if(info.air < 8)
        {
            [self.airMainLever setImage:[UIImage imageNamed:@"center_state_icon_fresh"]];
        }
        else
        {
            [self.airMainLever setImage:[UIImage imageNamed:@"center_state_icon_bad"]];
        }
        
        
        switch(info.workMode)
        {
            case CENTRAL_MODE_LOW_SPEED:
                
                self.runTime.text=@"低速模式";
                
                [self.view_2_radio_5 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                [self.view_2_radio_4 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                [self.view_2_radio_3 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                [self.view_2_radio_2 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                [self.view_2_radio_1 setImage:[UIImage imageNamed:@"radio_checked"]];
                
                
                break;
            case CENTRAL_MODE_MID_SPEED:
                
                self.runTime.text=@"中速模式";
                
                
                [self.view_2_radio_5 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                [self.view_2_radio_4 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                [self.view_2_radio_3 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                [self.view_2_radio_2 setImage:[UIImage imageNamed:@"radio_checked"]];
                [self.view_2_radio_1 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                break;
            case CENTRAL_MODE_HIGH_SPEED:
                
                self.runTime.text=@"高速模式";
                [self.view_2_radio_5 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                [self.view_2_radio_4 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                [self.view_2_radio_3 setImage:[UIImage imageNamed:@"radio_checked"]];
                [self.view_2_radio_2 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                [self.view_2_radio_1 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                
                
                break;
                
            default:
            case CENTRAL_MODE_MANUAL:
                
                self.runTime.text=@"无极模式";
                [self.view_2_radio_5 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                [self.view_2_radio_4 setImage:[UIImage imageNamed:@"radio_checked"]];
                [self.view_2_radio_3 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                [self.view_2_radio_2 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                [self.view_2_radio_1 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                break;
                
            case CENTRAL_MODE_AUTO:
                
                self.runTime.text=@"智能模式";
                [self.view_2_radio_5 setImage:[UIImage imageNamed:@"radio_checked"]];
                [self.view_2_radio_4 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                [self.view_2_radio_3 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                [self.view_2_radio_2 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                [self.view_2_radio_1 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                
                break;
                
                
                
                
        }
        
        
        
        if (info.sysTimeMin<10) {
            self.curTime.text=[NSString stringWithFormat:@"设备时间:%d:%@",info.sysTimeHour,[NSString stringWithFormat:@"0%d",info.sysTimeMin]];
        }else{
            self.curTime.text=[NSString stringWithFormat:@"设备时间:%d:%d",info.sysTimeHour,info.sysTimeMin];
        }
        
        if (info.timerStartMin<10) {
            self.timerTime.text=[NSString stringWithFormat:@"定时开机：%d:%@",info.timerStartHour,[NSString stringWithFormat:@"0%d",info.timerStartMin]];
        }else{
            self.timerTime.text=[NSString stringWithFormat:@"定时开机：%d:%d",info.timerStartHour,info.timerStartMin];
        }
        if (info.timerEndMin<10) {
            self.timerTimeEnd.text=[NSString stringWithFormat:@"定时关机：%d:%@",info.timerEndHour,[NSString stringWithFormat:@"0%d",info.timerEndMin]];
        }else{
            self.timerTimeEnd.text=[NSString stringWithFormat:@"定时关机：%d:%d",info.timerEndHour,info.timerEndMin];
        }
        
        
        if (info.windIn) {
            [self.windNew setBackgroundImage:[UIImage imageNamed:@"state_wind_in_high"] forState:UIControlStateNormal];
        }else{
            [self.windNew setBackgroundImage:[UIImage imageNamed:@"state_wind_in"] forState:UIControlStateNormal];
        }
        
        
        if (info.windOut) {
            [self.paiFeng setBackgroundImage:[UIImage imageNamed:@"state_wind_out_high"] forState:UIControlStateNormal];
        }else{
            [self.paiFeng setBackgroundImage:[UIImage imageNamed:@"state_wind_out"] forState:UIControlStateNormal];
        }
        
        if (info.heat) {
            [self.fuRe setBackgroundImage:[UIImage imageNamed:@"state_heat_high"] forState:UIControlStateNormal];
        }else{
            [self.fuRe setBackgroundImage:[UIImage imageNamed:@"state_heat"] forState:UIControlStateNormal];
        }
        
        
        if (info.o1) {
            [self.fuYang setBackgroundImage:[UIImage imageNamed:@"state_o1_high"] forState:UIControlStateNormal];
        }else{
            [self.fuYang setBackgroundImage:[UIImage imageNamed:@"state_o1"] forState:UIControlStateNormal];
        }
        
        
        if (info.uv) {
            [self.yiJun setBackgroundImage:[UIImage imageNamed:@"state_wind_in_high"] forState:UIControlStateNormal];
        }else{
            [self.yiJun setBackgroundImage:[UIImage imageNamed:@"state_wind_in"] forState:UIControlStateNormal];
        }
        
        if (info.o3) {
            [self.quWei setBackgroundImage:[UIImage imageNamed:@"state_wind_out_high"] forState:UIControlStateNormal];
        }else{
            [self.quWei setBackgroundImage:[UIImage imageNamed:@"state_wind_out"] forState:UIControlStateNormal];
        }
        
        if(!info.windIn)
        {
            self.wind_in.text=@"新风 0";
        }
        else
        {
            self.wind_in.text=[NSString stringWithFormat:@"新风 %d",info.windInLevel];
        }
        
        if(!info.windOut)
        {
            self.wind_out.text=@"排风 0";
        }
        else
        {
            self.wind_out.text=[NSString stringWithFormat:@"排风 %d",info.windOutLevel];
        }
        
        
        NSLog(@">>>>>>>>>>>>>>info.workMode=%d",info.workMode);
        
        if (info.workMode==0) {
            NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>关机<<<<<<<<<<<<<<<<<<<<<<<<<<<");
        }else{
            NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>开机<<<<<<<<<<<<<<<<<<<<<<<<<<<");
        }
        self.pmLabel.text=[NSString stringWithFormat:@"%d",info.pm25];
        self.co2Label.text=[NSString stringWithFormat:@"%d",info.co2];
        self.tvosLabel.text=[NSString stringWithFormat:@"%.2f",info.tvoc];
        self.formLabel.text=[NSString stringWithFormat:@"%.2f",info.hcoh];
        NSLog(@"*************************************info.indoorTemp=%d",info.indoorTemp);
        NSLog(@"*************************************info.indoorHumi=%d",info.indoorHumi);
        NSLog(@"*************************************info.outdoorTemp=%d",info.outdoorTemp);
        NSLog(@"*************************************info.outdoorHumi=%d",info.outdoorHumi);
        
        self.tempLabel.text=[NSString stringWithFormat:@"%d°C",info.outdoorTemp];
        self.humLabel.text=[NSString stringWithFormat:@"%d％",info.outdoorHumi];
        NSLog(@"*************************************deviceType=%d",info.deviceType);
    }
    
}

@end
