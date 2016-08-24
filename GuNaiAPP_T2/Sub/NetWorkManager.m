//
//  NetWorkManager.m
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/3/27.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import "NetWorkManager.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "CMD.h"
#import "DeviceInfo.h"
@implementation NetWorkManager{
     MBProgressHUD *HUD;
}



+ (NetWorkManager *)sharedInstance
{
    static dispatch_once_t  onceToken;
    static NetWorkManager * sSharedInstance;
    
    dispatch_once(&onceToken, ^{
        sSharedInstance = [[NetWorkManager alloc] init];
    });
    
    return sSharedInstance;
}


-(int) airClose:(int) devId{
    [AppDelegate setCurDevID:devId];
    [AppDelegate setTurnOFF:YES];
    Byte *data=(Byte *)malloc(10);
    for(int i=0;i<10;i++){
        data[i]=0;
    }
    data[0]=CMD_A2M_SET_WORK_MODE;
    data[1]=0x00;
    
    int status=UserGetServiceLinkStatus();
    if (status>0){
        NSLog(@"＊＊服务器在线＊＊ID=%u",AppDelegate.getCurDevID);
        int result=UserSendData(AppDelegate.getCurDevID,10,data);
        return result;
    }else{
        return -99;
    }
}
-(int) airOpen:(int) devId{
    [AppDelegate setCurDevID:devId];
    [AppDelegate setTurnOFF:NO];
    Byte *data=(Byte *)malloc(10);
    for(int i=0;i<10;i++){
        data[i]=0;
    }
    data[0]=CMD_A2M_SET_WORK_MODE;
    data[1]=255;
    
    int status=UserGetServiceLinkStatus();
    if (status>0){
        NSLog(@"＊＊服务器在线＊＊ID=%u",AppDelegate.getCurDevID);
        int result=UserSendData(AppDelegate.getCurDevID,10,data);
        return result;
    }else{
        return -99;
    }
}




-(int)airSetMode:(int) mode withID:(int) devId
{
    [AppDelegate setCurDevID:devId];
    
    Byte *data=(Byte *)malloc(10);
    for(int i=0;i<10;i++){
        data[i]=0;
    }
    data[0]=CMD_A2M_SET_WORK_MODE;
    data[1]=mode;
    
    int status=UserGetServiceLinkStatus();
    if (status>0){
        NSLog(@"＊＊服务器在线＊＊ID=%u",AppDelegate.getCurDevID);
        int result=UserSendData(AppDelegate.getCurDevID,10,data);
        return result;
    }else{
        NSLog(@"＊＊服务器不在线＊＊ID=%u",AppDelegate.getCurDevID);
        return -99;
    }
}


-(int)airOpenO1:(int )devId
{
    
    [AppDelegate setCurDevID:devId];
    
    Byte *data=(Byte *)malloc(10);
    for(int i=0;i<10;i++){
        data[i]=0;
    }
    data[0]=CMD_A2M_SET1_O1;
    data[1]=1;
    
    int status=UserGetServiceLinkStatus();
    if (status>0){
        NSLog(@"＊＊服务器在线＊＊ID=%u",AppDelegate.getCurDevID);
        int result=UserSendData(AppDelegate.getCurDevID,10,data);
        return result;
    }else{
        NSLog(@"＊＊服务器不在线＊＊ID=%u",AppDelegate.getCurDevID);
        return -99;
    }
}

-(int)airCloseO1:(int )devId
{
    
    [AppDelegate setCurDevID:devId];
    
    Byte *data=(Byte *)malloc(10);
    for(int i=0;i<10;i++){
        data[i]=0;
    }
    data[0]=CMD_A2M_SET1_O1;
    data[1]=0;
    
    int status=UserGetServiceLinkStatus();
    if (status>0){
        NSLog(@"＊＊服务器在线＊＊ID=%u",AppDelegate.getCurDevID);
        int result=UserSendData(AppDelegate.getCurDevID,10,data);
        return result;
    }else{
        NSLog(@"＊＊服务器不在线＊＊ID=%u",AppDelegate.getCurDevID);
        return -99;
    }

}

