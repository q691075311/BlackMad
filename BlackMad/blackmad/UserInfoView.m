//
//  UserInfoView.m
//  blackmad
//
//  Created by taobo on 17/3/10.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "UserInfoView.h"

@implementation UserInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UserInfoView * view = [[[NSBundle mainBundle] loadNibNamed:@"UserInfoView" owner:self options:nil] lastObject];
        self.frame = frame;
        view.autoresizingMask = self.autoresizingMask;
        return view;
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.userName.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
    self.userName.textColor = COLORWITHRGB(253, 253, 253);
    
    self.userPhone.font = [UIFont fontWithName:@"PingFangSC-Regular" size:17];
    self.userPhone.textColor = COLORWITHRGB(253, 253, 253);
    
    self.userImage.layer.masksToBounds = YES;
    self.userImage.layer.cornerRadius = 40;
    
}

@end
