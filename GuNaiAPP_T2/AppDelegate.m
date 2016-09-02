//
//  AppDelegate.m
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/1/18.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "user_interface.h"
#import "SmartDeviceUtils.h"
#import "GNDevice.h"
#import "DevicesViewController.h"
#import "sqlService.h"
#import "DBManager.h"
#import "NetWorkManager.h"
#import "DeviceInfo.h"
@interface AppDelegate ()

@end

@implementation AppDelegate{
    
    
}

signed int SendMsgToUi(int msgType, unsigned int devID, unsigned char *buff, int len)
{
    char msgType_string[16][32]=
    {
        "Get_APP_ID",
        "RECV_DATA",
        "NETWORK_UP",
        "NETWORK_DOWN",
        "FIND_WIFI_DEV",
        "NULL",
        "ADD_WIFI_SUCCESS",
        "NULL",
        "SET_WIFI_PASSWORD_SUCCESS"
    };
    
    NSLog(@"SnendMsgToUi: sn=%u, type=%s, len=%d\n\r", devID & 0x7fffffff, msgType_string[msgType], len);
    switch (msgType) {
        case MAIN_MSG_TYPE_GET_APP_SN:
            NSLog(@"*******MAIN_MSG_TYPE_GET_APP_SN");
            NSLog(@"*******GET_APP_SN:%u",devID);
            [AppDelegate GetInitData:devID withData:buff witLength:len];
            break;
        case MAIN_MSG_TYPE_DATA:
            NSLog(@"**************************MAIN_MSG_TYPE_DATA*******************");
            [AppDelegate GetData:devID withData:buff witLength:len];
            break;
        case MAIN_MSG_TYPE_NETWORK_UP:
            NSLog(@"**************************MAIN_MSG_TYPE_NETWORK_UP*******************");
            NSLog(@"*******MAIN_MSG_TYPE_NETWORK_UP");
            [AppDelegate GetNetworkUp:devID withData:buff witLength:len];
            break;
        case MAIN_MSG_TYPE_NETWORK_DOWN:
            NSLog(@"**************************MAIN_MSG_TYPE_NETWORK_DOWN*******************");
            NSLog(@"*******MAIN_MSG_TYPE_NETWORK_DOWN");
            [AppDelegate GetNetworkDown:devID withData:buff witLength:len];
            break;
        case MAIN_MSG_TYPE_FIND_NEW_WIFI_DEV:
            NSLog(@"*******MAIN_MSG_TYPE_FIND_NEW_WIFI_DEV");
            [AppDelegate GetFindNewWifiDev:devID withData:buff witLength:len];
            
            break;
        case MAIN_MSG_TYPE_DEL_WIFI_DEV_SUCCESS:
            NSLog(@"*******MAIN_MSG_TYPE_DEL_WIFI_DEV_SUCCESS");
            [AppDelegate GetDelWifiDevSuccess:devID withData:buff witLength:len];
            break;
        case MAIN_MSG_TYPE_SET_WIFI_PASSWORD_SUCCESS:
            NSLog(@"*******MAIN_MSG_TYPE_SET_WIFI_PASSWORD_SUCCESS");
            [AppDelegate GetSetWifPasswordSuccess:devID withData:buff witLength:len];
            break;
            
            
        default:
            break;
    }
    
    
    
    return 0;
}

static int curDevID;


static bool isTurnOff;
static int cmdType;


+(int) getCurDevID{
    return curDevID;
};
+(void) setCurDevID:(int)devID{
    curDevID=devID;
}




+(BOOL) isTurnOFF{
    return isTurnOff;
};
+(void) setTurnOFF:(BOOL)isOff{
    
    isTurnOff=isOff;
    
}
+(int) getCMDType{
    return cmdType;
}
+(void) setCMDType:(int)type{
    cmdType=type;
    ;
    
}