-(int)airYiJunOpen:(int )devId
{
    
    [AppDelegate setCurDevID:devId];
    
    Byte *data=(Byte *)malloc(10);
    for(int i=0;i<10;i++){
        data[i]=0;
    }
    data[0]=CMD_A2M_SET1_UV;
    data[1]=1;
    
    int status=UserGetServiceLinkStatus();
    if (status>0){
        NSLog(@"＊＊服务器在线＊＊ID=%u",AppDelegate.getCurDevID);
        int result=UserSendData(AppDelegate.getCurDevID,10,data);
        return result;
    }else{
        NSLog(@"＊＊服务器不在线＊＊ID=%u",AppDelegate.getCurDevID);
        return -99;
    }
    
}

-(int)airYiJunClose:(int )devId
{
    
    [AppDelegate setCurDevID:devId];
    
    Byte *data=(Byte *)malloc(10);
    for(int i=0;i<10;i++){
        data[i]=0;
    }
    data[0]=CMD_A2M_SET1_UV;
    data[1]=0;
    
    int status=UserGetServiceLinkStatus();
    if (status>0){
        NSLog(@"＊＊服务器在线＊＊ID=%u",AppDelegate.getCurDevID);
        int result=UserSendData(AppDelegate.getCurDevID,10,data);
        return result;
    }else{
        NSLog(@"＊＊服务器不在线＊＊ID=%u",AppDelegate.getCurDevID);
        return -99;
    }
    
}

-(int)airQuWeiOpen:(int )devId
{
    
    [AppDelegate setCurDevID:devId];
    
    Byte *data=(Byte *)malloc(10);
    for(int i=0;i<10;i++){
        data[i]=0;
    }
    data[0]=CMD_A2M_SET1_O3;
    data[1]=1;
    
    int status=UserGetServiceLinkStatus();
    if (status>0){
        NSLog(@"＊＊服务器在线＊＊ID=%u",AppDelegate.getCurDevID);
        int result=UserSendData(AppDelegate.getCurDevID,10,data);
        return result;
    }else{
        NSLog(@"＊＊服务器不在线＊＊ID=%u",AppDelegate.getCurDevID);
        return -99;
    }
    
}


-(int)airQuWeiClose:(int )devId
{
    
    [AppDelegate setCurDevID:devId];
    
    Byte *data=(Byte *)malloc(10);
    for(int i=0;i<10;i++){
        data[i]=0;
    }
    data[0]=CMD_A2M_SET1_O3;
    data[1]=0;
    
    int status=UserGetServiceLinkStatus();
    if (status>0){
        NSLog(@"＊＊服务器在线＊＊ID=%u",AppDelegate.getCurDevID);
        int result=UserSendData(AppDelegate.getCurDevID,10,data);
        return result;
    }else{
        NSLog(@"＊＊服务器不在线＊＊ID=%u",AppDelegate.getCurDevID);
        return -99;
    }
    
}



-(int)airQueryState:(int )devId
{
    
    [AppDelegate setCurDevID:devId];
    
    Byte *data=(Byte *)malloc(10);
    for(int i=0;i<10;i++){
        data[i]=0;
    }
    data[0]=CMD_A2M_QUERY_STATE;
    
    int status=UserGetServiceLinkStatus();
    if (status>0){
        NSLog(@"＊＊服务器在线＊＊ID=%u",AppDelegate.getCurDevID);
        int result=UserSendData(AppDelegate.getCurDevID,10,data);
        return result;
    }else{
        NSLog(@"＊＊服务器不在线＊＊ID=%u",AppDelegate.getCurDevID);
        return -99;
    }

}



