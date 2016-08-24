//
//  ScreenViewController.m
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/4/9.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import "ScreenViewController.h"
#import "NetWorkManager.h"
#import "GNDevice.h"
@interface ScreenViewController ()

@end

@implementation ScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GNDevice *device=[NetWorkManager sharedInstance].devInfo;
    self.timeView.text=[NSString stringWithFormat:@"%d小时", device.devInfo.filterTime/2]  ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
