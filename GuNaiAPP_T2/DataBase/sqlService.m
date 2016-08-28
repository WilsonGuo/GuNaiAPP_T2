//
//  sqlService.m
//
//  Created by administrator on 14-11-30.
//  Copyright (c) 2014年 com.seanywell. All rights reserved.
//
#import "sqlService.h"


@implementation sqlService

@synthesize _database;
@synthesize TableName;

+(sqlService*)sharedSqlService
{
    static dispatch_once_t  onceTokenSql;
    static sqlService* aSqlService;
    
    dispatch_once(&onceTokenSql, ^{
        aSqlService = [[sqlService alloc] init];
    });
    
    
    return aSqlService;
}

- (id)init
{
    
    [self initDevInfoDic];
    return self;
}

- (void)dealloc
{
    //[super dealloc];
    [self.devInfoDicWithMac removeAllObjects];
    self.devInfoDicWithMac = nil;
    [self.devInfoDicWithId removeAllObjects];
    self.devInfoDicWithId = nil;
}


//获取document目录并返回数据库目录
- (NSString *)dataFilePath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //NSLog(@"=======%@",documentsDirectory);
    return [documentsDirectory stringByAppendingPathComponent:kFilename];//这里很神奇，可以定义成任何类型的文件，也可以不定义成.db文件，任何格式都行，定义成.sb文件都行，达到了很好的数据隐秘性
    
}

//创建，打开数据库
- (BOOL)openDB {
    
    //获取数据库路径
    NSString *path = [self dataFilePath];
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断数据库是否存在
    BOOL find = [fileManager fileExistsAtPath:path];
    
    //如果数据库存在，则用sqlite3_open直接打开（不要担心，如果数据库不存在sqlite3_open会自动创建）
    if (find) {
        
        if(sqlite3_open([path UTF8String], &_database) != SQLITE_OK) {
            
            //如果打开数据库失败则关闭数据库
            sqlite3_close(self._database);
            //NSLog(@"Error: open database file.");
            return NO;
        }
        
        //创建一个新表
        [self createDevInfo:self._database];
        
        //[self createTempAndLiquorForDev:self._database];
        
        return YES;
    }
    //如果发现数据库不存在则利用sqlite3_open创建数据库（上面已经提到过），与上面相同，路径要转换为C字符串
    if(sqlite3_open([path UTF8String], &_database) == SQLITE_OK) {
        
        //创建一个新表
        [self createDevInfo:self._database];
        return YES;
    } else {
        //如果创建并打开数据库失败则关闭数据库
        sqlite3_close(self._database);
        NSLog(@"Error: open database file.");
        return NO;
    }
    return NO;
}

-(void)closeDB{
    if(self._database!=nil){
        sqlite3_close(self._database);
        self._database = nil;
    }
    
}

-(void) initDevInfoDic{
    NSLog(@"sql:initDevInfoDic");
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        //sql语句
        char *sql = "SELECT id,name,devid,status, type,devicetype,FROM DevInfo";
        
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            NSLog(@"Error: failed to prepare statement with message:init DevInfo.");
            return;
        }
        else {
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                GNDevice* info = [[GNDevice alloc] init] ;
                int i = 0;
                int curid =sqlite3_column_int(statement,i++);
                
                char* nameText   = (char*)sqlite3_column_text(statement, i++);
                char* devId   = (char*)sqlite3_column_text(statement, i++);

               
                int devStatus =sqlite3_column_int(statement,i++);
                int devType =sqlite3_column_int(statement,i++);
                if (nameText!=NULL&&nameText!=nil) {
                     info.name=[NSString stringWithUTF8String:nameText];
                }else{
                     info.name=@"device";
                }
               
                info.devId=[NSString stringWithUTF8String:devId];;
                info.devType=devType;
                info.status=devStatus;
                
            
                
                
                
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(_database);
        
    }
}


/**
 *  创建表
 *
 *  @param db
 *
 *  @return BOOL
 */
- (BOOL) createDevInfo:(sqlite3*)db {
    
    //这句是大家熟悉的SQL语句
    char *sql = "create table if not exists DevInfo(id INTEGER PRIMARY KEY AUTOINCREMENT, name text,devid text,status int, type int,devicetype int)";// testID是列名，int 是数据类型，testValue是列名，text是数据类型，是字符串类型
    
    sqlite3_stmt *statement;
   
    NSInteger sqlReturn = sqlite3_prepare_v2(_database, sql, -1, &statement, nil);
      //如果SQL语句解析出错的话程序返回
    if(sqlReturn != SQLITE_OK) {
        NSLog(@"Error: failed to prepare statement:create DevInfo table");
        return NO;
    }
    
    //执行SQL语句
    int success = sqlite3_step(statement);
    //释放sqlite3_stmt
    sqlite3_finalize(statement);
    
    //执行SQL语句失败
    if ( success != SQLITE_DONE) {
        NSLog(@"Error: failed to dehydrate:create table DevInfo");
        return NO;
    }
    //NSLog(@"Create table 'DevInfo' successed.");
    
    
    char *sql2 = "update sqlite_sequence SET seq = 1 where name ='DevInfo';";
    
    sqlite3_stmt *statement2;
    
    NSInteger sqlReturn2 = sqlite3_prepare_v2(_database, sql2, -1, &statement2, nil);
    
    
    if(sqlReturn2 != SQLITE_OK) {
        NSLog(@"Error: failed to prepare statement:create DevInfo table");
        return NO;
    }
    
    success = sqlite3_step(statement2);
    
    sqlite3_finalize(statement2);
    
    //执行SQL语句失败
    if ( success != SQLITE_DONE) {
        NSLog(@"Error: failed to init seq row for table DevInfo");
        return NO;
    }
    
    return YES;
}



