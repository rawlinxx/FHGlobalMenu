//
//  FHGlobalMenuButton.m
//
//  Created by Rawlings on 15/11/18.
//  Copyright © 2015年 Rawlings. All rights reserved.
//

#import "FHGlobalMenuButton.h"
#import "FHGlobalMenuConst.h"
#import "UIView+FHExtension.h"

@implementation FHGlobalMenuButton

+ (instancetype)fh_buttonWithImage:(nonnull UIImage *)buttonImage LabelPosition:(FH_LabelPosition)labelPosition MenuLabelText:(nullable NSString *)labelText
{
    FHGlobalMenuButton *btn = [FHGlobalMenuButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:buttonImage forState:UIControlStateNormal];
    if (labelText.length) {
        [btn setTitle:labelText forState:UIControlStateNormal];
    }
    [btn setTitleColor:FHMenuLabel_TextColor forState:UIControlStateNormal];
    [btn sizeToFit];
    
    btn.titleLabel.backgroundColor = FHMenuLabel_BackgroundColor;
    btn.titleLabel.font = [UIFont systemFontOfSize:FHMenuLabel_FontSize];
    btn.LabelPosition = labelPosition;
    
    return btn;
}


+ (instancetype)buttonWithType:(UIButtonType)buttonType
{
    return [super buttonWithType:UIButtonTypeCustom];
}


- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    NSString *extendStr = [NSString stringWithFormat:@"  %@  ",title];
    [super setTitle:extendStr forState:state];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    switch (self.LabelPosition) {
        case 1:{ // 在左
            self.imageView.x = self.width - self.imageView.width;
            self.titleLabel.x = FHGlobalMenu_Button2LabelMargin * -1;
        }break;
            
        default:{ // 在右
            self.imageView.x = 0;
            self.titleLabel.x = self.imageView.width + FHGlobalMenu_Button2LabelMargin;
        }break;
    }

    self.titleLabel.layer.cornerRadius = self.titleLabel.height / 2;
    [self.titleLabel setClipsToBounds:YES];
}


@end
