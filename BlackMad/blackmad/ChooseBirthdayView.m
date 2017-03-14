//
//  ChooseBirthdayView.m
//  blackmad
//
//  Created by taobo on 17/3/13.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import "ChooseBirthdayView.h"

#define DATEPIACKVIEWH 140

@interface ChooseBirthdayView()
@property (nonatomic,strong) UIView * dataPickView;
@property (nonatomic,strong) UIWindow * win;
@property (nonatomic,copy) NSString * dateStr;
@end

@implementation ChooseBirthdayView

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
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
//        self.hidden = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidden)];
        [self addGestureRecognizer:tap];
        _dataPickView = [[UIView alloc] initWithFrame:CGRectMake(0, DHIGTH, DWIDTH, DATEPIACKVIEWH+6+50)];
        _dataPickView.backgroundColor = COLORWITHRGB(238, 238, 238);
        
        UIDatePicker * pickView = [[UIDatePicker alloc] init];
        pickView.frame = CGRectMake(0, 0, DWIDTH, DATEPIACKVIEWH);
        pickView.datePickerMode = UIDatePickerModeDate;
        pickView.backgroundColor = [UIColor whiteColor];
        [pickView addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
        
        UIButton * confrim = [UIButton buttonWithType:UIButtonTypeCustom];
        confrim.frame = CGRectMake(0,DATEPIACKVIEWH+6, DWIDTH, 50);
        [confrim setTitle:@"确定" forState:UIControlStateNormal];
        [confrim addTarget:self action:@selector(confrimBtn) forControlEvents:UIControlEventTouchUpInside];
        [confrim setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        confrim.titleLabel.font = [UIFont systemFontOfSize:18];
        confrim.backgroundColor = [UIColor whiteColor];
        
        [_dataPickView addSubview:pickView];
        [_dataPickView addSubview:confrim];
        [self addSubview:_dataPickView];
        _win = [[[UIApplication sharedApplication] delegate] window];
        _dateStr = [self conversionDateWithDate:[NSDate date]];
    }
    return self;
}

- (void)dateChange:(UIDatePicker *)datePickView{
    NSDate * date = datePickView.date;
    _dateStr = [self conversionDateWithDate:date];
    
}

- (void)show{
    [UIView animateWithDuration:0.3 animations:^{
        [_win addSubview:self];
        self.hidden = NO;
        self.alpha = 1;
        CGRect rect = _dataPickView.frame;
        rect.origin.y = DHIGTH-DATEPIACKVIEWH-6-50;
        _dataPickView.frame = rect;
        
    }];
}
- (void)hidden{
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
}
- (void)confrimBtn{
    [self hidden];
    if (_delegate && [_delegate respondsToSelector:@selector(chooseDate:)]) {
        [_delegate chooseDate:_dateStr];
    }
}
- (NSString *)conversionDateWithDate:(NSDate *)date{
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    return [format stringFromDate:date];
}
@end
