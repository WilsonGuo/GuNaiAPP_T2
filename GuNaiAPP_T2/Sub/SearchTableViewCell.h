//
//  SearchTableViewCell.h
//  GuNaiAPP_T2
//
//  Created by Wilson on 16/4/3.
//  Copyright © 2016年 com.zhz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *devName;
@property (weak, nonatomic) IBOutlet UILabel *devID;
@property (weak, nonatomic) IBOutlet UIImageView *devImg;
@property (weak, nonatomic) IBOutlet UIImageView *checkImg;
@end
