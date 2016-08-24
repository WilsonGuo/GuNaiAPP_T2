//
//  sqlService.h
//  chazuo
//
//  Created by administrator on 14-11-30.
//  Copyright (c) 2014年 com.seanywell. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "GNDevice.h"

#define kFilename  @"goodnight19.db"


@interface sqlService : NSObject {
	sqlite3 *_database;
	char* TableName;
}

+(sqlService*)sharedSqlService;

@property (nonatomic,assign) NSComparator devArrayComparetor;

@property (nonatomic,retain,strong) NSMutableDictionary* devInfoDicWithMac;
@property (nonatomic,retain,strong) NSMutableDictionary* devInfoDicWithId;

@property (nonatomic) sqlite3 *_database;
@property (nonatomic) char* TableName;

-(BOOL) createDevInfo:(sqlite3 *)db;//创建数据库
- (BOOL)openDB;
-(void)closeDB;

-(BOOL) insertDevInfo:(GNDevice *)insertDevInfo;//插入数据
-(BOOL) updateDevInfoByMac:(GNDevice *)updateDevInfo;

- (BOOL) deleteDevInfo:(GNDevice *)deleteDevInfo;
- (GNDevice*)getDevInfoFromDBByDevID:(NSString *)devid;
-(NSMutableArray*) getAllDevices;

#pragma mark -- --

@end
