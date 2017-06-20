//
//  ClassHeadView.h
//  blackmad
//
//  Created by taobo on 17/6/5.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClassTopViewDelegate <NSObject>
/**
 *  选择的类型   0活动    1卡券
 */
- (void)chooseTopbarClass:(NSInteger)classType;

@end

@interface ClassHeadView : UIView

@property (nonatomic,assign) id<ClassTopViewDelegate>delegate;


@end
