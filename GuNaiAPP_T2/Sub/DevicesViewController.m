//
//  DevicesViewController.m
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/1/21.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import "DevicesViewController.h"
#import "DeviceTableViewCell.h"
#import "AppDelegate.h"
#import "SmartDeviceUtils.h"
#import "SearchViewController.h"

#import "user_interface.h"
#import "sqlService.h"
#import "SetViewController.h"
#import "MainViewController.h"
#import "NetWorkManager.h"
#import "OpenViewController.h"
#import "EditNameViewController.h"
#import "CenterViewController.h"
#import "T1MainViewController.h"
@interface DevicesViewController ()

@end

@implementation DevicesViewController
- (void)viewDidUnload{
    [self.timer invalidate];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.devices =[[NSMutableArray alloc]initWithCapacity:10];
    
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeToMainVC:)
                                                 name:UI_CMD_RESULT_QUARY_DEVICE_INFO_SUCCESS object:nil];
    
    
    
    
    self.timer= [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(reflush:) userInfo:nil repeats:YES];
    
}
-(void)getData:(NSNotification *)notification{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData];
        
        
    });
}



-(void)changeToMainVC:(NSNotification *)notification{
    
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [self startLoading];
    self.isStart=YES;
    [NetWorkManager sharedInstance].devices=[[sqlService sharedSqlService] getAllDevices];
    //    self.devices=[[sqlService sharedSqlService] getAllDevices];
    self.devices=[NetWorkManager sharedInstance].devices;
    
    for (int i=0; i<[[NetWorkManager sharedInstance].devices count]; i++) {
        GNDevice *device=[[NetWorkManager sharedInstance].devices objectAtIndex:i];
        int devID=strtoul([[device.devId substringWithRange:NSMakeRange(0, device.devId.length)] UTF8String],0,16);
        
        int result=UserActiveDevice(devID);
        if (result==1) {
            NSLog(@">>>>>>>>>>UserActiveDevice Success");
        }else{
            NSLog(@">>>>>>>>>>UserActiveDevice fail");
        }
        
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSLog(@"*******************startLoading******************");
        
        for (int i=0; i<[[NetWorkManager sharedInstance].devices count]; i++) {
            GNDevice *device=[[NetWorkManager sharedInstance].devices objectAtIndex:i];
            int devID=strtoul([[device.devId substringWithRange:NSMakeRange(0, device.devId.length)] UTF8String],0,16);
            
            int status=UserGetDeviceLinkStatus(devID);
            
            
            device.status=status;
            int infoID=strtoul([[device.devId substringWithRange:NSMakeRange(0, device.devId.length)] UTF8String],0,16);
            NSString *str=[NSString stringWithFormat:@"ID:%u",infoID&0x7fffffff];
            NSLog(@"viewWillAppear***************************************id=%@,devType=%d,status=%d",str,device.devInfo.deviceType,device.status);
            if(status==1){
                
                
                NSLog(@"设备在线：devID=%u  status=%d",devID,status);
                
            }else{
                NSLog(@"设备不在线：devID=%u  status=%d",devID,status);
            }
            
            
            
            
        }
        
        
    });
    
    
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_USEC),dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self endLoading];
        
    });
    
    
    
    
}
- (IBAction)hideEditAction:(id)sender {
    self.editView.hidden=YES;
}
- (IBAction)eidteNameAction:(id)sender {
    if (self.editDevice!=nil) {
        EditNameViewController *vc=[[EditNameViewController alloc]init];
        vc.device=self.editDevice;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    self.editView.hidden=YES;
}
- (IBAction)deleteAction:(id)sender {
    if (self.editDevice!=nil) {
        [[sqlService sharedSqlService] deleteDevInfo:self.editDevice];
    }
    self.editView.hidden=YES;
    [NetWorkManager sharedInstance].devices=[[sqlService sharedSqlService] getAllDevices];
    
    self.devices=[NetWorkManager sharedInstance].devices;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData];
        
    });
}

- (IBAction)menuAction:(id)sender{
    
    SetViewController *vc=[[SetViewController alloc ]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)homeAction:(id)sender {
    SearchViewController *vc=[[SearchViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)reflush:(NSTimer *)timer{
    
    
    NSLog(@"************************************reflush********************************");
    
    for (int i=0; i<[[NetWorkManager sharedInstance].devices count]; i++) {
        GNDevice *device=[[NetWorkManager sharedInstance].devices objectAtIndex:i];
        
        int devID=strtoul([[device.devId substringWithRange:NSMakeRange(0, device.devId.length)] UTF8String],0,16);
        
        int status=UserGetDeviceLinkStatus(devID);
        device.status=status;
        
        int infoID=strtoul([[device.devId substringWithRange:NSMakeRange(0, device.devId.length)] UTF8String],0,16);
        NSString *str=[NSString stringWithFormat:@"ID:%u",infoID&0x7fffffff];
        NSLog(@"reflush***************************************id=%@,devType=%d,status=%d",str,device.devInfo.deviceType,device.status);
        if(status==1){
            NSLog(@"设备在线：devID=%u  status=%d",devID,status);
            
            [AppDelegate setCMDType:CMD_CUR_TYPE_QUARY_DEVICE_INFO];
            int devID=strtoul([[device.devId substringWithRange:NSMakeRange(0, device.devId.length)] UTF8String],0,16);
            
            int dalay=i*2;
            NSLog(@"************************************dalay=%d",dalay);
            
            //            dispatch_time_t timer = dispatch_time(DISPATCH_TIME_NOW, dalay*NSEC_PER_SEC);
            //            dispatch_after(timer, dispatch_get_main_queue(), ^{
            //            });
            
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, dalay*NSEC_PER_USEC),dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>airQueryState");
                
                int result=[[NetWorkManager sharedInstance] airQueryState:devID];
                
            });
            
        }else{
            NSLog(@"设备不在线：devID=%u  status=%d",devID,status);
        }
    }
    self.devices=[NetWorkManager sharedInstance].devices;
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData];
        
    });
}

