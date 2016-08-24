//
//  RegisterViewController.m
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/1/18.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitAction:(id)sender {
    
    
    
}
- (IBAction)homeAction:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)setAction:(id)sender {
    
    
}
- (IBAction)hideKeyboard:(id)sender {
    [self.inputBox_mac resignFirstResponder];
    [self.inputBox_email resignFirstResponder];
    [self.inputBox_username resignFirstResponder];
    [self.inputBox_connect resignFirstResponder];
    [self.inputBox_address resignFirstResponder];
    
}
- (IBAction)hideKeyboard2:(id)sender {
    [self.inputBox_mac resignFirstResponder];
    [self.inputBox_email resignFirstResponder];
    [self.inputBox_username resignFirstResponder];
    [self.inputBox_connect resignFirstResponder];
    [self.inputBox_address resignFirstResponder];
}
- (void)keyboardWillShowNomal:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSTimeInterval animationDuration = [[userInfo
                                         objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect newFrame = self.view.frame;
    newFrame.origin.y= -70;
    
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

@end
