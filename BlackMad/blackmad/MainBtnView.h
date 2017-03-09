//
//  MainBtnView.h
//  blackmad
//
//  Created by taobo on 17/3/9.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainBtnViewDelegate <NSObject>

- (void)touchBtnWithBtn:(UIButton *)btn;

@end

@interface MainBtnView : UIView
@property (nonatomic,assign) id<MainBtnViewDelegate>delegate;

@end
