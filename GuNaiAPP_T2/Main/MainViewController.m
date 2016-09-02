//
//  MainViewController.m
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/1/18.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import "MainViewController.h"
#import "SetViewController.h"
#import "RegisterViewController.h"
#import "user_interface.h"
#import "AppDelegate.h"
#import "NetWorkManager.h"
#import "CMD.h"
#import "OpenViewController.h"
#import "ScreenViewController.h"
#import "SmartDeviceUtils.h"
@interface MainViewController(){
    Byte startTime;
    Byte startMin;
    Byte endTime;
    Byte endMin;
    
    int slider_1_value;
    int slider_2_value;
    
    bool isShow;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isShow=false;
    [self.slider3 setThumbImage: [UIImage imageNamed:@"wind_seekbar_thumb"] forState:UIControlStateNormal];
    self.slider3.transform =  CGAffineTransformMakeRotation( M_PI * 1.5 );
    
    [self.slider3 addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];//添加滑动事件
    
    [self.view_1_progress_1 addTarget:self action:@selector(windSliderValueChanged:) forControlEvents:UIControlEventValueChanged];//添加滑动事件
    [self.view_1_progress_2 addTarget:self action:@selector(windSliderValueChanged:) forControlEvents:UIControlEventValueChanged];//添加滑动事件
    
    
    [self.timePicker1 addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    
    
    [self.timePicker2 addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getData:)
                                                 name:NOTICE_MAIN_MSG_TYPE_DATA object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(netWorkUp:)
                                                 name:NOTICE_MAIN_MSG_TYPE_NETWORK_UP object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(netWorkDown:)
                                                 name:NOTICE_MAIN_MSG_TYPE_NETWORK_DOWN object:nil];
    
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
    
    CABasicAnimation* rotationAnimation1;
    rotationAnimation1 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation1.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation1.duration = 4;
    rotationAnimation1.cumulative = YES;
    rotationAnimation1.repeatCount = HUGE_VALF;
    
    [self.circleView.layer addAnimation:rotationAnimation1 forKey:@"rotationAnimation1"];
    //self.device=[NetWorkManager sharedInstance].devInfo;
    
    
    NSString *launge=[[SmartDeviceUtils sharedInstance] getCurrentLanguage];
    if([launge isEqual:PHONE_LAUNGE]){//台湾
        //区分T1设备与T2设备
        if (self.device.devInfo.deviceType==DEVICE_TYPE_T1) {
            self.titleView.text=DEVICE_NAME_S1_TAIWAN;
            self.middleView.hidden=YES;
        }else if(self.device.devInfo.deviceType==DEVICE_TYPE_T2){
            self.titleView.text=DEVICE_NAME_S2_TAIWAN;
            self.middleView.hidden=NO;
        }
    }else{
        //区分T1设备与T2设备
        if (self.device.devInfo.deviceType==DEVICE_TYPE_T1) {
            self.titleView.text=DEVICE_NAME_S1;
            self.middleView.hidden=YES;
        }else if(self.device.devInfo.deviceType==DEVICE_TYPE_T2){
            self.titleView.text=DEVICE_NAME_S2;
            self.middleView.hidden=NO;
        }
    }
    
    
    
    
    
    DeviceInfo *info=[NetWorkManager sharedInstance].deviceInfo;
    
    if([[NSString stringWithFormat:@"%x", info.sn] isEqual:self.device.devId]){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self ReflushUI:info];
            
        });
    }
    
}
//注销广播接收
- (void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)hideAction:(id)sender {
    self.sliderLayoutView3.hidden=YES;
}

-(void)getData:(NSNotification *)notification{
    
    DeviceInfo *info=[NetWorkManager sharedInstance].deviceInfo;
    
    if([[NSString stringWithFormat:@"%x", info.sn] isEqual:self.device.devId]){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self ReflushUI:info];
            
        });
    }
    
}
-(void)netWorkUp:(NSNotification *)notification{
    
}
-(void)netWorkDown:(NSNotification *)notification{
    
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
- (IBAction)backAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)switchAction:(id)sender {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        int devID=strtoul([[self.device.devId substringWithRange:NSMakeRange(0, self.device.devId.length)] UTF8String],0,16);
        
        int result=[[NetWorkManager sharedInstance] airClose:devID];
        NSLog(@"airClose>>>>>>>>>>>>result＝%d",result);
        
    });
    
}

