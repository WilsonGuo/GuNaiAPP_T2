//
//  SmartDeviceUtils.h
//  SmartDeivceManager
//
//  Created by Wilson.Guo on 15/5/8.
//  Copyright (c) 2015年 Wilson.Guo. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <sys/types.h>
#include <sys/sysctl.h>
#import "GNDevice.h"
@interface SmartDeviceUtils : NSObject

@property(nonatomic,strong) NSMutableArray *timerData;
@property(nonatomic,strong) NSMutableArray *countDownTimerData;



+ (SmartDeviceUtils *)sharedInstance;

-(void)addGNDevice:(GNDevice *)dev;
-(void)addGNDeviceNew:(GNDevice *)dev;
-(NSMutableArray *)getGNDevices;
-(NSMutableArray *)getNewGNDevices;
-(void)clearGNDevice;
-(void)clearGNDeviceNew;
-(NSString *)getCurrentLanguage;
//获取SSID
- (NSString *) getDeviceSSID;
//获取智能设备集合
-(NSMutableArray *)getDevices;
//获取需要添加的智能设备
-(NSMutableArray *)getAddDevices;
//获取设备类型
-(NSMutableArray *)getTypeDevices;

//获取控制器设备类型集合
-(NSMutableArray *)getControllerDevices;
//获取开关集合
-(NSMutableArray *)getButtons;

//获取定时器集合
-(NSMutableArray *)getTimers;
//获取倒计时器集合
-(NSMutableArray *)getCountDownTimers;

//判断手机型号
- (NSString*) doDevicePlatform;
//判断邮箱格式
-(BOOL)isValidateEmail:(NSString *)email;
//是否是完整的数据包
-(NSMutableArray *)isCompleteWithString:(NSString *) string;
@end