#pragma maik - TableView datasource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GNDevice *device=[[NetWorkManager sharedInstance].devices objectAtIndex:indexPath.row];
    
    [NetWorkManager sharedInstance].devInfo=device;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (device.status==STATUS_ON) {
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                int deviceType=device.devInfo.deviceType;
                
                NSLog(@"select>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>info.sn===%@,   deviceType=%d",[NSString stringWithFormat:@"%x", device.devInfo.sn],deviceType);
                
                
                                if (deviceType==DEVICE_TYPE_24G) {
                                    CenterViewController *vc=[[CenterViewController alloc]init];
                                    vc.device=device;
                                    [self.navigationController pushViewController:vc animated:YES];
                
                                }else if(deviceType==DEVICE_TYPE_T2){
                                    MainViewController *vc=[[MainViewController alloc]init];
                                    vc.device=device;
                                    [self.navigationController pushViewController:vc animated:YES];
                
                                }else if(deviceType==DEVICE_TYPE_T1){
                                    MainViewController *vc=[[MainViewController alloc]init];
                                    vc.device=device;
                                    [self.navigationController pushViewController:vc animated:YES];
                                }else{
                
                                }
            });
            
            
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showTip:@"该设备不在线！"];
                
            });
        }
        
    });
    if (device.status==STATUS_ON) {
        
    }
};


#pragma mark 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.devices.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //组件复用
    static NSString *CellIdentifier = @"Cell";
    DeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"DeviceTableViewCell" owner:self options:nil] lastObject];
    }
    //更新数据
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//除去选中时的背景
    GNDevice *info=[self.devices objectAtIndex:indexPath.row];
    
    
    int infoID=strtoul([[info.devId substringWithRange:NSMakeRange(0, info.devId.length)] UTF8String],0,16);
    cell.devID.text=[NSString stringWithFormat:@"ID:%u",infoID&0x7fffffff];
    
    if(info.status==1){
        cell.devStatus.text=@"在线";
        if (info.devInfo!=nil) {
            
            
            int deviceType=info.devInfo.deviceType;
            if (deviceType==DEVICE_TYPE_24G) {
                
                if ([info.name isEqual:DEVICE_NAME_DEFAULT]) {
                    cell.devName.text=DEVICE_NAME_CENTER;
                    
                    info.name=[NSString stringWithFormat:@"%@",DEVICE_NAME_CENTER];
                    [[sqlService sharedSqlService] deleteDevInfo:info];
                    [[sqlService sharedSqlService] insertDevInfo:info];
                    
                }else{
                    cell.devName.text=info.name;
                }
            }else if(deviceType==DEVICE_TYPE_T1){
                if ([info.name isEqual:DEVICE_NAME_DEFAULT]) {
                    cell.devName.text=DEVICE_NAME_S1;
                    
                    info.name=[NSString stringWithFormat:@"%@",DEVICE_NAME_S1];
                    [[sqlService sharedSqlService] deleteDevInfo:info];
                    [[sqlService sharedSqlService] insertDevInfo:info];
                    
                }else{
                    cell.devName.text=info.name;
                }
            }else if(deviceType==DEVICE_TYPE_T2){
                
                if ([info.name isEqual:DEVICE_NAME_DEFAULT]) {
                    cell.devName.text=DEVICE_NAME_S2;
                    
                    info.name=[NSString stringWithFormat:@"%@",DEVICE_NAME_S2];
                    [[sqlService sharedSqlService] deleteDevInfo:info];
                    [[sqlService sharedSqlService] insertDevInfo:info];
                    
                }else{
                    cell.devName.text=info.name;
                }
                
            }else{
                cell.devName.text=info.name;
            }
        }else{
            cell.devName.text=info.name;
            
            
        }
    }else{
        cell.devStatus.text=@"离线";
        cell.devName.text=info.name;
    }
    
    
    NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>name=%@",info.name);
    
    
    
    
    
    
    //长按操作
    UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(cellLongPress:)];
    [cell addGestureRecognizer:longPressGesture];
    
    
    
    return cell;
}


- (void)cellLongPress:(UIGestureRecognizer *)recognizer{
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        CGPoint point = [recognizer locationInView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
        NSLog(@">>>>>>>>>>>%ld",(long)indexPath.row);
        self.editDevice=[self.devices objectAtIndex:indexPath.row];
        
        
        
        self.editView.hidden=NO;
        
        
    }
}


-(void)startLoading{
    self.loadingView.hidden=NO;
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 1.5f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount =HUGE_VALF;
    
    [self.waitImgView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}
-(void)endLoading{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.loadingView.hidden=YES;
    });
}


@end
