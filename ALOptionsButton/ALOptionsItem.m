//
//  ALOptionsItem.m
//  MyTest
//
//  Created by alezai on 15/9/19.
//  Copyright © 2015年 alezai. All rights reserved.
//

#import "ALOptionsItem.h"

@implementation ALOptionsItem

- (instancetype)initWithIndex:(NSUInteger)index{
    self = [self init];
    if (self) {
        _index = index;
    }
    return self;
}

- (id)init{
    self = [super initWithFrame:CGRectMake(0, 0, kDefaultItemWeidth, kDefaultItemWeidth + kLabelHeight)];
    
    if (self) {
        self.button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kDefaultItemWeidth, kDefaultItemWeidth)];
        self.button.layer.cornerRadius = self.frame.size.width/2;
        self.button.backgroundColor = [UIColor clearColor];
        [self addSubview:self.button];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kDefaultItemWeidth, kDefaultItemWeidth, kLabelHeight)];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.adjustsFontSizeToFitWidth = YES;
        self.titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)setImage:(UIImage *)image{
    [self.button setImage:image forState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
