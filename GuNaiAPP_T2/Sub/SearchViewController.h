//
//  SearchViewController.h
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/4/3.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetWorkManager.h"
@interface SearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *backAction;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *addAction;

@property (weak, nonatomic) IBOutlet UIImageView *showNewImg;
@property (weak, nonatomic) IBOutlet UIImageView *showAllImg;
@property (retain,nonatomic) NSMutableArray* devices;
@property (retain,nonatomic) NSMutableArray* devicesNew;

@property(nonatomic,assign)int curType;

@end
