//
//  WYPopupTapStrategy.m
//  WYExtension
//
//  Created by wy on 2020/9/1.
//  Copyright © 2020 汪洋. All rights reserved.
//

#import "WYPopupTapStrategy.h"
#import "WYPopupBgView.h"

@interface APLPopupTapBaseStrategy ()
@property (nonatomic, weak) WYPopupBgView *popup;
@end


@implementation APLPopupTapBaseStrategy

- (instancetype)initWithPopup:(WYPopupBgView *)popup
{
    self = [super init];
    if (self) {
        self.popup = popup;
    }
    return self;
}

- (void)popupTapAction {

}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    self.isTapInBg = !CGRectContainsPoint(self.popup.container.frame, [touch locationInView:self.popup]);
    return YES;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return YES;
}

@end

#pragma mark -
@implementation APLThroughPopupBgStrategy

- (instancetype)initWithPopup:(WYPopupBgView *)popup
{
    self = [super init];
    if (self) {
        self.popup = popup;
    }
    return self;
}

// 这个方法只在点击到 container 时会调用
- (void)popupTapAction {

}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    if (CGRectContainsPoint(self.popup.container.frame, [touch locationInView:self.popup])) {
        return YES;
    } else  {
        return NO;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (CGRectContainsPoint(self.popup.container.frame, point)) {
        return YES;
    } else  {
        return NO;
    }
}
@end

#pragma mark -
@implementation APLPopupTapCustomStrategy
- (instancetype)initWithPopup:(WYPopupBgView *)popup
{
    self = [super init];
    if (self) {
        self.popup = popup;
    }
    return self;
}

- (void)popupTapAction {
    if (self.isTapInBg) {
        [self.popup popupTapOnBg];
    } else {
        [self.popup popupTapOnContainer];
    }
}
@end

#pragma mark -
@implementation APLPopupTapHideStrategy
- (instancetype)initWithPopup:(WYPopupBgView *)popup
{
    self = [super init];
    if (self) {
        self.popup = popup;
    }
    return self;
}

- (void)popupTapAction {
    if (self.isTapInBg) {
        [self.popup hide];
        [self.popup popupTapOnBg];
    } else {
        [self.popup popupTapOnContainer];
    }
}

@end
