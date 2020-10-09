//
//  WYPopupDemo.m
//  WYExtension
//
//  Created by wy on 2020/10/9.
//  Copyright © 2020 wy. All rights reserved.
//

#import "WYPopupDemo.h"

@implementation WYPopupDemo

- (void)setup {
    [super setup];
    self.bgAlphaColor = [[UIColor blackColor] colorWithAlphaComponent:.5];
    self.popupAnimation = [[APLPopupAnimationFlipFromBottom alloc] initWithPopup:self];
    self.container.backgroundColor = UIColor.whiteColor;

    // 设置 container 的坐标和大小
//    [self.container mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(0);
//        make.bottom.equalTo(self.mas_bottom);
//    }];

    // 业务相关的代码，把要显示的 UI 添加到 container 中


}

@end