//添加滑动事件
-(void)sliderValueChanged:(UISlider *)paramSender{
    int value=(int)paramSender.value;
    if ([paramSender isEqual:self.slider3]){
        NSLog(@"slider3 value=%f",paramSender.value);
        DeviceInfo *info=self.device.devInfo;
        [self.slider3_lable setText:[NSString stringWithFormat:@"%d",(value+20)]];
        
        int infoID=strtoul([[self.device.devId substringWithRange:NSMakeRange(0, self.device.devId.length)] UTF8String],0,16);
        [[NetWorkManager sharedInstance] airSetHumi:(value+20) withID:infoID];
    }
}

//添加滑动事件
-(void)windSliderValueChanged:(UISlider *)paramSender{
    int value=(int)paramSender.value;
    if ([paramSender isEqual:self.view_1_progress_1]){
        NSLog(@"view_1_progress_1 value=%f",paramSender.value);
        self.view_1_label_2.text=[NSString stringWithFormat:@"排污：%d",value];
        slider_1_value=value;
        
    }else if([paramSender isEqual:self.view_1_progress_2]){
        
        NSLog(@"view_1_progress_2 value=%f",paramSender.value);
        self.view_1_label_1.text=[NSString stringWithFormat:@"淨氣：%d",value];
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
    self.view_1_label_1.text=[NSString stringWithFormat:@"淨氣：%d",self.device.devInfo.windInLevel];;
    self.view_1_label_2.text=[NSString stringWithFormat:@"排污：%d",self.device.devInfo.windOutLevel];
    
    [self.view_1_progress_2 setValue:self.device.devInfo.windInLevel];
    [self.view_1_progress_1 setValue:self.device.devInfo.windOutLevel];
    
}

- (IBAction)bottomRightAction:(id)sender {
    
    //区分T1设备与T2设备
    if (self.device.devInfo.deviceType==DEVICE_TYPE_T1) {
        self.view3.hidden=NO;
    }else if(self.device.devInfo.deviceType==DEVICE_TYPE_T2){
        self.view2.hidden=NO;
    }
    
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
- (IBAction)hideView3:(id)sender {
    
    self.view3.hidden=YES;
}

- (IBAction)view_2_choose_4:(id)sender {
    
    
    
    [self.view_2_radio_4 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view_2_radio_3 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view_2_radio_2 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view_2_radio_1 setImage:[UIImage imageNamed:@"radio_checked"]];
    
    int infoID=strtoul([[self.device.devId substringWithRange:NSMakeRange(0, self.device.devId.length)] UTF8String],0,16);
    [[NetWorkManager sharedInstance] airSetMode:MODE_MANUAL withID:infoID];
    self.view2.hidden=YES;
}

- (IBAction)view_2_choose_3:(id)sender {
    
    [self.view_2_radio_4 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view_2_radio_3 setImage:[UIImage imageNamed:@"radio_checked"]];
    [self.view_2_radio_2 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view_2_radio_1 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    
    int infoID=strtoul([[self.device.devId substringWithRange:NSMakeRange(0, self.device.devId.length)] UTF8String],0,16);
    [[NetWorkManager sharedInstance] airSetMode:MODE_FIX withID:infoID];
    self.view2.hidden=YES;
}
- (IBAction)view_2_choose_2:(id)sender {
    
    [self.view_2_radio_4 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view_2_radio_3 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view_2_radio_2 setImage:[UIImage imageNamed:@"radio_checked"]];
    [self.view_2_radio_1 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    
    int infoID=strtoul([[self.device.devId substringWithRange:NSMakeRange(0, self.device.devId.length)] UTF8String],0,16);
    [[NetWorkManager sharedInstance] airSetMode:MODE_WINTER withID:infoID];
    self.view2.hidden=YES;
}
- (IBAction)view_2_choose_1:(id)sender {
    [self.view_2_radio_4 setImage:[UIImage imageNamed:@"radio_checked"]];
    [self.view_2_radio_3 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view_2_radio_2 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view_2_radio_1 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    
    int infoID=strtoul([[self.device.devId substringWithRange:NSMakeRange(0, self.device.devId.length)] UTF8String],0,16);
    [[NetWorkManager sharedInstance] airSetMode:MODE_AUTO withID:infoID];
    self.view2.hidden=YES;
    
}
- (IBAction)view_3_choose_1:(id)sender {
    
    
    
    [self.view3_radio_3 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view3_radio_2 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view3_radio_1 setImage:[UIImage imageNamed:@"radio_checked"]];
    
    int infoID=strtoul([[self.device.devId substringWithRange:NSMakeRange(0, self.device.devId.length)] UTF8String],0,16);
    [[NetWorkManager sharedInstance] airSetMode:T1_MODE_MANUAL withID:infoID];
    self.view3.hidden=YES;
}
- (IBAction)view_3_choose_2:(id)sender {
    
    [self.view3_radio_3 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view3_radio_2 setImage:[UIImage imageNamed:@"radio_checked"]];
    [self.view3_radio_1 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    
    int infoID=strtoul([[self.device.devId substringWithRange:NSMakeRange(0, self.device.devId.length)] UTF8String],0,16);
    [[NetWorkManager sharedInstance] airSetMode:T1_MODE_CIRCLE withID:infoID];
    self.view3.hidden=YES;
}

- (IBAction)view_3_choose_3:(id)sender {
    
    [self.view3_radio_3 setImage:[UIImage imageNamed:@"radio_checked"]];
    [self.view3_radio_2 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    [self.view3_radio_1 setImage:[UIImage imageNamed:@"radio_unchecked"]];
    
    int infoID=strtoul([[self.device.devId substringWithRange:NSMakeRange(0, self.device.devId.length)] UTF8String],0,16);
    [[NetWorkManager sharedInstance] airSetMode:T1_MODE_AUTO withID:infoID];
    self.view3.hidden=YES;
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

- (IBAction)clearWindAction:(id)sender {
    if (self.sliderLayoutView3.isHidden) {
        self.sliderLayoutView3.hidden=NO;
        DeviceInfo *info=self.device.devInfo;
        self.slider3_lable.text=[NSString stringWithFormat:@"%d",info.fixHumi] ;
        
        
    }else{
        self.sliderLayoutView3.hidden=YES;
    }
}


-(void)ReflushUI:(DeviceInfo *) info{
    NSLog(@">>>>>>>>>>>>>>>>>>>>>ReflushUI<<<<<<<<<<<<<<<<<<<");
    
    if (info!=nil) {
        
        self.leverNum.text=[NSString stringWithFormat:@"%d",info.air];
        
        if(info.air < 2)
        {
            self.runState.text=@"優";
            
        }
        else if(info.air < 4)
        {
            self.runState.text=@"良";
        }
        else if(info.air < 8)
        {
            self.runState.text=@"中";
            
        }
        else
        {
            self.runState.text=@"差";
            
        }
        
        
        //区分T1设备与T2设备
        if (self.device.devInfo.deviceType==DEVICE_TYPE_T1) {
            switch(info.workMode)
            {
                case T1_MODE_AUTO:
                    
                    self.runTime.text=@"智慧模式";
                    
                    
                    [self.view3_radio_3 setImage:[UIImage imageNamed:@"radio_checked"]];
                    [self.view3_radio_2 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                    [self.view3_radio_1 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                    
                    break;
                case T1_MODE_CIRCLE:
                    
                    self.runTime.text=@"迴圈模式";
                    
                    
                    [self.view3_radio_3 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                    [self.view3_radio_2 setImage:[UIImage imageNamed:@"radio_checked"]];
                    [self.view3_radio_1 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                    break;
                case T1_MODE_MANUAL:
                    
                    self.runTime.text=@"手動模式";
                    
                    [self.view3_radio_3 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                    [self.view3_radio_2 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                    [self.view3_radio_1 setImage:[UIImage imageNamed:@"radio_checked"]];
                    
                    
                    break;
                case T1_MODE_SHUTDOWN:
                    if([NetWorkManager sharedInstance].isShowDown==false){
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            OpenViewController *vc=[[OpenViewController alloc]init];
                            vc.device=self.device;
                            
                            [self.navigationController pushViewController:vc animated:YES];
                            
                        });
                    }
                    
                    break;
                    
                    
                    
            }
            
        }else if(self.device.devInfo.deviceType==DEVICE_TYPE_T2){
            switch(info.workMode)
            {
                case MODE_AUTO:
                    
                    self.runTime.text=@"智慧模式";
                    
                    
                    [self.view_2_radio_4 setImage:[UIImage imageNamed:@"radio_checked"]];
                    [self.view_2_radio_3 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                    [self.view_2_radio_2 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                    [self.view_2_radio_1 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                    
                    break;
                case MODE_WINTER:
                    
                    self.runTime.text=@"冬天模式";
                    
                    
                    [self.view_2_radio_4 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                    [self.view_2_radio_3 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                    [self.view_2_radio_2 setImage:[UIImage imageNamed:@"radio_checked"]];
                    [self.view_2_radio_1 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                    break;
                case MODE_FIX:
                    
                    self.runTime.text=@"恒濕模式";
                    [self.view_2_radio_4 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                    [self.view_2_radio_3 setImage:[UIImage imageNamed:@"radio_checked"]];
                    [self.view_2_radio_2 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                    [self.view_2_radio_1 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                    
                    break;
                    
                    
                case MODE_MANUAL:
                    
                    self.runTime.text=@"連續模式";
                    [self.view_2_radio_4 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                    [self.view_2_radio_3 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                    [self.view_2_radio_2 setImage:[UIImage imageNamed:@"radio_unchecked"]];
                    [self.view_2_radio_1 setImage:[UIImage imageNamed:@"radio_checked"]];
                    
                    break;
                    
                case MODE_SHUTDOWN:
                    if([NetWorkManager sharedInstance].isShowDown==false){
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            OpenViewController *vc=[[OpenViewController alloc]init];
                            vc.device=self.device;
                            [self.navigationController pushViewController:vc animated:YES];
                            
                        });
                    }
                    
                    break;
                    
                    
                    
            }
            
        }
        
        
        self.indoorHuim.text=[NSString stringWithFormat:@"%d%%",info.indoorHumi];
        self.outdoorHuim.text=[NSString stringWithFormat:@"%d%%",info.outdoorHumi];
        self.indoorTemp.text=[NSString stringWithFormat:@"%d℃",info.indoorTemp];
        self.outdoorTemp.text=[NSString stringWithFormat:@"%d℃",info.outdoorTemp];
        
        [self.hengShiBtn setTitle:[NSString stringWithFormat:@"恒濕:%d%%",info.fixHumi] forState:UIControlStateNormal];
        
        if (info.sysTimeMin<10) {
            self.curTime.text=[NSString stringWithFormat:@"設備時間:%d:%@",info.sysTimeHour,[NSString stringWithFormat:@"0%d",info.sysTimeMin]];
        }else{
            self.curTime.text=[NSString stringWithFormat:@"設備時間:%d:%d",info.sysTimeHour,info.sysTimeMin];
        }
        
        if (info.timerStartMin<10) {
            self.timerTime.text=[NSString stringWithFormat:@"定時開機：%d:%@",info.timerStartHour,[NSString stringWithFormat:@"0%d",info.timerStartMin]];
        }else{
            self.timerTime.text=[NSString stringWithFormat:@"定時開機：%d:%d",info.timerStartHour,info.timerStartMin];
        }
        if (info.timerEndMin<10) {
            self.timerTimeEnd.text=[NSString stringWithFormat:@"定時關機：%d:%@",info.timerEndHour,[NSString stringWithFormat:@"0%d",info.timerEndMin]];
        }else{
            self.timerTimeEnd.text=[NSString stringWithFormat:@"定時關機：%d:%d",info.timerEndHour,info.timerEndMin];
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
        
        if(!info.windIn)
        {
            self.windIn.text=@"淨氣 0";
        }
        else
        {
            self.windIn.text=[NSString stringWithFormat:@"淨氣 %d",info.windInLevel];
        }
        
        if(!info.windOut)
        {
            self.windOut.text=@"排風 0";
        }
        else
        {
            self.windOut.text=[NSString stringWithFormat:@"排風 %d",info.windOutLevel];
        }
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
