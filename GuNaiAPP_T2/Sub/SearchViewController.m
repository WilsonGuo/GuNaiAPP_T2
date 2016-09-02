//
//  SearchViewController.m
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/4/3.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchTableViewCell.h"
#import "AppDelegate.h"
#import "SmartDeviceUtils.h"
#import "user_interface.h"
#import "sqlService.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.devicesNew=[[NSMutableArray alloc]initWithCapacity:10];
    self.devices =[[NSMutableArray alloc]initWithCapacity:10];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(findNewWifiDev:)
                                                 name:NOTICE_MAIN_MSG_TYPE_FIND_NEW_WIFI_DEV object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeToMainVC:)
                                                 name:UI_CMD_RESULT_QUARY_DEVICE_INFO_SUCCESS object:nil];
    
    self.devices=[[SmartDeviceUtils sharedInstance] getGNDevices];
    self.devicesNew=[[SmartDeviceUtils sharedInstance] getNewGNDevices];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[SmartDeviceUtils sharedInstance] clearGNDevice];
        [[SmartDeviceUtils sharedInstance] clearGNDeviceNew];
        UserEntryScanMode();
    });
    
    
    [self.showNewImg setImage:[UIImage imageNamed:@"check_press"]];
    [self.showAllImg setImage:[UIImage imageNamed:@"check_normal"]];
    self.curType=0;
    
    
}
-(void)findNewWifiDev:(NSNotification *)notification{
   
    dispatch_async(dispatch_get_main_queue(), ^{
        self.devices=[[SmartDeviceUtils sharedInstance] getGNDevices];
        [self.tableView reloadData];
        
    });
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showNewDevicesAction:(id)sender {
    if (self.curType==1) {
        
        
        
        
        [self.showNewImg setImage:[UIImage imageNamed:@"check_press"]];
        [self.showAllImg setImage:[UIImage imageNamed:@"check_normal"]];
        self.curType=0;
        
    }
     [self.tableView reloadData];
    
}
- (IBAction)showAllDevicesAction:(id)sender {
    if (self.curType==0) {
        
     
        
        
        [self.showNewImg setImage:[UIImage imageNamed:@"check_normal"]];
        [self.showAllImg setImage:[UIImage imageNamed:@"check_press"]];
        self.curType=1;
    }
     [self.tableView reloadData];
}

- (IBAction)back:(id)sender {
    UserExitScanMode();
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (IBAction)add:(id)sender {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        for (int i=0; i<[self.devices count]; i++) {
            GNDevice *info=[self.devices objectAtIndex:i];
            int devID=strtoul([[info.devId substringWithRange:NSMakeRange(0, info.devId.length)] UTF8String],0,16);
            
            if (info.isChecked) {
                int status=UserAddDevie(devID);
              
                if(status==0){
                UserExitScanMode();
                    
                    
                    
                   GNDevice *infonew=[[sqlService sharedSqlService] getDevInfoFromDBByDevID:info.devId];
                    if (infonew==nil) {
                        bool result= [[sqlService sharedSqlService] insertDevInfo:info];
                        if (result) {
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                [self.navigationController popViewControllerAnimated:YES];
                                
                            });
                    
                            
                        }
                    }else{
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            [self.navigationController popViewControllerAnimated:YES];
                            
                        });
                    }
                    
                  }
                
                [[NetWorkManager sharedInstance] airQueryState:devID];

                NSLog(@">>>>>>>>>UserAddDevie status=%d",status);
            }
        }
        
    });
    
}


-(void)changeToMainVC:(NSNotification *)notification{
    
    
    
}

#pragma maik - TableView datasource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (self.curType==0) {
        GNDevice *device=[self.devicesNew objectAtIndex:indexPath.row];
        if (device.isChecked) {
            device.isChecked=false;
        }else{
            device.isChecked=true;
        }
    }else{
        GNDevice *device=[self.devices objectAtIndex:indexPath.row];
        if (device.isChecked) {
            device.isChecked=false;
        }else{
            device.isChecked=true;
        }
    }
    
    [_tableView reloadData];
};


#pragma mark 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.curType==0) {
        return self.devicesNew.count;
    }else{
       return self.devices.count;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //组件复用
    static NSString *CellIdentifier = @"Cell";
    SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SearchTableViewCell" owner:self options:nil] lastObject];
    }
    //更新数据
    cell.selectionStyle=UITableViewCellSelectionStyleNone;//除去选中时的背景
    if (self.curType==0) {//新设备
        GNDevice *info=[self.devicesNew objectAtIndex:indexPath.row];
        
        if ([info.name isEqual:@""]||[info.name isEqual:nil]) {
            cell.devName.text=@"古耐智能設備";
        }else{
            cell.devName.text=info.name;
        }
        
        int infoID=strtoul([[info.devId substringWithRange:NSMakeRange(0, info.devId.length)] UTF8String],0,16);
        cell.devID.text=[NSString stringWithFormat:@"ID:%u",infoID&0x7fffffff];
        
        if (info.isChecked) {
            [cell.checkImg setImage:[UIImage imageNamed:@"check_press"]];
        }else{
            [cell.checkImg setImage:[UIImage imageNamed:@"check_normal"]];
            
        }
    }else{//全部设备
        GNDevice *info=[self.devices objectAtIndex:indexPath.row];
        if ([info.name isEqual:@""]||[info.name isEqual:nil]) {
            cell.devName.text=@"古耐智能設備";
        }else{
            cell.devName.text=info.name;
        }
        int infoID=strtoul([[info.devId substringWithRange:NSMakeRange(0, info.devId.length)] UTF8String],0,16);
        cell.devID.text=[NSString stringWithFormat:@"ID:%u",infoID&0x7fffffff];
        if (info.isChecked) {
            [cell.checkImg setImage:[UIImage imageNamed:@"check_press"]];
        }else{
            [cell.checkImg setImage:[UIImage imageNamed:@"check_normal"]];
            
        }
    }
    
   
    
    
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
        
        
    }
}

@end
