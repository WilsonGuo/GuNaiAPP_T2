//
//  RegisterViewController.h
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/1/18.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomViewController.h"
@interface RegisterViewController : CustomViewController
@property (weak, nonatomic) IBOutlet UITextField *inputBox_mac;
@property (weak, nonatomic) IBOutlet UITextField *inputBox_username;
@property (weak, nonatomic) IBOutlet UITextField *inputBox_connect;
@property (weak, nonatomic) IBOutlet UITextField *inputBox_email;
@property (weak, nonatomic) IBOutlet UITextField *inputBox_address;
@end
