//
//  GNDevice.h
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/3/27.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DeviceInfo.h"
@interface GNDevice : NSObject

@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *devId;
@property(nonatomic,assign)int status;
@property(nonatomic,assign)int devType;
@property(nonatomic,assign)bool isChecked;

@property(nonatomic,strong)DeviceInfo *devInfo;
@end
