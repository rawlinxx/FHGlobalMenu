//
//  UIButton+FHGlobalMenu.m
//
//  Created by Rawlings on 15/11/19.
//  Copyright © 2015年 Rawlings. All rights reserved.
//

#import "UIButton+FHGlobalMenu.h"
#import "FHGlobalMenuConst.h"
#import "UIView+FHExtension.h"
#import <objc/runtime.h>

static const void *extern_OriginalSuperViewController = &extern_OriginalSuperViewController;
static const void *extern_OriginalSuperView = &extern_OriginalSuperView;
static const void *extern_GlobalAddMenuView = &extern_GlobalAddMenuView;
static const void *extern_GlobalAddMenuButtons = &extern_GlobalAddMenuButtons;
static const void *extern_InitializedSign = &extern_InitializedSign;
static const void *extern_ToDoBlock = &extern_ToDoBlock;

#define FH_GlobalKeyWindow [UIApplication sharedApplication].keyWindow

@implementation UIButton (FHGlobalMenu)

@dynamic GlobalAddMenuView;
@dynamic GlobalAddMenuButtons;
@dynamic OriginalSuperView;
@dynamic OriginalSuperViewController;
@dynamic InitializedSign;
@dynamic ToDoBlock;

// ***********************************************************************************
#pragma mark - API
// ***********************************************************************************
- (void)fh_addGlobalMenuFunction_WithPopDirection:(FH_PopDirection)popDirection HUDStyle:(UIBlurEffectStyle)blurEffectStyle
{
    self.PopDirection = popDirection;
    self.BlurEffectStyle = blurEffectStyle;
    self.OriginalSuperView = self.superview;
    [self addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
}


- (UIButton *(^)(UIButton *popButton))addPopButton
{
    static int i = 0;
    if (!objc_getAssociatedObject(self, extern_InitializedSign)) {
        NSString *FH_InitializedSign = @"Initialized";
        self.InitializedSign = FH_InitializedSign;
        
        i = 0;
    }

    __weak typeof(self) weakSelf = self;
    return ^(UIButton *popButton){
        if ([weakSelf.GlobalAddMenuButtons indexOfObject:popButton] != NSNotFound ||
            popButton.buttonType != UIButtonTypeCustom) {
            return self;
        }
        popButton.tag = FHMenuButtonTagRangeBegin + i;
        ++i;
        [weakSelf.GlobalAddMenuButtons addObject:popButton];
        
        [popButton addTarget:self action:@selector(anyPopButtonClickedToDo:) forControlEvents:UIControlEventTouchUpInside];
        
        return self;
    };
}


- (void)fh_anyPopButtonClick_Operation:(void (^)(NSInteger, UIViewController *))todoBlock
{
    self.ToDoBlock = todoBlock;
}

// ***********************************************************************************
#pragma mark - Setter / Getter
// ***********************************************************************************
static FH_PopDirection fh_popDirection = FH_PopDirection_Upward;

- (FH_PopDirection)PopDirection
{
    return fh_popDirection;
}

- (void)setPopDirection:(FH_PopDirection)PopDirection
{
    if (!PopDirection) return;
    fh_popDirection = PopDirection;
}
//------------------------------------------------------------------------------------
static UIBlurEffectStyle fh_blurEffectStyle = UIBlurEffectStyleLight;

- (UIBlurEffectStyle)BlurEffectStyle
{
    return fh_blurEffectStyle;
}

- (void)setBlurEffectStyle:(UIBlurEffectStyle)BlurEffectStyle
{
    if (!BlurEffectStyle) return;
    fh_blurEffectStyle = BlurEffectStyle;
}

- (UIViewController *)OriginalSuperViewController
{
    if (!objc_getAssociatedObject(self, extern_OriginalSuperViewController)) {
        for (UIView* next = [self superview]; next; next = next.superview) {
            UIResponder* nextResponder = [next nextResponder];
            if ([nextResponder isKindOfClass:[UIViewController class]]) {
                self.OriginalSuperViewController = (UIViewController *)nextResponder;
            }
        }
    }
    return objc_getAssociatedObject(self, extern_OriginalSuperViewController);
}

- (void)setOriginalSuperViewController:(UIViewController *)OriginalSuperViewController
{
    objc_setAssociatedObject(self, extern_OriginalSuperViewController,
                             OriginalSuperViewController, OBJC_ASSOCIATION_ASSIGN);
}
//------------------------------------------------------------------------------------

- (UIView *)OriginalSuperView
{
    return objc_getAssociatedObject(self, extern_OriginalSuperView);
}

- (void)setOriginalSuperView:(UIView *)OriginalSuperView
{
    objc_setAssociatedObject(self, extern_OriginalSuperView,
                             OriginalSuperView, OBJC_ASSOCIATION_ASSIGN);
}
//------------------------------------------------------------------------------------

- (UIVisualEffectView *)GlobalAddMenuView
{
    if (!objc_getAssociatedObject(self, extern_GlobalAddMenuView)) {
        UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:self.BlurEffectStyle];
        UIVisualEffectView *FH_GlobalAddMenuView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        FH_GlobalAddMenuView.frame = [UIScreen mainScreen].bounds;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(removeGlobalMenu)];
        [FH_GlobalAddMenuView addGestureRecognizer:tap];
        
        self.GlobalAddMenuView = FH_GlobalAddMenuView;
    }
    return objc_getAssociatedObject(self, extern_GlobalAddMenuView);
}

