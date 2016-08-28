//
//  NetWorkManager.h
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/3/27.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceInfo.h"
#import "GNDevice.h"
#import "user_interface.h"
@interface NetWorkManager : NSObject
@property (retain,nonatomic) GNDevice* devInfo;
@property (retain,nonatomic)  DeviceInfo *deviceInfo;
@property (retain,nonatomic) NSMutableArray *devices;
@property (assign,nonatomic) boolean isShowDown;

+ (NetWorkManager *)sharedInstance;


-(int) airClose:(int) devId;
-(int) airOpen:(int) devId;

-(int)airQueryState:(int )devId;

-(int)airSetTimer:(Byte) startHour withStartMin: (Byte) startMin withEndHour:(Byte) endHour withEndMin:(Byte) endMin withID:(int) devId;

-(int)airSetMode:(int) mode withID:(int) devId;
-(int)airSetWindInLevel:(Byte) level withID:(int) devId;
-(int)airSetWindOutLevel:(Byte) level withID: (int) devId;
-(int)airSetHumi:(Byte) level withID: (int) devId;
-(int)airSetAutoSensor:(int)sensorIndex WithID:(int) devId;

-(int)airOpenO1:(int )devId;
-(int)airCloseO1:(int )devId;
-(int)airOpenO3:(int) devId;
-(int)airCloseO3:(int) devId;
-(int)airCloseWindIn:(int) devId;
-(int)airOpenWindIn:(int) devId;
-(int)airCloseWindOut:(int) devId;
-(int)airOpenWindOut:(int) devId;
-(int)airOpenHeat:(int) devId;
-(int)airCloseHeat:(int) devId;
-(int)airOpenUV:(int) devId;
-(int)airCloseUV:(int) devId;


-(DeviceInfo *) parseInfo:(int) devId andData:(Byte *)stateData;




@end