/**
 *  插入数据
 *
 *  @param insertDevInfo GNDevice
 *
 *  @return BOOL
 */
-(BOOL) insertDevInfo:(GNDevice *)insertDevInfo {
    
    //先判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement;
        
        
        static char *sql = "INSERT INTO DevInfo(name,devid,status,type,devicetype) VALUES(?,?,?,?,?)";
        
        int success2 = sqlite3_prepare_v2(_database, sql, -1, &statement, NULL);
        if (success2 != SQLITE_OK) {
            NSLog(@"Error: failed to insert:DevInfo");
            sqlite3_close(_database);
            return NO;
        }
        
        int i = 1;
        sqlite3_bind_text(statement, i++, [insertDevInfo.name UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, i++, [insertDevInfo.devId UTF8String], -1, SQLITE_TRANSIENT);
         NSLog(@"insertDevInfo>>>insert %@",insertDevInfo.devId );
        
        sqlite3_bind_int(statement, i++, insertDevInfo.status);
        sqlite3_bind_int(statement, i++, insertDevInfo.devType);
         sqlite3_bind_int(statement, i++, insertDevInfo.devInfo.deviceType);
        
        NSLog(@"insertDevInfo>>>>>>>>insertDevInfo.devInfo.deviceType= %d",insertDevInfo.devInfo.deviceType );
                //执行插入语句
        success2 = sqlite3_step(statement);
        //NSLog(@"insertDevInfo:%d",success2);
        //释放statement
        sqlite3_finalize(statement);
        
        //如果插入失败
        if (success2 == SQLITE_ERROR) {
            NSLog(@"Error: failed to insert DevInfo into the database with message.");
            //关闭数据库
            sqlite3_close(_database);
            return NO;
        }
        
        
        //关闭数据库
        sqlite3_close(_database);
        
        
        return YES;
    }
    return NO;
}




/**
 *  更新数据
 *
 *  @param updateDevInfo GNDevice
 *
 *  @return BOOL
 */
