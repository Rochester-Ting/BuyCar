//
//  RRTabBarVC.m
//  BuyCar
//
//  Created by xpet on 16/7/28.
//  Copyright © 2016年 xpet. All rights reserved.
//

#import "RRTabBarVC.h"
#import "ViewController.h"
@interface RRTabBarVC ()

@end

@implementation RRTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    ViewController *vc = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = @"购物车";
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
