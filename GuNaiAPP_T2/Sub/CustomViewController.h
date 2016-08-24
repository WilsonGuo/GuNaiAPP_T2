//
//  CustomViewController.h
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/1/23.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface CustomViewController : UIViewController
{
    MBProgressHUD *HUD;
}


#pragma mark toast
-(void)showTip:(NSString *)text;
-(void)showText:(NSString *)text;
-(void)showProgress:(NSString *)text;
-(void)showCustom:(NSString *)text;
@end
