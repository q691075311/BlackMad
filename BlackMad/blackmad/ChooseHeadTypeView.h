//
//  ChooseHeadTypeView.h
//  blackmad
//
//  Created by taobo on 17/3/22.
//  Copyright © 2017年 rongyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChooseHeadTypeViewDelegate <NSObject>
/**
 *  选择相机
 */
- (void)chooseImageForCamera;
/**
 *  选择图库
 */
- (void)chooseImageForPhotoLibrary;

@end
@interface ChooseHeadTypeView : UIView
@property (nonatomic,assign) id<ChooseHeadTypeViewDelegate>delegate;
- (void)show;

@end
