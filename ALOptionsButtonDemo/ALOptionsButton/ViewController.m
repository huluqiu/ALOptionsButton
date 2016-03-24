//
//  ViewController.m
//  ALOptionsButton
//
//  Created by alezai on 15/9/22.
//  Copyright © 2015年 alezai. All rights reserved.
//

#import "ViewController.h"
#import "ALOptionsButton.h"

@interface ViewController () <ALOptionsButtonDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ALOptionsButton *button = [[ALOptionsButton alloc] initForTabBar:self.tabBar forItemIndex:2 delegate:self];
    button.backgroundColor = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ALOptionsButtonDelegate
- (NSUInteger)alOptionsButtonNumberOfItems:(ALOptionsButton *)alOptionsButton{
    return 2;
}

- (ALOptionsItem *)tabBar:(UITabBar *)tabBar itemAtIndex:(NSUInteger)index{
    ALOptionsItem *item = [[ALOptionsItem alloc] initWithIndex:index];
    if (index == 0) {
        [item setImage:[UIImage imageNamed:@"green"]];
        [item setTitle:@"green"];
    }else if (index == 1){
        [item setImage:[UIImage imageNamed:@"orange"]];
        [item setTitle:@"orange"];
    }
    return item;
}

- (void)alOptionsButton:(ALOptionsButton *)alOptionsButton didSlectItem:(ALOptionsItem *)item{
    NSLog(@"you select button at %lu",item.index);
}

@end
