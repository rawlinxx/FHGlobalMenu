# FHGlobalMenu

Make your button support global menu function easily

为按钮添加全局菜单功能



![demo1](https://github.com/rawlinxx/FHGlobalMenu/blob/master/demo1.gif)

##介绍

就可以为你指定的目标按钮添加菜单功能, 并且可以配置菜单弹出方向和蒙板的颜色类型

- 步骤:

1. 在项目中导入"FHGlobalMenu.h"主头文件
2. `目标按钮`使用`fh_addGlobalMenuFunction_WithPopDirection: HUDStyle:`方法
3. `目标按钮`使用`addPopButton`方法,后面加个`(你想要显示到菜单中的按钮)`    **传进去的按钮可以是任意按钮,或者使用提供的模板按钮"FHGlobalMenuButton"**,每一次只加一个.
4. 集成成功! 你点击`目标按钮`就会弹出菜单, 并且可以使用`fh_anyPopButtonClick_Operation:`方法监听所有菜单上的按钮.
        

##使用示例



``` objective-c
// 注意: yourBtn 不要使用 autoLayout, 否则会 "呵呵...", 建议使用代码创建

/* 为你的按钮_添加菜单功能 */
        [yourButton fh_addGlobalMenuFunction_WithPopDirection:FH_PopDirection_Downward HUDStyle:UIBlurEffectStyleLight];



/* 创建 <你希望弹出的菜单按钮> (除了使用'FHGlobalMenuButton' 也可以使用你自定义的按钮)*/
        FHGlobalMenuButton *bb1 = [FHGlobalMenuButton fh_buttonWithImage:[UIImage imageNamed:@"mine-icon-feedback"]
                                                           LabelPosition:FH_LabelPosition_Right
                                                           MenuLabelText:@"FirstButton"];

        FHGlobalMenuButton *bb2 = [FHGlobalMenuButton fh_buttonWithImage:[UIImage imageNamed:@"mine-icon-nearby"]
                                                           LabelPosition:FH_LabelPosition_Left
                                                           MenuLabelText:@"SecondButton"];

        FHGlobalMenuButton *bb3 = [FHGlobalMenuButton fh_buttonWithImage:[UIImage imageNamed:@"mine-icon-preview"]
                                                           LabelPosition:FH_LabelPosition_Right
                                                           MenuLabelText:@"ThirdButton"];

        FHGlobalMenuButton *bb4 = [FHGlobalMenuButton fh_buttonWithImage:[UIImage imageNamed:@"mine-icon-search"]
                                                           LabelPosition:FH_LabelPosition_Left
                                                           MenuLabelText:@"FourthButton"];

/* 按顺序添加 <你希望弹出的菜单按钮> */
        yourButton.addPopButton(bb1).addPopButton(bb2).addPopButton(bb3).addPopButton(bb4);



/* 为弹出的菜单按钮添加事件 ( #任何一个按钮被点击就会调用 todoBlock ) => 同样可以不使用该方法,自己为每个按钮手动添加事件 */
        [yourButton fh_anyPopButtonClick_Operation:^(NSInteger buttonTag, UIViewController *currentViewController) {
            // 在 todoBlock 中添加你的代码, 示例:

            NSLog(@" todoBlock 被调用了");

            [currentViewController presentViewController:[[FHRandomColorVC alloc] init] animated:YES completion:nil];

            switch (buttonTag) {
                case 10001:
                    NSLog(@"第1个按钮被点击了");
                    break;
                case 10002:
                    NSLog(@"第2个按钮被点击了");
                    break;
                case 10003:
                    NSLog(@"第3个按钮被点击了");
                    break;
                case 10004:
                    NSLog(@"第4个按钮被点击了");
                    break;
                default:
                    NSLog(@"其他配置 -> FHGlobalMenuConst常量文件");
                    break;
            }
        }];

```
