//
//  CustomViewController.m
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/1/23.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import "CustomViewController.h"
#import "SmartDeviceUtils.h"
@interface CustomViewController ()

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //处理键盘弹起事件
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillhide:) name:UIKeyboardWillHideNotification object:nil];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//在键盘弹起后调用
- (void)keyboardWillShow:(NSNotification *)notification{
    NSString *name=[[SmartDeviceUtils sharedInstance] doDevicePlatform];
    if ([name isEqual:@"iPhone 4S"]||[name isEqual:@"iPhone 4"]) {
        [self keyboardWillShowFor4:notification];
    }else{
        [self keyboardWillShowNomal:notification];
    }
};

//在键盘隐藏后，会调用：
- (void)keyboardWillhide:(NSNotification *)notification{
    NSString *name=[[SmartDeviceUtils sharedInstance] doDevicePlatform];
    if ([name isEqual:@"iPhone 4S"]||[name isEqual:@"iPhone 4"]) {
        [self keyboardWillhideFor4:notification];
    }else{
        [self keyboardWillhideNomal:notification];
    }
};

- (void)keyboardWillShowNomal:(NSNotification *)notification{
    
}
- (void)keyboardWillhideNomal:(NSNotification *)notification{
    
}
- (void)keyboardWillShowFor4:(NSNotification *)notification{
    
}
- (void)keyboardWillhideFor4:(NSNotification *)notification{
    
}



//提示
-(void)showTip:(NSString *)text{
    if(text!=NULL&&![text isEqual:@""]){
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.labelText = text;
        HUD.mode = MBProgressHUDModeText;
        
        //指定距离中心点的X轴和Y轴的偏移量，如果不指定则在屏幕中间显示
        //    HUD.yOffset = 150.0f;
        //    HUD.xOffset = 100.0f;
        
        [HUD showAnimated:YES whileExecutingBlock:^{
            sleep(2);
        } completionBlock:^{
            [HUD removeFromSuperview];
            HUD = nil;
        }];
    }
}
//提示与Loading
-(void)showText:(NSString *)text{
    if(text!=NULL&&![text isEqual:@""]){
        //初始化进度框，置于当前的View当中
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        
        //如果设置此属性则当前的view置于后台
        HUD.dimBackground = YES;
        //设置对话框文字
        HUD.labelText = text;
        
        //显示对话框
        [HUD showAnimated:YES whileExecutingBlock:^{
            //对话框显示时需要执行的操作
            sleep(2);
        } completionBlock:^{
            //操作执行完后取消对话框
            [HUD removeFromSuperview];
            HUD = nil;
        }];
    }
}
//提示与进度条
-(void)showProgress:(NSString *)text{
    if(text!=NULL&&![text isEqual:@""]){
        
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.labelText = text;
        
        //设置模式为进度框形的
        HUD.mode = MBProgressHUDModeDeterminate;
        [HUD showAnimated:YES whileExecutingBlock:^{
            float progress = 0.0f;
            while (progress < 1.0f) {
                progress += 0.01f;
                HUD.progress = progress;
                usleep(50000);
            }
        } completionBlock:^{
            [HUD removeFromSuperview];
            HUD = nil;
        }];
    }
}

//自定义
-(void)showCustom:(NSString *)text{
    if(text!=NULL&&![text isEqual:@""]){
        HUD = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.labelText = text;
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Checkmark"]] ;
        [HUD showAnimated:YES whileExecutingBlock:^{
            sleep(2);
        } completionBlock:^{
            [HUD removeFromSuperview];
            HUD = nil;
        }];
    }
}

@end
