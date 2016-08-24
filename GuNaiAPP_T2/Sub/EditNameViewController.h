//
//  EditNameViewController.h
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/4/17.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GNDevice.h"
#import "sqlService.h"
@interface EditNameViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *editNameInputBox;
@property (weak, nonatomic) IBOutlet UITextField *numInputBox;
@property(nonatomic,strong) GNDevice *device;
@end
