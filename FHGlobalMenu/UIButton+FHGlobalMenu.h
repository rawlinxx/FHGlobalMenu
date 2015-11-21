//
//  UIButton+FHGlobalMenu.h
//
//  Created by Rawlings on 15/11/19.
//  Copyright © 2015年 Rawlings. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (FHGlobalMenu)

typedef enum {
    FH_PopDirection_Upward = 0,   // 向上
    FH_PopDirection_Downward = 1, // 向下
//    FH_PopDirection_Leftward = 2, // 向左  <<<<< 待完善
//    FH_PopDirection_rightward = 3 // 向右  <<<<< 待完善
} FH_PopDirection;

@property (nonatomic, assign) FH_PopDirection PopDirection;

@property (nonatomic, assign) UIBlurEffectStyle BlurEffectStyle;

@property (nonatomic, weak) UIViewController *OriginalSuperViewController;

@property (nonatomic, weak) UIView *OriginalSuperView;

@property (nonatomic, strong) NSMutableArray *GlobalAddMenuButtons;

@property (nonatomic, strong) UIVisualEffectView *GlobalAddMenuView;

@property (nonatomic, strong) NSString *InitializedSign;/**< 初始化标记 */

@property (nonatomic, copy) void(^ToDoBlock)(NSInteger buttonTag, UIViewController *currentViewController);/**< currentViewController */

/**
 *  为按钮添加菜单功能
 *
 *  @param popDirection    菜单弹出方向
 *  @param blurEffectStyle 蒙板的颜色类型
 */
- (void)fh_addGlobalMenuFunction_WithPopDirection:(FH_PopDirection)popDirection HUDStyle:(UIBlurEffectStyle)blurEffectStyle;

/**
 *  添加弹出菜单上的按钮, 使用如下:
 *  oneButton.addPopButton(btn1).addPopButton(btn2).addPopButton(btn3)...;
 */
- (UIButton *(^)(UIButton *popButton))addPopButton;

/**
 *  菜单上的按钮点击事件, 任何一个按钮点击都会执行 todoBlock 中的代码
 *
 *  @param todoBlock 为菜单按钮添加的操作
 *  todoBlock 的参数:
 *                  buttonTag --> 被点击菜单按钮 Tag 值
 *      currentViewController --> 用来 modal 新视图控制器
 */
- (void)fh_anyPopButtonClick_Operation:(void (^)(NSInteger buttonTag, UIViewController *currentViewController))todoBlock;

@end
