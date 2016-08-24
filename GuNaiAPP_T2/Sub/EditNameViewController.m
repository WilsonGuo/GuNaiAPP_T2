//
//  EditNameViewController.m
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/4/17.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import "EditNameViewController.h"

@interface EditNameViewController ()

@end

@implementation EditNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    int devID=strtoul([[self.device.devId substringWithRange:NSMakeRange(0, self.device.devId.length)] UTF8String],0,16);

    self.numInputBox.text=[NSString stringWithFormat:@"%@",self.device.devId];
    [self.numInputBox setEnabled:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)hideKeyboardAcrtion1:(id)sender {
    [self.editNameInputBox resignFirstResponder];
    [self.numInputBox resignFirstResponder];
}
- (IBAction)hideKeyboardAction:(id)sender {
    [self.editNameInputBox resignFirstResponder];
    [self.numInputBox resignFirstResponder];
}
- (IBAction)okAction:(id)sender {
    if (self.device!=nil) {
        self.device.name=[NSString stringWithFormat:@"%@",self.editNameInputBox.text];
        [[sqlService sharedSqlService] deleteDevInfo:self.device];
        [[sqlService sharedSqlService] insertDevInfo:self.device];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
   
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
