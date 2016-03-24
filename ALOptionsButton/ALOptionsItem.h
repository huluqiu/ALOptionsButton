//
//  ALOptionsItem.h
//  MyTest
//
//  Created by alezai on 15/9/19.
//  Copyright © 2015年 alezai. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDefaultItemWeidth 50
#define kLabelHeight 20

@interface ALOptionsItem :  UIView

@property (nonatomic, readonly) NSUInteger index;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UIButton *button;

- (instancetype)initWithIndex:(NSUInteger)index;
- (void)setImage:(UIImage *)image;
- (void)setTitle:(NSString *)title;

@end
