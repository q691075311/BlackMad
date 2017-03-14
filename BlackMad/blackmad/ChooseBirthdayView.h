//
//  ChooseBirthdayView.h
//  blackmad
//
//  Created by taobo on 17/3/13.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseBirthdayDelegate <NSObject>

- (void)chooseDate:(NSString *)dateStr;

@end

@interface ChooseBirthdayView : UIView
@property (nonatomic,assign) id<ChooseBirthdayDelegate>delegate;

- (void)show;

@end
