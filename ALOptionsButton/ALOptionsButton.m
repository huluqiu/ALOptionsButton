//
//  ALOptionsButton.m
//  MyTest
//
//  Created by alezai on 15/9/19.
//  Copyright © 2015年 alezai. All rights reserved.
//

#import "ALOptionsButton.h"

@interface ALOptionsButton ()

@property (nonatomic, assign) CGPoint centerPoint;
@property (nonatomic, strong) UIView *blackView;
@property (nonatomic, strong) NSMutableArray *alOptionItems;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIButton *alterCenterButton;

@end

@implementation ALOptionsButton

- (instancetype)initForTabBar:(UITabBar *)tabBar forItemIndex:(NSUInteger)itemIndex delegate:(id<ALOptionsButtonDelegate>)delegate{
    
    if (self = [super init]) {
        _tabBar = tabBar;
        _delegate = delegate;
        _locationIndexInTabBar = itemIndex;
        _alOptionItems = [NSMutableArray new];
        
        [self initAlOptionsButton];
    }
    
    return self;
}

- (void)initAlOptionsButton{
    if (self.tabBar.items.count > self.locationIndexInTabBar) {
        UITabBarItem *item = [self.tabBar.items objectAtIndex:self.locationIndexInTabBar];
        item.title = nil;
        item.enabled = NO;
        UIView *view = [item valueForKey:@"view"];
        self.centerPoint = [self.tabBar.superview convertPoint:view.center fromView:self.tabBar];
        CGSize tabbBarSize = self.tabBar.frame.size;
        self.frame = CGRectMake(0, 0, tabbBarSize.height - 10, tabbBarSize.height - 10);
        self.center = view.center;
        self.layer.cornerRadius = self.frame.size.height/2;
        [self setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [self.tabBar addSubview:self];
        [self addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
        
        self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.tabBar.superview];
    }
}

- (void)buttonPressed{
    if (self.currentState == ALOptionsButtonStateNormal || self.currentState == ALOptionsButtonStateClosed) {
        _currentState = ALOptionsButtonStateOpened;
        [UIView animateWithDuration:0.2 animations:^{
            self.transform = CGAffineTransformRotate(self.transform, -M_PI_4);
        }];
        [self addBlackView];
        [self showOptions];
    }else{
        _currentState = ALOptionsButtonStateClosed;
        [UIView animateWithDuration:0.2 animations:^{
            self.transform = CGAffineTransformRotate(self.transform, M_PI_4);
        }];
        [self removeItems];
        [self removeBlackView];
    }
}

- (void)addBlackView{
    self.enabled = NO;
    self.blackView = [[UIView alloc] initWithFrame:self.tabBar.superview.bounds];
    self.blackView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin| UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    
    self.blackView.backgroundColor = [UIColor blackColor];
    self.blackView.alpha = 0.0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonPressed)];
    [self.blackView addGestureRecognizer:tap];
    
    [self.tabBar.superview addSubview:self.blackView];
    
    CGSize tabbBarSize = self.tabBar.frame.size;
    self.alterCenterButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, tabbBarSize.height - 10, tabbBarSize.height - 10)];
    self.alterCenterButton.center = self.centerPoint;
    self.alterCenterButton.layer.cornerRadius = self.alterCenterButton.frame.size.height/2;
    self.alterCenterButton.backgroundColor = [UIColor redColor];
    [self.alterCenterButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [self.alterCenterButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.blackView addSubview:self.alterCenterButton];
    
    [UIView animateWithDuration:0.2 animations:^{
        self.blackView.alpha = 0.7;
        self.alterCenterButton.transform = CGAffineTransformRotate(self.alterCenterButton.transform, -M_PI_4);
    } completion:^(BOOL finished) {
        if(finished){
            self.enabled = YES;
        }
    }];
}

- (void)removeBlackView{
    self.enabled = NO;
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.blackView.alpha = 0.0;
                         self.alterCenterButton.transform = CGAffineTransformRotate(self.alterCenterButton.transform, M_PI_4);
                     }
                     completion:^(BOOL finished) {
                         self.alterCenterButton = nil;
                         self.blackView = nil;
                         self.enabled = YES;
                     }];
}

- (ALOptionsItem *)createItemAtIndex:(NSUInteger)index{
    ALOptionsItem *item = nil;
    if ([self.delegate respondsToSelector:@selector(tabBar:itemAtIndex:)]) {
        item = [self.delegate tabBar:self.tabBar itemAtIndex:index];
        [item.button addTarget:self action:@selector(itemDidSelectedAtIndex:) forControlEvents:UIControlEventTouchUpInside];
    }
    return item;
}

- (void)showOptions{
    
    NSInteger numberOfItems = 0;
    if ([self.delegate respondsToSelector:@selector(alOptionsButtonNumberOfItems:)]) {
        numberOfItems = [self.delegate alOptionsButtonNumberOfItems:self];
    }
    
    CGFloat radious = 160;
    CGFloat averageAngel = 0.0;
    averageAngel = 140.0 / (numberOfItems + 1);
    for (int i = 0; i < numberOfItems; i ++) {
        CGFloat angel = (140.0 - averageAngel * (i + 1))/140.0 * M_PI;
        CGFloat buttonX = self.centerPoint.x + radious * cosf(angel);
        CGFloat buttonY = self.centerPoint.y - radious * sinf(angel);
        CGPoint buttonPoint = CGPointMake(buttonX, buttonY);
        
        ALOptionsItem *alOptionItem = [self createItemAtIndex:i];
        alOptionItem.center = self.centerPoint;
        [self.tabBar.superview addSubview:alOptionItem];
        
        UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:alOptionItem attachedToAnchor:buttonPoint];
        attachment.damping = 0.5;
        attachment.frequency = 4;
        attachment.length = 1;
        [self.animator addBehavior:attachment];
    
        [self.alOptionItems addObject:alOptionItem];
    }
}

- (void)removeItems{
    [self.animator removeAllBehaviors];
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         for (ALOptionsItem *item in self.alOptionItems) {
                             item.center = self.centerPoint;
                             item.alpha = 0.0;
                         }
                     } completion:^(BOOL finished) {
                         if (finished) {
                             for (UIView *item in self.alOptionItems) {
                                 [item removeFromSuperview];
                             }
                             [self.alOptionItems removeAllObjects];
                         }
                     }];
}

- (void)itemDidSelectedAtIndex:(UIButton *)item{
    
    [self buttonPressed];
    if ([self.delegate respondsToSelector:@selector(alOptionsButton:didSlectItem:)]) {
        [self.delegate alOptionsButton:self didSlectItem:(ALOptionsItem *)item.superview];
    }
}

@end