- (void)setGlobalAddMenuView:(UIVisualEffectView *)GlobalAddMenuView
{
    objc_setAssociatedObject(self, extern_GlobalAddMenuView,
                             GlobalAddMenuView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//------------------------------------------------------------------------------------

- (NSMutableArray *)GlobalAddMenuButtons
{
    if (!objc_getAssociatedObject(self, extern_GlobalAddMenuButtons)) {
        NSMutableArray *FH_GlobalAddMenuButtons = [NSMutableArray array];
        self.GlobalAddMenuButtons = FH_GlobalAddMenuButtons;
    }
    return objc_getAssociatedObject(self, extern_GlobalAddMenuButtons);
}

- (void)setGlobalAddMenuButtons:(NSMutableArray *)GlobalAddMenuButtons
{
    objc_setAssociatedObject(self, extern_GlobalAddMenuButtons,
                             GlobalAddMenuButtons, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//------------------------------------------------------------------------------------

- (NSString *)InitializedSign
{
    return objc_getAssociatedObject(self, extern_InitializedSign);
}

- (void)setInitializedSign:(NSString *)InitializedSign
{
    objc_setAssociatedObject(self, extern_InitializedSign,
                             InitializedSign, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//------------------------------------------------------------------------------------

- (void (^)(NSInteger, UIViewController *currentViewController))ToDoBlock
{
    return objc_getAssociatedObject(self, extern_ToDoBlock);
}

- (void)setToDoBlock:(void (^)(NSInteger, UIViewController *currentViewController))ToDoBlock
{
    if (!objc_getAssociatedObject(self, extern_ToDoBlock)) {
        objc_setAssociatedObject(self, extern_ToDoBlock,
                             ToDoBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }else{
        [NSException raise:@"别担心,不是什么大bug" format:@"你重复设置了同一个按钮的 todoBlock ,请检查你的代码. (默认只使用第一次的值)"];
    }
}

// ***********************************************************************************
#pragma mark - Other
// ***********************************************************************************
static int isGlobalMenuOpen = -1;

- (void)addButtonClick
{
    [self OriginalSuperViewController];
    
    if (isGlobalMenuOpen > 0) {
        [self closeGlobalMenu];
    }else{
        [self openGlobalMenu];
    }
}


- (void)removeGlobalMenu
{
    [self closeGlobalMenu];
}


- (void)anyPopButtonClickedToDo:(UIButton *)popButton
{
    [self closeGlobalMenu];
    if (self.ToDoBlock) {
        self.ToDoBlock(popButton.tag, self.OriginalSuperViewController);
    }
}
//------------------------------------------------------------------------------------

- (void)openGlobalMenu
{
    if ([self.superview.class isSubclassOfClass:[UITabBar class]]) {
        [self.superview.superview insertSubview:self.GlobalAddMenuView belowSubview:self.superview];// 不覆盖 TabBar 方案
        
    }else{
        [FH_GlobalKeyWindow addSubview:self.GlobalAddMenuView];
        
        CGRect frameInWindow = [self.superview convertRect:self.frame toView:FH_GlobalKeyWindow];// ?????????
        self.frame = frameInWindow;
        
        [self.GlobalAddMenuView.contentView addSubview:self];
    }
    
    if ([self.InitializedSign isEqualToString:@"Initialized"]) {

        for (UIButton *btn in self.GlobalAddMenuButtons) {
            btn.alpha = 0;
            [self.GlobalAddMenuView.contentView addSubview:btn];
            
            // ???????????????????????????????????????????????   mark   ?????????????????????????????????????????????????????
            //  使用 autoLayout 情况下 addBtnrc {{0, 0}, {49, 49}}  ==>  不正常
            // 不使用 autoLayout 情况下 addBtnrc {{183, 183}, {49, 49}}  ==>  正常
            CGRect addBtnrc = [self convertRect:self.imageView.frame toView:FH_GlobalKeyWindow];
            // ??????????????????????????????????????????????????????????????????????????????????????????????????????????????
            CGPoint beforeCenter = CGPointMake(addBtnrc.origin.x + addBtnrc.size.width / 2,
                                               addBtnrc.origin.y + addBtnrc.size.height / 2);

            CGPoint afterCenter = [btn convertPoint:beforeCenter fromView:FH_GlobalKeyWindow];
            
            btn.x += afterCenter.x - btn.imageView.centerX;
            btn.y += afterCenter.y - btn.imageView.centerY;
        }

        self.InitializedSign = @"onceDone";
    }
    
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:FHPopMenuOpenDuration
                          delay:FHPopMenuOpenDelay
         usingSpringWithDamping:0.5f
          initialSpringVelocity:0.0f
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         isGlobalMenuOpen *= -1;
                         for (UIButton *btn in weakSelf.GlobalAddMenuButtons) {
                             
                             btn.alpha = 1;
                             switch (fh_popDirection) {
                                 case 1: // 向下弹出
                                     btn.y += (btn.tag - FHMenuButtonTagRangeBegin + 1) * FHGlobalMenu_ButtonMargin;
//                                     btn.y = weakSelf.y + (btn.tag - FHMenuButtonTagRangeBegin + 1) * FHGlobalMenu_ButtonMargin;
                                     break;
//                                 case 2: // 向左弹出
//                                     btn.x -= (btn.tag - FHMenuButtonTagRangeBegin + 1) * FHGlobalMenu_ButtonMargin;
//                                     break;
//                                 case 3: // 向右弹出
//                                     btn.x += (btn.tag - FHMenuButtonTagRangeBegin + 1) * FHGlobalMenu_ButtonMargin;
//                                     break;
                                 default: // 向上弹出
                                     btn.y -= (btn.tag - FHMenuButtonTagRangeBegin + 1) * FHGlobalMenu_ButtonMargin;
                                     break;
                             }
                         }
                     }
                     completion:nil];
    
}


- (void)closeGlobalMenu
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:FHPopMenuCloseDuration
                     animations:^{
                         isGlobalMenuOpen *= -1;
                         for (UIButton *btn in weakSelf.GlobalAddMenuButtons) {
                             
                             btn.alpha = 0;
                             switch (fh_popDirection) {
                                 case 1: // 向下弹出
                                     btn.y -= (btn.tag - FHMenuButtonTagRangeBegin + 1) * FHGlobalMenu_ButtonMargin;
//                                     btn.y = weakSelf.y + (btn.tag - FHMenuButtonTagRangeBegin + 1) * FHGlobalMenu_ButtonMargin;
                                     break;
//                                 case 2: // 向左弹出
//                                     btn.x += (btn.tag - FHMenuButtonTagRangeBegin + 1) * FHGlobalMenu_ButtonMargin;
//                                     break;
//                                 case 3: // 向右弹出
//                                     btn.x -= (btn.tag - FHMenuButtonTagRangeBegin + 1) * FHGlobalMenu_ButtonMargin;
//                                     break;
                                 default: // 向上弹出
                                     btn.y += (btn.tag - FHMenuButtonTagRangeBegin + 1) * FHGlobalMenu_ButtonMargin;
                                     break;
                             }
                         }
                     } completion:^(BOOL finished) {
                         
                         if (![weakSelf.superview.class isSubclassOfClass:[UITabBar class]]){
                             CGRect frameInOriginalSuperView = [self.OriginalSuperView convertRect:self.frame fromView:FH_GlobalKeyWindow];
                             self.frame = frameInOriginalSuperView;
                             [self.OriginalSuperView addSubview:weakSelf];
                         }
                         [weakSelf.GlobalAddMenuView removeFromSuperview];
                     }];
}



@end
