//
//  OpenViewController.m
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/4/6.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import "OpenViewController.h"
#import "NetWorkManager.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "CenterViewController.h"
@interface OpenViewController ()

@end

@implementation OpenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(turnOn:)
                                                 name:UI_CMD_RESULT_STATUS_TURN_ON object:nil];
    // Do any additional setup after loading the view from its nib.
}

-(void)turnOn:(NSNotification *)notification{
    DeviceInfo *info=[[notification userInfo] objectForKey:@"devID"];
    if(info!=nil){
        NSLog(@"turnOn>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>info.sn===%@,   id=%@",[NSString stringWithFormat:@"%x", info.sn],self.device.devId);
        if([[NSString stringWithFormat:@"%x", info.sn] isEqual:self.device.devId]){
            NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>turnOn");
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] removeObserver:self];
                
                int deviceType=self.device.devInfo.deviceType;
                
                if (deviceType==DEVICE_TYPE_24G) {
                    CenterViewController *vc=[[CenterViewController alloc]init];
                    vc.device=self.device;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }else if(deviceType==DEVICE_TYPE_T2){
                    MainViewController *vc=[[MainViewController alloc]init];
                    vc.device=self.device;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }else if(deviceType==DEVICE_TYPE_T1){
                    
                    MainViewController *vc=[[MainViewController alloc]init];
                    vc.device=self.device;
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    
                }
                
                
                
            });
            

        }
    }else{
        NSLog(@">>>>>>>>>>>>>>>info.sn===%@",self.device.devId);

    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

CenterViewController *centerViewVC;
MainViewController *mainVC;
- (IBAction)openAction:(id)sender {
    //     [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        int devID=strtoul([[self.device.devId substringWithRange:NSMakeRange(0, self.device.devId.length)] UTF8String],0,16);
        NSLog(@">>>>>>>>>>>>devID＝%u",devID);
        [[NetWorkManager sharedInstance] airOpen:devID];
    });
    
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    //       [self.navigationController popToRootViewControllerAnimated:YES];
    //    });
    //    int deviceType=self.device.devInfo.deviceType;
    //
    //    if (deviceType==DEVICE_TYPE_24G) {
    //        if (centerViewVC==nil) {
    //            centerViewVC=[[CenterViewController alloc]init];
    //
    //        }
    //
    //        centerViewVC.device=self.device;
    //        [self.navigationController pushViewController:centerViewVC animated:YES];
    //    }else if(deviceType==DEVICE_TYPE_T2||deviceType==DEVICE_TYPE_T1){
    //        if (mainVC==nil) {
    //            mainVC=[[MainViewController alloc]init];
    //
    //        }
    //        mainVC.device=self.device;
    //        [self.navigationController pushViewController:mainVC animated:YES];
    //
    //
    //    }
    
}


@end
