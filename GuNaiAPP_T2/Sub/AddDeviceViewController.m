//
//  AddDeviceViewController.m
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/1/21.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import "AddDeviceViewController.h"
#import "SmartDeviceUtils.h"
#import "AppDelegate.h"
@interface AddDeviceViewController ()

@end

@implementation AddDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setWifiPwdSuccess:)
                                                 name:NOTICE_MAIN_MSG_TYPE_SET_WIFI_PASSWORD_SUCCESS object:nil];
//    self.wifiName.text=[[SmartDeviceUtils sharedInstance] getDeviceSSID];
   
}
-(void)setWifiPwdSuccess:(NSNotification *)notification{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)keyboardWillShowNomal:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration = [[userInfo
                                         objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect newFrame = self.view.frame;
    newFrame.origin.y= -40;
    
    [UIView beginAnimations:@"ResizeTextView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    self.view.frame = newFrame;
    [UIView commitAnimations];
}
- (void)keyboardWillhideNomal:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration = [[userInfo
                                         objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect newFrame = self.view.frame;
    newFrame.origin.y= 0;
    
    [UIView beginAnimations:@"ResizeTextView" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    self.view.frame = newFrame;
    [UIView commitAnimations];
}
- (void)keyboardWillShowFor4:(NSNotification *)notification{
    
}
- (void)keyboardWillhideFor4:(NSNotification *)notification{
    
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)hideKeyboardAction:(id)sender {
    [self hideKeyBoard];
}

- (IBAction)hideKeyBoardAction1:(id)sender {
    [self hideKeyBoard];
}

-(void)hideKeyBoard{
    [self.wifiName resignFirstResponder];
    [self.wifiPwd resignFirstResponder];
}

- (IBAction)okAction:(id)sender {
    
    NSString *SSID = self.wifiName.text;
    NSString *PWD = self.wifiPwd.text;       //        NSString *PWD = @"munan_201211";
    
    if (![PWD isEqual:@""]&&PWD!=nil&&![SSID isEqual:@""]&&SSID!=nil) {
        [self startLoading];
        NSString *ssidAddress = SSID;
        NSData* bytesSSID = [ssidAddress dataUsingEncoding:NSUTF8StringEncoding];
        Byte * ssidAddressByte = (Byte *)[bytesSSID bytes];
        NSString *pwdAddress = PWD;
        NSData* bytesPwd = [pwdAddress dataUsingEncoding:NSUTF8StringEncoding];
        Byte * pwdAddressByte = (Byte *)[bytesPwd bytes];
        unsigned int flag=0;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            int result=UserApConfig(ssidAddressByte,bytesSSID.length,pwdAddressByte,bytesPwd.length,flag);
            [self endLoading];
            if (result==0) {
                [self showTip:@"配置错误,请检查输入信息"];
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                    
                });
            }
        });
    }else{
        [self showTip:@"Wifi名称或密码不能为空"];
    }
 
    
    
}
- (IBAction)homeAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
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
