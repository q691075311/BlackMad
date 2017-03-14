//
//  ChangeUserInfoController.h
//  blackmad
//
//  Created by taobo on 17/3/13.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "BaseController.h"
#import "ChooseLocationView.h"
#import "CitiesDataTool.h"

@interface ChangeUserInfoController : BaseController


@end

@interface ChangeUserInfoContainerController : UITableViewController
@property (nonatomic,strong) ChangeUserInfoController * baseVC;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;//头像
@property (weak, nonatomic) IBOutlet UITextField *nickName;//昵称
@property (weak, nonatomic) IBOutlet UILabel *gender;//性别
@property (weak, nonatomic) IBOutlet UILabel *birthday;//生日
@property (weak, nonatomic) IBOutlet UILabel *adress;//地址

@property (nonatomic,strong) ChooseLocationView *chooseLocationView;
@property (nonatomic,strong) UIView  *cover;
@end