-(int)airSetTimer:(Byte) startHour withStartMin: (Byte) startMin withEndHour:(Byte) endHour withEndMin:(Byte) endMin withID:(int) devId
{
    
    [AppDelegate setCurDevID:devId];
    Byte *data=(Byte *)malloc(10);
    for(int i=0;i<10;i++){
        data[i]=0;
    }
    data[0]=CMD_A2M_SET_TIMER;
    data[1]=startMin;
    data[2]=startHour;
    data[3]=endMin;
    data[4]=endHour;
    
    int status=UserGetServiceLinkStatus();
    if (status>0){
        NSLog(@"＊＊服务器在线＊＊ID=%u",AppDelegate.getCurDevID);
        int result=UserSendData(AppDelegate.getCurDevID,10,data);
        return result;
    }else{
        NSLog(@"＊＊服务器不在线＊＊ID=%u",AppDelegate.getCurDevID);
        return -99;
    }
}


-(int)airSetWindInLevel:(Byte) level withID:(int) devId
{
    [AppDelegate setCurDevID:devId];
    Byte *data=(Byte *)malloc(10);
    for(int i=0;i<10;i++){
        data[i]=0;
    }
    data[0]=CMD_A2M_SET_WIND_IN;
    data[1]=level;
    
    int status=UserGetServiceLinkStatus();
    if (status>0){
        NSLog(@"＊＊服务器在线＊＊ID=%u",AppDelegate.getCurDevID);
        int result=UserSendData(AppDelegate.getCurDevID,10,data);
        return result;
    }else{
        NSLog(@"＊＊服务器不在线＊＊ID=%u",AppDelegate.getCurDevID);
        return -99;
    }
}



-(int)airCloseWindIn:(int) devId
{
    [AppDelegate setCurDevID:devId];
    Byte *data=(Byte *)malloc(10);
    for(int i=0;i<10;i++){
        data[i]=0;
    }
    data[0]=CMD_A2M_SET_WIND_IN;
    data[1]=0;
    
    int status=UserGetServiceLinkStatus();
    if (status>0){
        NSLog(@"＊＊服务器在线＊＊ID=%u",AppDelegate.getCurDevID);
        int result=UserSendData(AppDelegate.getCurDevID,10,data);
        return result;
    }else{
        NSLog(@"＊＊服务器不在线＊＊ID=%u",AppDelegate.getCurDevID);
        return -99;
    }
   
}
-(int)airOpenWindIn:(int) devId
{
    [AppDelegate setCurDevID:devId];
    Byte *data=(Byte *)malloc(10);
    for(int i=0;i<10;i++){
        data[i]=0;
    }
    data[0]=CMD_A2M_SET_WIND_IN;
    data[1]=(Byte)255;
    
    int status=UserGetServiceLinkStatus();
    if (status>0){
        NSLog(@"＊＊服务器在线＊＊ID=%u",AppDelegate.getCurDevID);
        int result=UserSendData(AppDelegate.getCurDevID,10,data);
        return result;
    }else{
        NSLog(@"＊＊服务器不在线＊＊ID=%u",AppDelegate.getCurDevID);
        return -99;
    }
    
}

-(int)airSetWindOutLevel:(Byte) level withID: (int) devId
{
    [AppDelegate setCurDevID:devId];
    Byte *data=(Byte *)malloc(10);
    for(int i=0;i<10;i++){
        data[i]=0;
    }
    data[0]=CMD_A2M_SET_WIND_OUT;
    data[1]=level;
    
    int status=UserGetServiceLinkStatus();
    if (status>0){
        NSLog(@"＊＊服务器在线＊＊ID=%u",AppDelegate.getCurDevID);
        int result=UserSendData(AppDelegate.getCurDevID,10,data);
        return result;
    }else{
        NSLog(@"＊＊服务器不在线＊＊ID=%u",AppDelegate.getCurDevID);
        return -99;
    }
}


-(int)airSetHumi:(Byte) level withID: (int) devId
{
    
    [AppDelegate setCurDevID:devId];
    Byte *data=(Byte *)malloc(10);
    for(int i=0;i<10;i++){
        data[i]=0;
    }
    data[0]=CMD_A2M_SET1_HUMI;
    data[1]=level;
    
    int status=UserGetServiceLinkStatus();
    if (status>0){
        NSLog(@"＊＊服务器在线＊＊ID=%u",AppDelegate.getCurDevID);
        int result=UserSendData(AppDelegate.getCurDevID,10,data);
        return result;
    }else{
        NSLog(@"＊＊服务器不在线＊＊ID=%u",AppDelegate.getCurDevID);
        return -99;
    }
}

