//
//  UIView+FHExtension.h
//
//  Created by Rawlings on 15/5/23.
//  Copyright (c) 2015年 Rawlings. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FHExtension)

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

/**
 *  从 Xib 创建一个控件
 */
+ (instancetype)viewFromXib;
@end
