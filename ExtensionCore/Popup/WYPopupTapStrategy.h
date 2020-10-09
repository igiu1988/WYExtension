//
//  WYPopupTapStrategy.h
//  WYExtension
//
//  Created by wy on 2020/9/1.
//  Copyright © 2020 汪洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WYPopupBgView;

// WYPopupBgView 手势点击时的策略模型。手势响应时会调用popupTapAction。创建不同的Strategy可以实现各种各样的手势识别需求
@protocol WYPopupTapStrategy <NSObject>
- (void)popupTapAction;
- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch;
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event;

@end

// 策略模型的基类。这是一个抽象类，不要在业务代码中直接使用它，需要使用相关的子类
@interface APLPopupTapBaseStrategy : NSObject <WYPopupTapStrategy>
@property (nonatomic, assign) BOOL isTapInBg;
- (instancetype)initWithPopup:(WYPopupBgView *)popup;
@end


// 点击到背景时，手势不会被接收，以便传递到下面的图层
@interface APLThroughPopupBgStrategy : APLPopupTapBaseStrategy
@end


/*
 点击背景时不执行隐藏，只会调用 [WYPopupBgView popupTapOnBg]，并且popupTapOnBg这个方法默认实现为空。
 */
@interface APLPopupTapCustomStrategy : APLPopupTapBaseStrategy
@end

// 点击背景隐藏 popup
@interface APLPopupTapHideStrategy : APLPopupTapBaseStrategy
@end