-(BOOL) updateDevInfoByMac:(GNDevice *)updateDevInfo{
    
    if ([self openDB]) {
        sqlite3_stmt *statement;//这相当一个容器，放转化OK的sql语句
        //组织SQL语句
        char *sql = "update DevInfo set name = ? , status = ?  , type = ?,devicetype = ? WHERE devid = ?";
        //const char *sql = "update DevInfo set name=?   ";
        //将SQL语句放入sqlite3_stmt中
        int success = sqlite3_prepare_v2(_database, sql, -1, &statement, NULL);
        if (success != SQLITE_OK) {
            NSLog(@"Error: failed to update:DevInfo");
            sqlite3_close(_database);
            return NO;
        }
        // name text,devid int,status int, type int
        
        int i=1;
        NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>update:DevInfo  name=%@",updateDevInfo.name);
        NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>update:DevInfo  devid=%s",[updateDevInfo.devId UTF8String]);
        
        sqlite3_bind_text(statement,i++, [updateDevInfo.name UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, i++, [updateDevInfo.devId UTF8String], -1, SQLITE_TRANSIENT);   sqlite3_bind_int(statement, i++, updateDevInfo.status);
        sqlite3_bind_int(statement, i++, updateDevInfo.devType);
         sqlite3_bind_int(statement, i++, updateDevInfo.devInfo.deviceType);
        
        
        //
        //执行SQL语句。这里是更新数据库
        success = sqlite3_step(statement);
        //释放statement
        sqlite3_finalize(statement);
        
        //如果执行失败
        if (success == SQLITE_ERROR) {
            NSLog(@"Error: failed to update the database with message.");
            //关闭数据库
            sqlite3_close(_database);
            return NO;
        }
        NSLog(@"Success:  update the database with message.");
        
        //执行成功后依然要关闭数据库
        sqlite3_close(_database);
        return YES;
    }
    return NO;
}

//更新数据


/**
 *  删除数据
 *
 *  @param deleteDevInfo GNDevice
 *
 *  @return BOOL
 */
- (BOOL) deleteDevInfo:(GNDevice *)deleteDevInfo{
    if ([self openDB]) {
        
        sqlite3_stmt *statement;
        //组织SQL语句
        static char *sql = "DELETE FROM DevInfo where devid = ?";
        //将SQL语句放入sqlite3_stmt中
        
        
        int success = sqlite3_prepare_v2(_database, sql, -1, &statement, NULL);
        if (success != SQLITE_OK) {
            NSLog(@"Error: failed to delete:testTable");
            sqlite3_close(_database);
            return NO;
        }
        
       sqlite3_bind_text(statement, 1, [deleteDevInfo.devId UTF8String], -1, SQLITE_TRANSIENT);
        
        //执行SQL语句。这里是更新数据库
        success = sqlite3_step(statement);
        //释放statement
        sqlite3_finalize(statement);
        
        //如果执行失败
        if (success == SQLITE_ERROR) {
            NSLog(@"Error: failed to delete the database with message.");
            //关闭数据库
            sqlite3_close(_database);
            return NO;
        }
        
        //执行成功后依然要关闭数据库
        sqlite3_close(_database);
        
        return YES;
    }
    return NO;
    
}



/**
 *  查询指定设备
 *
 *  @param devid ID号
 *
 *  @return GNDevice
 */
- (GNDevice*)getDevInfoFromDBByDevID:(NSString *)devid{
    
    GNDevice* info = nil;
    
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        //sql语句name text,devid int,status int, type int
        NSString *querySQL = [NSString stringWithFormat:@"SELECT id,name,status,type,devicetype from DevInfo where devid = ? "];
        const char *sql = [querySQL UTF8String];
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            NSLog(@"Error: failed to prepare statement with message:search DevInfo.");
            return info;
        } else {
            
             sqlite3_bind_text(statement, 1, [devid UTF8String], -1, SQLITE_TRANSIENT);
             NSLog(@"[devid UTF8String]====>:%s ",[devid UTF8String]);
            //查询结果集中一条一条的遍历所有的记录，这里的数字对应的是列值。
            if (sqlite3_step(statement) == SQLITE_ROW) {
                info = [[GNDevice alloc]init];
                int i = 0;
                int curid =sqlite3_column_int(statement,i++);
                NSLog(@"curid====>:%d ",curid);
                char* nameText   = (char*)sqlite3_column_text(statement, i++);
                NSLog(@"[nameText UTF8String]====>:%@ ",[NSString stringWithUTF8String:nameText]);
                int devStatus =sqlite3_column_int(statement,i++);
                NSLog(@"devStatus====>:%d ",devStatus);
                int devType =sqlite3_column_int(statement,i++);
                 NSLog(@"devType====>:%d ",devType);
                int devicetype=sqlite3_column_int(statement,i++);
                 NSLog(@"devicetype====>:%d ",devicetype);
                info.name=[NSString stringWithUTF8String:nameText];
                info.devType=devType;
                info.status=devStatus;
                info.devId=devid;
                info.devInfo.deviceType=devicetype;
                NSLog(@"getDevInfoFromDBByDevID:%@ devId:%@  devType:%u status:%u  devicetype:%u ",info.name,devid,info.devType,info.status,info.devInfo.deviceType);
                
                
            }
            //[searchList release];
        }
        sqlite3_finalize(statement);
        sqlite3_close(_database);
    }
    
    return info;
}
/**
 *  获取全部的设备
 *
 *  @return NSMutableArray
 */
-(NSMutableArray*) getAllDevices{
    NSLog(@"sql:initDevInfoDic");
    NSMutableArray* list=[[NSMutableArray alloc]initWithCapacity:10];
    //判断数据库是否打开
    if ([self openDB]) {
        
        sqlite3_stmt *statement = nil;
        //sql语句
        char *sql = "SELECT id,name,devid,status,type,devicetype FROM DevInfo";
        
        if (sqlite3_prepare_v2(_database, sql, -1, &statement, NULL) != SQLITE_OK) {
            NSLog(@"Error: failed to prepare statement with message:init DevInfo.");
            return nil;
        }
        else {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                GNDevice* info = [[GNDevice alloc] init] ;
                int i = 0;
                int curid =sqlite3_column_int(statement,i++);
                
                char* nameText   = (char*)sqlite3_column_text(statement, i++);
                char* devId =(char*)sqlite3_column_text(statement, i++);
                info.devId=[NSString stringWithUTF8String:devId];
                NSLog(@"getAllDevInfos:  devId :%@ ",info.devId);
                int devStatus =sqlite3_column_int(statement,i++);
                int devType =sqlite3_column_int(statement,i++);
                int devicetype =sqlite3_column_int(statement,i++);
                
                 NSLog(@"getAllDevInfos:  devicetype :%d ",devicetype);
                if (nameText!=NULL&&nameText!=nil) {
                    info.name=[NSString stringWithUTF8String:nameText];
                }else{
                    info.name=@"device";
                }
                
//                NSLog(@"getAllDevInfos:  devId :%s ",devId);
//                 NSLog(@"getAllDevInfos:  devId :%@ ",[NSString stringWithUTF8String:devId]);
               
                info.devType=devType;
                info.status=devStatus;
                if(info.devInfo==nil){
                    info.devInfo= [[DeviceInfo alloc] init];
                }
                info.devInfo.deviceType=devicetype;
                
                [list addObject:info];
               
             
                
                
            }
        }
        sqlite3_finalize(statement);
        sqlite3_close(_database);
        
    }
    
    return list;
}


@end