-(int)airCloseWindOut:(int) devId
{
    
    
    [AppDelegate setCurDevID:devId];
    Byte *data=(Byte *)malloc(10);
    for(int i=0;i<10;i++){
        data[i]=0;
    }
    data[0]=CMD_A2M_SET_WIND_OUT;
    data[1]=(Byte)0;
    
    int status=UserGetServiceLinkStatus();
    if (status>0){
        NSLog(@"＊＊服务器在线＊＊ID=%u",AppDelegate.getCurDevID);
        int result=UserSendData(AppDelegate.getCurDevID,10,data);
        return result;
    }else{
        NSLog(@"＊＊服务器不在线＊＊ID=%u",AppDelegate.getCurDevID);
        return -99;
    }
   
}
-(int)airOpenWindOut:(int) devId
{
    [AppDelegate setCurDevID:devId];
    Byte *data=(Byte *)malloc(10);
    for(int i=0;i<10;i++){
        data[i]=0;
    }
    data[0]=CMD_A2M_SET_WIND_OUT;
    data[1]=(Byte)255;

    
    int status=UserGetServiceLinkStatus();
    if (status>0){
        NSLog(@"＊＊服务器在线＊＊ID=%u",AppDelegate.getCurDevID);
        int result=UserSendData(AppDelegate.getCurDevID,10,data);
        return result;
    }else{
        NSLog(@"＊＊服务器不在线＊＊ID=%u",AppDelegate.getCurDevID);
        return -99;
    }
}


-(int)airOpenHeat:(int) devId
{
    
    [AppDelegate setCurDevID:devId];
    Byte *data=(Byte *)malloc(10);
    for(int i=0;i<10;i++){
        data[i]=0;
    }
    data[0]=CMD_A2M_SET_HEAT;
    data[1]=1;
    
    
    int status=UserGetServiceLinkStatus();
    if (status>0){
        NSLog(@"＊＊服务器在线＊＊ID=%u",AppDelegate.getCurDevID);
        int result=UserSendData(AppDelegate.getCurDevID,10,data);
        return result;
    }else{
        NSLog(@"＊＊服务器不在线＊＊ID=%u",AppDelegate.getCurDevID);
        return -99;
    }
}

-(int)airCloseHeat:(int) devId
{
    
    [AppDelegate setCurDevID:devId];
    Byte *data=(Byte *)malloc(10);
    for(int i=0;i<10;i++){
        data[i]=0;
    }
    data[0]=CMD_A2M_SET_HEAT;
    data[1]=0;
    
    
    int status=UserGetServiceLinkStatus();
    if (status>0){
        NSLog(@"＊＊服务器在线＊＊ID=%u",AppDelegate.getCurDevID);
        int result=UserSendData(AppDelegate.getCurDevID,10,data);
        return result;
    }else{
        NSLog(@"＊＊服务器不在线＊＊ID=%u",AppDelegate.getCurDevID);
        return -99;
    }
}


-(int)airOpenUV:(int) devId
{
    
    [AppDelegate setCurDevID:devId];
    Byte *data=(Byte *)malloc(10);
    for(int i=0;i<10;i++){
        data[i]=0;
    }
    data[0]=CMD_A2M_SET1_UV;
    data[1]=1;
    
    
    int status=UserGetServiceLinkStatus();
    if (status>0){
        NSLog(@"＊＊服务器在线＊＊ID=%u",AppDelegate.getCurDevID);
        int result=UserSendData(AppDelegate.getCurDevID,10,data);
        return result;
    }else{
        NSLog(@"＊＊服务器不在线＊＊ID=%u",AppDelegate.getCurDevID);
        return -99;
    }
    
   
}

