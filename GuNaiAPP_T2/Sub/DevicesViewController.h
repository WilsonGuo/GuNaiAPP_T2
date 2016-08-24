//
//  DevicesViewController.h
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/1/21.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomViewController.h"
#import "GNDevice.h"
@interface DevicesViewController :CustomViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (retain,nonatomic) NSMutableArray* devices;
@property (weak, nonatomic) IBOutlet UIView *editView;


@property (weak, nonatomic) IBOutlet UIView *loadingView;
@property (weak, nonatomic) IBOutlet UIImageView *waitImgView;

@property(nonatomic,strong) GNDevice *device;
@property(nonatomic,strong) GNDevice *editDevice;

@property(nonatomic,strong) NSTimer *timer;

@property(nonatomic,assign)Boolean isStart;
@end