+(void) GetInitData:(int ) devID withData:(unsigned char *)buff witLength:(int) len{
    [AppDelegate setCurDevID:devID];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_MAIN_MSG_TYPE_GET_APP_SN object:self userInfo:nil];
    Byte bytes[len+4];
    for (int i=0; i<len+4; i++) {
        bytes[i]=buff[i];
    }
    
    //保存到本地
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *devIDStr = [[NSString alloc] initWithFormat:@"%d",devID];
    [defaults setValue:devIDStr forKey:DEV_ID];
    NSData *adata = [[NSData alloc] initWithBytes:bytes length:len+4];
    [defaults setValue:adata forKey:BUFF];
    
}

+(void) GetData:(int) devID withData:(unsigned char *)buff witLength:(int) len{
    NSLog(@"*************************************查询设备信息*********************************");
    Byte bytes[len];
    for (int i=0; i<len; i++) {
        bytes[i]=buff[i];
    }
   
    DeviceInfo *deviceInfo1=[[NetWorkManager sharedInstance] parseInfo:devID andData:bytes];
    if (deviceInfo1!=nil) {
        if (deviceInfo1.workMode==0) {//关机
            NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>关机<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
            
            [[NSNotificationCenter defaultCenter] postNotificationName:UI_CMD_RESULT_STATUS_TURN_OFF object:self userInfo:[NSDictionary dictionaryWithObject:deviceInfo1 forKey:@"devID"]];
        }else{
            
            NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>开机<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<");
            [[NSNotificationCenter defaultCenter] postNotificationName:UI_CMD_RESULT_STATUS_TURN_ON object:self userInfo:[NSDictionary dictionaryWithObject:deviceInfo1 forKey:@"devID"]];
        }
    }
    
    NSString *str=[NSString stringWithFormat:@"ID:%u",devID&0x7fffffff];
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>ID=%@",str);
     NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>deviceType=%u",deviceInfo1.deviceType);
    
    
    GNDevice *device=[NetWorkManager sharedInstance].devInfo;
    if (device!=nil) {
        int infoID=strtoul([[device.devId substringWithRange:NSMakeRange(0, device.devId.length)] UTF8String],0,16);
        
        if (devID==infoID) {
            [NetWorkManager sharedInstance].deviceInfo=deviceInfo1;
            device.devInfo=deviceInfo1;
          
        }
    }
    
    [NetWorkManager sharedInstance].devices=[[sqlService sharedSqlService] getAllDevices];
    
    if ([NetWorkManager sharedInstance].devices!=nil&&[[NetWorkManager sharedInstance].devices count]>0) {
        for (int i=0; i<[[NetWorkManager sharedInstance].devices count]; i++) {
            GNDevice *info=[[NetWorkManager sharedInstance].devices objectAtIndex:i];
            int infoID=strtoul([[info.devId substringWithRange:NSMakeRange(0, info.devId.length)] UTF8String],0,16);
            
            if (devID==infoID) {
                info.devInfo=deviceInfo1;
             
                [[sqlService sharedSqlService] deleteDevInfo:info];
                [[sqlService sharedSqlService] insertDevInfo:info];
               
            }
            
            
        }
        [NetWorkManager sharedInstance].devices=[[sqlService sharedSqlService] getAllDevices];

    }
    
    switch (cmdType) {
        case CMD_CUR_TYPE_QUARY_DEVICE_INFO:
            [[NSNotificationCenter defaultCenter] postNotificationName:UI_CMD_RESULT_QUARY_DEVICE_INFO_SUCCESS object:self userInfo:nil];
            cmdType=CMD_CUR_TYPE_NONE;
            break;
        case CMD_CUR_TYPE_TURN_OFF:
            
            break;
        case CMD_CUR_TYPE_TURN_ON:
            
            break;
        case CMD_CUR_TYPE_NONE:
        default:
            break;
    }
    
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_MAIN_MSG_TYPE_DATA object:self userInfo:nil];
    
}

+(void) GetNetworkUp:(int) devID withData:(unsigned char *)buff witLength:(int) len{
    
    
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_MAIN_MSG_TYPE_NETWORK_UP object:self userInfo:nil];
}

