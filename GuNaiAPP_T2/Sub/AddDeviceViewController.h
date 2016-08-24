//
//  AddDeviceViewController.h
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/1/21.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomViewController.h"
#import "user_interface.h"
@interface AddDeviceViewController : CustomViewController
@property (weak, nonatomic) IBOutlet UITextField *wifiName;

@property (weak, nonatomic) IBOutlet UITextField *wifiPwd;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;

@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIImageView *waitImgView;

@end
