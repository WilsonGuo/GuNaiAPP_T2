//
//  SetViewController.m
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/1/18.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import "SetViewController.h"
#import "AddDeviceViewController.h"
#import "DevicesViewController.h"
#import "UserGuidViewController.h"
#import "QuestionViewController.h"
#import "CompanyIntroduceViewController.h"
@interface SetViewController ()

@end

@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)homeAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)questionAction:(id)sender {
   
    QuestionViewController *vc=[[QuestionViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)userGuidAction:(id)sender {
    
    UserGuidViewController *vc=[[UserGuidViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)addDeviceAction:(id)sender {
    
    AddDeviceViewController *vc=[[AddDeviceViewController alloc]init];
//      DevicesViewController *vc=[[DevicesViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)introduiceAction:(id)sender {
    CompanyIntroduceViewController *vc=[[CompanyIntroduceViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
