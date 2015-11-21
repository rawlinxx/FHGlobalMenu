# FHGlobalMenu
Make your button support global menu function easily

##如何使用
```
#import "FHGlobalMenu.h"


1.  [yourButton fh_addGlobalMenuFunction_WithPopDirection:FH_PopDirection_Upward HUDStyle:UIBlurEffectStyleLight];

2.  yourButton.addPopButton(btn1).addPopButton(btn2).addPopButton(btn3).addPopButton(btn4);

3. /** 可选 */   也可自己手动添加按钮监听
    [self.viewMenuBtn fh_anyPopButtonClick_Operation:^(NSInteger buttonTag, UIViewController *currentViewController) {
        
        switch (buttonTag) {
            case 10001:
                [currentViewController presentViewController:[[ViewController1 alloc] init] animated:YES completion:nil];
                NSLog(@"第一个按钮被点了");
                break;
            case 10002:
                [currentViewController presentViewController:[[ViewController2 alloc] init] animated:YES completion:nil];
                NSLog(@"第二个按钮被点了");
                break;
            case 10003:
                NSLog(@"第三个按钮被点了");
                break;
            case 10004:
                NSLog(@"第四个按钮被点了");
                break;
            default:
                NSLog(@"其他配置 -> FHGlobalMenuConst常量文件");
                break;
        }
    }];

```

##Demo

待添加...
