//
//  CMD.h
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/3/27.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#ifndef CMD_h
#define CMD_h


#endif /* CMD_h */


#define TYPE_T1 2
#define TYPE_T2 0
#define TYPE_CENTER 1

#define MODE_SHUTDOWN 0
#define MODE_MANUAL 1
#define MODE_AUTO 4
#define MODE_WINTER 2
#define MODE_FIX 3

#define T1_MODE_SHUTDOWN 0
#define T1_MODE_MANUAL 1
#define T1_MODE_CIRCLE 2
#define T1_MODE_AUTO 3

#define CENTRAL_MODE_SHUTDOWN 0
#define CENTRAL_MODE_LOW_SPEED 1
#define CENTRAL_MODE_MID_SPEED 2
#define CENTRAL_MODE_HIGH_SPEED 3
#define CENTRAL_MODE_MANUAL 4
#define CENTRAL_MODE_AUTO 5


#define SENSOR_STATE_MASK_O1 0x01
#define SENSOR_STATE_MASK_HEAT 0x02
#define SENSOR_STATE_MASK_WIND_IN 0x04
#define SENSOR_STATE_MASK_TIMER 0x08
#define SENSOR_STATE_MASK_WIND_OUT 0x10
#define SENSOR_STATE_MASK_UV 0x40
#define SENSOR_STATE_MASK_O3 0x20


#define STATE_DATA_INDEX_CMD 0
#define STATE_DATA_INDEX_INDOOR_TEMP 1
#define STATE_DATA_INDEX_INDOOR_HUMI 2
#define STATE_DATA_INDEX_OUTDOOR_TEMP 3
#define STATE_DATA_INDEX_OUTDOOR_HUMI 4
#define STATE_DATA_INDEX_FIX_HUMI 5
#define STATE_DATA_INDEX_WIFI_REQ 6
#define STATE_DATA_INDEX_AIR_STATE 7
#define STATE_DATA_INDEX_WORK_MODE 8
#define STATE_DATA_INDEX_WIND_IN 9
#define STATE_DATA_INDEX_WIND_OUT 10
#define STATE_DATA_INDEX_DEVICE_TYPE 11
#define STATE_DATA_INDEX_FUNC_SET 12
#define STATE_DATA_INDEX_SYSTEM_TIME 13
#define STATE_DATA_INDEX_TIMER_START 15
#define STATE_DATA_INDEX_TIMER_END 17
#define STATE_DATA_INDEX_FILTER_TIME 19


#define STATE_DATA_INDEX_PM25 21
#define STATE_DATA_INDEX_TVOC 23
#define STATE_DATA_INDEX_CO2 25
#define STATE_DATA_INDEX_HCOH 27
#define STATE_DATA_INDEX_AUTO_SENSOR 28


#define CMD_A2M_QUERY_STATE 0x01
#define CMD_A2M_SET_WIND_IN 0x02
#define CMD_A2M_SET_WIND_OUT 0x03
#define CMD_A2M_SET_TIMER 0x04
#define CMD_A2M_SET_WORK_MODE 0x05
#define CMD_A2M_SET_HEAT 0x06
#define CMD_A2M_SET1_O1 0x07


#define CMD_A2M_SET1_HUMI 0x09
#define CMD_A2M_SET1_UV 0x0A
#define CMD_A2M_SET1_O3 0x0B
#define CMD_A2M_SET1_AUTO_SENSOR 0x0C

#define CONTROL_PACKERT_OUT_SIZE 10
