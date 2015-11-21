//
//  FHGlobalMenuButton.h
//
//  Created by Rawlings on 15/11/18.
//  Copyright © 2015年 Rawlings. All rights reserved.

// 只接受 UIButtonTypeCustom 类型

#import <UIKit/UIKit.h>

@interface FHGlobalMenuButton : UIButton

typedef enum {
    FH_LabelPosition_Left = 1, // Label在左
    FH_LabelPosition_Right = 2 // Label在右
} FH_LabelPosition;

@property (nonatomic, assign) FH_LabelPosition LabelPosition;

/**
 *  FHGlobalMenuButton创建方法
 *
 *  @param buttonImage   按钮图片
 *  @param labelPosition 按钮 label 的位置
 *  @param labelText     按钮 label 的文字
 *
 *  @return 模板按钮
 */
+ (instancetype)fh_buttonWithImage:(UIImage *)buttonImage LabelPosition:(FH_LabelPosition)labelPosition MenuLabelText:(NSString *)labelText;


@end
