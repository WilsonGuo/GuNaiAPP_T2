//
//  AppDelegate.h
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/1/18.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "GNDevice.h"
#define DEVICE_NAME_DEFAULT @"古耐智能设备"
#define DEVICE_NAME_S1 @"S1壁挂新风系统"
#define DEVICE_NAME_S2 @"S2壁挂新风系统"
#define DEVICE_NAME_CENTER @"中央新风系统"

#define DEVICE_NAME_DEFAULT_TAIWAN @"古耐智慧設備"
#define DEVICE_NAME_S1_TAIWAN @"S1壁掛新風系統"
#define DEVICE_NAME_S2_TAIWAN @"S2壁掛新風系統"
#define DEVICE_NAME_CENTER_TAIWAN @"中央新風系統"
#define PHONE_LAUNGE @"zh-Hant"

#define DEV_ID @"devID"
#define BUFF @"buff"


#define NOTICE_MAIN_MSG_TYPE_GET_APP_SN @"MAIN_MSG_TYPE_GET_APP_SN"
#define NOTICE_MAIN_MSG_TYPE_DATA @"MAIN_MSG_TYPE_DATA"
#define NOTICE_MAIN_MSG_TYPE_NETWORK_UP @"MAIN_MSG_TYPE_NETWORK_UP"
#define NOTICE_MAIN_MSG_TYPE_NETWORK_DOWN @"MAIN_MSG_TYPE_NETWORK_DOWN"
#define NOTICE_MAIN_MSG_TYPE_FIND_NEW_WIFI_DEV @"MAIN_MSG_TYPE_FIND_NEW_WIFI_DEV"
#define NOTICE_MAIN_MSG_TYPE_DEL_WIFI_DEV_SUCCESS @"MAIN_MSG_TYPE_DEL_WIFI_DEV_SUCCESS"
#define NOTICE_MAIN_MSG_TYPE_SET_WIFI_PASSWORD_SUCCESS @"MAIN_MSG_TYPE_SET_WIFI_PASSWORD_SUCCESS"


#define STATUS_ON 1
#define STATUS_OFF 0


#define CMD_CUR_TYPE_NONE 0
#define CMD_CUR_TYPE_QUARY_DEVICE_INFO 30
#define CMD_CUR_TYPE_TURN_OFF 40
#define CMD_CUR_TYPE_TURN_ON 50

#define UI_CMD_RESULT_QUARY_DEVICE_INFO_SUCCESS @"UI_CMD_RESULT_QUARY_DEVICE_INFO_SUCCESS"
#define UI_CMD_RESULT_STATUS_TURN_OFF @"UI_CMD_RESULT_STATUS_TURN_OFF"
#define UI_CMD_RESULT_STATUS_TURN_ON @"UI_CMD_RESULT_STATUS_TURN_ON"


#define ACTION_TURN_OFF @"turn_off"
#define ACTION_TURN_ON @"turn_on"

#define DEVICE_TYPE_T1 2
#define DEVICE_TYPE_T2 0
#define DEVICE_TYPE_24G 1

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;




- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
+(int) getCurDevID;
+(void) setCurDevID:(int)devID;



+(BOOL) isTurnOFF;

+(void) setTurnOFF:(BOOL)isOff;
+(int) getCMDType;
+(void) setCMDType:(int)type;

@end

