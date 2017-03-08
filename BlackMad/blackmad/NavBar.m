//
//  NavBar.m
//  blackmad
//
//  Created by taobo on 17/3/8.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "NavBar.h"

@interface NavBar()

@end

@implementation NavBar
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    _rigthBtn.hidden = YES;
    _leftBtn.hidden = YES;
    
}
- (void)configNavBarTitle:(NSString *)title WithLeftView:(NSString *)leftImageName WithRigthView:(NSString *)rigthImageName{
    _title.text = title;
    [_leftBtn setImage:[UIImage imageNamed:leftImageName] forState:UIControlStateNormal];
    [_rigthBtn setImage:[UIImage imageNamed:rigthImageName] forState:UIControlStateNormal];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
