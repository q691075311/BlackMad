//
//  MainheadView.m
//  blackmad
//
//  Created by 陶博 on 2017/3/8.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "MainheadView.h"
@interface MainheadView()

@end

@implementation MainheadView

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
        
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
}




@end
