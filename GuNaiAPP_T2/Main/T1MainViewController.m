//
//  T1MainViewController.m
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/5/8.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import "T1MainViewController.h"
#import "SetViewController.h"
#import "RegisterViewController.h"
#import "user_interface.h"
#import "AppDelegate.h"
#import "NetWorkManager.h"
#import "CMD.h"
#import "OpenViewController.h"
#import "ScreenViewController.h"

@interface T1MainViewController (){
    Byte startTime;
    Byte startMin;
    Byte endTime;
    Byte endMin;
    
    int slider_1_value;
    int slider_2_value;
    
    bool isShow;
}


@end

@implementation T1MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
