//
//  ALOptionsButton.h
//  MyTest
//
//  Created by alezai on 15/9/19.
//  Copyright © 2015年 alezai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALOptionsItem.h"

typedef NS_ENUM(NSInteger, ALOptionsButtonState){
    ALOptionsButtonStateNormal = 0,
    ALOptionsButtonStateOpened,
    ALOptionsButtonStateClosed
};

@class ALOptionsButton;

@protocol ALOptionsButtonDelegate <NSObject>

- (NSUInteger)alOptionsButtonNumberOfItems:(ALOptionsButton *)alOptionsButton;
- (ALOptionsItem *)tabBar:(UITabBar *)tabBar itemAtIndex:(NSUInteger)index;

@optional
- (void)alOptionsButton:(ALOptionsButton *)alOptionsButton didSlectItem:(ALOptionsItem *)item;

@end

@interface ALOptionsButton : UIButton

@property (nonatomic, weak) id<ALOptionsButtonDelegate> delegate;
@property (nonatomic, readonly, weak) UITabBar *tabBar;
@property (nonatomic, assign) NSUInteger locationIndexInTabBar;
@property (nonatomic, readonly) ALOptionsButtonState currentState;

- (instancetype)initForTabBar:(UITabBar*)tabBar
                 forItemIndex:(NSUInteger)itemIndex
                     delegate:(id<ALOptionsButtonDelegate>)delegate;

@end

