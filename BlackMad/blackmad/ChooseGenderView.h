//
//  ChooseGenderView.h
//  blackmad
//
//  Created by taobo on 17/3/13.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseGenderDelegate <NSObject>

- (void)selectWithGender:(NSString *)gender;

@end

@interface ChooseGenderView : UIView
@property (nonatomic,assign) id<ChooseGenderDelegate>delegate;
- (void)show;
@end
