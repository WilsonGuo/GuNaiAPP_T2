//
//  DBManager.h
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/4/4.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "GNDevice.h"
@interface DBManager : NSObject{
    //2.获得数据库
    FMDatabase *db;
    
}


+(DBManager*)sharedInstance;


-(BOOL) insert:(GNDevice *)device;
@end
