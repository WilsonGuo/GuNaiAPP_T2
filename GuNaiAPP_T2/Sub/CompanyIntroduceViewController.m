//
//  CompanyIntroduceViewController.m
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/4/17.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import "CompanyIntroduceViewController.h"

@interface CompanyIntroduceViewController ()

@end

@implementation CompanyIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