-(int)airCloseUV:(int) devId
{

    [AppDelegate setCurDevID:devId];
    Byte *data=(Byte *)malloc(10);
    
    for(int i=0;i<10;i++){
        data[i]=0;
    }
    data[0]=CMD_A2M_SET1_UV;
    data[1]=0;
    
    
    int status=UserGetServiceLinkStatus();
    if (status>0){
        NSLog(@"＊＊服务器在线＊＊ID=%u",AppDelegate.getCurDevID);
        int result=UserSendData(AppDelegate.getCurDevID,10,data);
        return result;
    }else{
        NSLog(@"＊＊服务器不在线＊＊ID=%u",AppDelegate.getCurDevID);
        return -99;
    }
}

-(int)airOpenO3:(int) devId

{
    [AppDelegate setCurDevID:devId];
    Byte *data=(Byte *)malloc(10);
    for(int i=0;i<10;i++){
        data[i]=0;
    }
    data[0]=CMD_A2M_SET1_O3;
    data[1]=1;
    
    
    int status=UserGetServiceLinkStatus();
    if (status>0){
        NSLog(@"＊＊服务器在线＊＊ID=%u",AppDelegate.getCurDevID);
        int result=UserSendData(AppDelegate.getCurDevID,10,data);
        return result;
    }else{
        NSLog(@"＊＊服务器不在线＊＊ID=%u",AppDelegate.getCurDevID);
        return -99;
    }
    
}

-(int)airCloseO3:(int) devId
{
    [AppDelegate setCurDevID:devId];
    Byte *data=(Byte *)malloc(10);
    for(int i=0;i<10;i++){
        data[i]=0;
    }
    data[0]=CMD_A2M_SET1_O3;
    data[1]=0;
    
    
    int status=UserGetServiceLinkStatus();
    if (status>0){
        NSLog(@"＊＊服务器在线＊＊ID=%u",AppDelegate.getCurDevID);
        int result=UserSendData(AppDelegate.getCurDevID,10,data);
        return result;
    }else{
        NSLog(@"＊＊服务器不在线＊＊ID=%u",AppDelegate.getCurDevID);
        return -99;
    }
    
}


-(int)airSetAutoSensor:(int)sensorIndex WithID:(int) devId
{
    [AppDelegate setCurDevID:devId];
    Byte *data=(Byte *)malloc(10);
    for(int i=0;i<10;i++){
        data[i]=0;
    }
    data[0]=CMD_A2M_SET1_AUTO_SENSOR;
    data[1]=(Byte)sensorIndex;
    
    
    int status=UserGetServiceLinkStatus();
    if (status>0){
        NSLog(@"＊＊服务器在线＊＊ID=%u",AppDelegate.getCurDevID);
        int result=UserSendData(AppDelegate.getCurDevID,10,data);
        return result;
    }else{
        NSLog(@"＊＊服务器不在线＊＊ID=%u",AppDelegate.getCurDevID);
        return -99;
    }
   
}









//******************************************************************



