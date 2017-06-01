//
//  NavBar.h
//  blackmad
//
//  Created by taobo on 17/3/8.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavBarDelegate <NSObject>

- (void)touchLeftBtn;
- (void)touchRigthBtn;

@end

@interface NavBar : UIView
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rigthBtn;
@property (nonatomic,assign) BOOL isAppearLineView;//是否隐藏辅助线   默认no

@property (nonatomic,assign) id<NavBarDelegate>delegate;

- (void)configNavBarTitle:(NSString *)title WithLeftView:(NSString *)leftImageName WithRigthView:(NSString *)rigthImageName;

@end
