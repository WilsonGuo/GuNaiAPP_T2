//
//  DBManager.m
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/4/4.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager


+(DBManager*)sharedInstance{
    static dispatch_once_t  onceTokenSql;
    static DBManager* aSqlService;
    
    dispatch_once(&onceTokenSql, ^{
        aSqlService = [[DBManager alloc] init];
    });
    return aSqlService;
}
- (id)init
{
    [self initDB];
    return self;
}

-(void)initDB{
    //1.获得数据库文件的路径
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileName=[doc stringByAppendingPathComponent:@"goodnight001.sqlite"];
    
    //2.获得数据库
    db=[FMDatabase databaseWithPath:fileName];
    
    //3.打开数据库
    if ([db open]) {
        //4.创表
        BOOL result=[db executeUpdate:@"CREATE TABLE IF NOT EXISTS device (id integer PRIMARY KEY AUTOINCREMENT, dev_name text, dev_id text,dev_status integer,dev_type integer);"];
        if (result) {
            NSLog(@"创表成功");
        }else
        {
            NSLog(@"创表失败");
        }
    }
}

-(BOOL) insert:(GNDevice *)device{
    if (db.open) {
        
        
        return [db executeUpdate:@"INSERT INTO device (dev_name,dev_id,dev_status,dev_type) VALUES (?,?,?,?);", device.name, device.devId,device.status,device.devType];
        
        
    }
    return NO;
}

//查询
 - (void)query
 {
     // 1.执行查询语句
     FMResultSet *resultSet = [db executeQuery:@"SELECT * FROM device"];
     
     // 2.遍历结果
     while ([resultSet next]) {
         int ID = [resultSet intForColumn:@"id"];
         NSString *name = [resultSet stringForColumn:@"dev_name"];
         NSString *devid = [resultSet stringForColumn:@"dev_id"];
         int status= [resultSet intForColumn:@"dev_status"];
          int type= [resultSet intForColumn:@"dev_type"];
         
         NSLog(@"ID=%d name=%@ devid=%@ status=%d,type=%d", ID, name,devid, status,type);
     }
 }




@end
