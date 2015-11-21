
#import <UIKit/UIKit.h>


/** 弹出 button 的间隙 */
CGFloat const FHGlobalMenu_ButtonMargin = 60;
/** 弹出 button 与 label 的间隙 */
CGFloat const FHGlobalMenu_Button2LabelMargin = 40;
/** 弹出 button 允许使用 tag 范围的起始值 (往后递增1) */
CGFloat const FHMenuButtonTagRangeBegin = 10001; // 第一个 popButton.tag = 10001, 往后按照添加顺序 +1
/** 弹出 label 字体大小 */
CGFloat const FHMenuLabel_FontSize = 17;

/** 弹出 Menu -> animation_Duration */
NSTimeInterval const FHPopMenuOpenDuration = 0.3;
/** 弹出 Menu -> animation_Delay */
NSTimeInterval const FHPopMenuOpenDelay = 0;
/** 弹回 Menu -> animateWithDuration */
NSTimeInterval const FHPopMenuCloseDuration = 0.15;


//** 弹出 label 字体颜色 */    ---- go --->  FHConst.h
//** 弹出 label 背景颜色 */        /