- (int) getDataByIndex:(int) index andData: (Byte *) stateData andLen:(int) dataBytes
{
    
    int low = stateData[index];
    if(low < 0)
    {
        int i = 128+low;
        low = i|0x80;
    }
    if(dataBytes < 2)
    {
        return low;
    }
    
    int high = stateData[index+1];
    if(high < 0)
    {
        int i = 128+high;
        high = i|0x80;
    }
    
    return ((high<<8)|(low));
    
    
    return 0;
}
-(DeviceInfo *) parseInfo:(int) devId andData:(Byte *)stateData {
    DeviceInfo *eairInfo=[[DeviceInfo alloc]init];
    eairInfo.sn=devId;
    
    eairInfo.indoorTemp = stateData[STATE_DATA_INDEX_INDOOR_TEMP];
    eairInfo.indoorHumi = [self getDataByIndex:STATE_DATA_INDEX_INDOOR_HUMI andData:stateData andLen: 1];
    
    eairInfo.outdoorTemp = stateData[STATE_DATA_INDEX_OUTDOOR_TEMP];
    eairInfo.outdoorHumi = [self getDataByIndex:STATE_DATA_INDEX_OUTDOOR_HUMI andData:stateData andLen: 1];
    eairInfo.fixHumi = [self getDataByIndex:STATE_DATA_INDEX_FIX_HUMI andData:stateData andLen: 1];
    eairInfo.air=[self getDataByIndex:STATE_DATA_INDEX_AIR_STATE andData:stateData andLen: 1];
    
    eairInfo.workMode = [self getDataByIndex:STATE_DATA_INDEX_WORK_MODE andData:stateData andLen: 1];
    
    eairInfo.windInLevel = [self getDataByIndex:STATE_DATA_INDEX_WIND_IN andData:stateData andLen: 1];
    eairInfo.windOutLevel = [self getDataByIndex:STATE_DATA_INDEX_WIND_OUT andData:stateData andLen: 1];
    
    eairInfo.deviceType = [self getDataByIndex:STATE_DATA_INDEX_DEVICE_TYPE andData:stateData andLen: 1];
     NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>devId=%i",devId );
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>DeviceType=%i",eairInfo.deviceType );

    
    eairInfo.funcSet =  [self getDataByIndex:STATE_DATA_INDEX_FUNC_SET andData:stateData andLen: 1];
    eairInfo.o1 = false;
    eairInfo.heat = false;
    eairInfo.windIn = false;
    eairInfo.windOut = false;
    eairInfo.timerOn = false;
    eairInfo.uv = false;
    eairInfo.o3 = false;
    
    
    if((eairInfo.funcSet & SENSOR_STATE_MASK_HEAT) > 0)
    {
        eairInfo.heat = true;
    }
    
    if((eairInfo.funcSet & SENSOR_STATE_MASK_O1) > 0)
    {
        eairInfo.o1 = true;
    }
    
    if((eairInfo.funcSet & SENSOR_STATE_MASK_WIND_IN) > 0)
    {
        eairInfo.windIn = true;
    }
    
    if((eairInfo.funcSet & SENSOR_STATE_MASK_WIND_OUT) > 0)
    {
        eairInfo.windOut = true;
    }
    
    if((eairInfo.funcSet & SENSOR_STATE_MASK_TIMER) > 0)
    {
        eairInfo.timerOn = true;
    }
    
    if((eairInfo.funcSet & SENSOR_STATE_MASK_UV) > 0)
    {
        eairInfo.uv = true;
    }
    
    if((eairInfo.funcSet & SENSOR_STATE_MASK_O3) > 0)
    {
        eairInfo.o3 = true;
    }
    
    
    eairInfo.sysTimeMin =[self getDataByIndex:STATE_DATA_INDEX_SYSTEM_TIME andData:stateData andLen: 1];
    eairInfo.sysTimeHour = [self getDataByIndex:STATE_DATA_INDEX_SYSTEM_TIME+1 andData:stateData andLen: 1];
    eairInfo.timerStartMin = [self getDataByIndex:STATE_DATA_INDEX_TIMER_START andData:stateData andLen: 1];
    eairInfo.timerStartHour =[self getDataByIndex:STATE_DATA_INDEX_TIMER_START+1 andData:stateData andLen: 1];
    
    eairInfo.timerEndMin = [self getDataByIndex:STATE_DATA_INDEX_TIMER_END andData:stateData andLen: 1];
    eairInfo.timerEndHour = [self getDataByIndex:STATE_DATA_INDEX_TIMER_END+1 andData:stateData andLen: 1];
    
    eairInfo.filterTime = [self getDataByIndex:STATE_DATA_INDEX_FILTER_TIME andData:stateData andLen: 2];
    eairInfo.pm25 =[self getDataByIndex:STATE_DATA_INDEX_PM25 andData:stateData andLen: 2];
    int tvoc = [self getDataByIndex:STATE_DATA_INDEX_TVOC andData:stateData andLen: 2];
    eairInfo.tvoc = (float)tvoc/100.0f;
    
    int cho2 =  [self getDataByIndex:STATE_DATA_INDEX_HCOH andData:stateData andLen: 2];
    eairInfo.hcoh = (float)cho2/100.0f;
    
    eairInfo.co2 = [self getDataByIndex:STATE_DATA_INDEX_CO2 andData:stateData andLen: 2];
    
    eairInfo.autoSensorIndex = 0;
    
    return eairInfo;
}


@end
