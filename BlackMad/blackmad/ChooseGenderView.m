//
//  ChooseGenderView.m
//  blackmad
//
//  Created by taobo on 17/3/13.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "ChooseGenderView.h"

@interface ChooseGenderView()
@property (nonatomic,strong) UIWindow * window;

@end

@implementation ChooseGenderView

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
        self.frame = frame;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
//        self.hidden = YES;
        
        
        _window = [[[UIApplication sharedApplication] delegate] window];
    }
    return self;
}

- (void)show{
    [_window addSubview:self];
    
}

@end
