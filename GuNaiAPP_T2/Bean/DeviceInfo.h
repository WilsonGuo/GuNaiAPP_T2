//
//  DeviceInfo.h
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/4/4.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceInfo : NSObject
@property(atomic,assign) int indoorTemp;
@property(atomic,assign) int indoorHumi;
@property(atomic,assign) int outdoorTemp;
@property(atomic,assign) int outdoorHumi;

@property(atomic,assign) int fixHumi;
@property(atomic,assign) int air;
@property(atomic,assign) int workMode;
@property(atomic,assign) int windInLevel;
@property(atomic,assign) int windOutLevel;
@property(atomic,assign) int deviceType;
@property(atomic,assign) int funcSet;
@property(atomic,assign) int sysTimeMin;
@property(nonatomic,assign) int sysTimeHour;
@property(nonatomic,assign) int timerStartMin;
@property(nonatomic,assign) int timerStartHour;


@property(nonatomic,assign) int timerEndMin;
@property(nonatomic,assign) int timerEndHour;
@property(nonatomic,assign) int filterTime;
@property(nonatomic,assign) int pm25;

@property(nonatomic,assign) float tvoc;
@property(nonatomic,assign) float hcoh;
@property(nonatomic,assign) int co2;
@property(nonatomic,assign) int autoSensorIndex;

@property(nonatomic,assign) Boolean o1;
@property(nonatomic,assign) Boolean heat;
@property(nonatomic,assign) Boolean windIn;
@property(nonatomic,assign) Boolean timerOn;
@property(nonatomic,assign) Boolean windOut;
@property(nonatomic,assign) Boolean o3;
@property(nonatomic,assign) Boolean uv;
@property(nonatomic,assign) int sn;

@end
