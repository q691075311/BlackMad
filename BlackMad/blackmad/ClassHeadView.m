//
//  ClassHeadView.m
//  blackmad
//
//  Created by taobo on 17/6/5.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "ClassHeadView.h"

@implementation ClassHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        ClassHeadView * view = [[[NSBundle mainBundle] loadNibNamed:@"ClassHeadView" owner:self options:nil] lastObject];
        self.frame = view.frame;
        view.autoresizingMask = self.autoresizingMask;
        return view;
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
}

@end