+(void) GetNetworkDown:(int) devID withData:(unsigned char *)buff witLength:(int) len{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_MAIN_MSG_TYPE_NETWORK_DOWN object:self userInfo:nil];
    
    
}
+(void) GetFindNewWifiDev:(int) devID withData:(unsigned char *)buff witLength:(int) len{
    NSLog(@"GetFindNewWifiDev>>>>>>>>>devID=%u",devID);
    
    Byte bytes[len];
    for (int i=0; i<len; i++) {
        bytes[i]=buff[i];
        NSLog(@">>>>>>>>>>>>>>bytes[i]=%hhu",bytes[i]);
    }
    DeviceInfo *deviceInfo1=[[NetWorkManager sharedInstance] parseInfo:devID andData:bytes];
    
    
    
    GNDevice *device=[[GNDevice alloc]init];
    device.devId=[NSString stringWithFormat:@"%x",devID];
    NSLog(@"GetFindNewWifiDev>>>>>>>>>device.devId=%@",device.devId);
    
    device.name=DEVICE_NAME_DEFAULT_TAIWAN;

    [[SmartDeviceUtils sharedInstance] addGNDevice:device];
    
    if ([[sqlService sharedSqlService] getDevInfoFromDBByDevID:device.devId]==nil) {
        [[SmartDeviceUtils sharedInstance] addGNDeviceNew:device];
        NSLog(@"＊＊该设备没有添加到数据库  ID=%u",devID);
    }else{
        
        NSLog(@"＊＊该设备已经添加到数据库  ID=%u",devID);
    }
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_MAIN_MSG_TYPE_FIND_NEW_WIFI_DEV object:self userInfo:nil];
    
    
    
}
+(void) GetDelWifiDevSuccess:(int) devID withData:(unsigned char *)buff witLength:(int) len{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_MAIN_MSG_TYPE_DEL_WIFI_DEV_SUCCESS object:self userInfo:nil];
    
    
}

+(void) GetSetWifPasswordSuccess:(int) devID withData:(unsigned char *)buff witLength:(int) len{
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTICE_MAIN_MSG_TYPE_SET_WIFI_PASSWORD_SUCCESS object:self userInfo:nil];
    
    
    
}























- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    DevicesViewController *main=[[DevicesViewController alloc]init];
    
    //    MainViewController *main=[[MainViewController alloc]init];
    
    UINavigationController *lightNavi=[[UINavigationController alloc] initWithRootViewController:main];
    
    
    
    CGFloat top = 0; // 顶端盖高度
    CGFloat bottom = 0 ; // 底端盖高度
    CGFloat left = 0; // 左端盖宽度
    CGFloat right = 0; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    UIImage *image=[UIImage imageNamed:@"navi_bg"];
    // 指定为拉伸模式，伸缩后重新赋值
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    [lightNavi.navigationBar setBackgroundImage:image  forBarMetrics:UIBarMetricsDefault];
    
    lightNavi.navigationBar.hidden=YES;
    
    
    self.window.rootViewController=lightNavi;
    
    [self.window makeKeyAndVisible];
    
    
    //取出已保存的DEV_ID
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *devIDStr=[defaults valueForKey:DEV_ID];
    NSData *buffData=[defaults valueForKey:BUFF];
    
    
    if (devIDStr!=nil&&buffData!=nil) {
        NSLog(@"已注册过");
        int devID=[devIDStr intValue];
        [AppDelegate setCurDevID:devID];
        Byte *buff = (Byte *)[buffData bytes];
        
        int rc = 0;
        
        rc = UserInit(devID, 1000, buff);
        
        NSLog(@"UserInit: rc=%d",rc);
        
        
    }else{
        NSLog(@"》初次注册《");
        UserInit(0, 1000, nil);
    }
    
    
    [NetWorkManager sharedInstance].devices=[[sqlService sharedSqlService] getAllDevices];
    
    for (int i=0; i<[[NetWorkManager sharedInstance].devices count]; i++) {
        GNDevice *info=[[NetWorkManager sharedInstance].devices objectAtIndex:i];
        NSLog(@"*************************************info.devId=%@,  info.devInfo.deviceType=%d",info.devId,info.devInfo.deviceType);
    }
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    UserNetWorkPause();
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    UserNetWorkResume();
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
    UserNetWorkExit();
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.zhz.GuNaiAPP_T2" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"GuNaiAPP_T2" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"GuNaiAPP_T2.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
