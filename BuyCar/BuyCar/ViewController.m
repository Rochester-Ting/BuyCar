//
//  ViewController.m
//  BuyCar
//
//  Created by xpet on 16/7/28.
//  Copyright © 2016年 xpet. All rights reserved.
//

#import "ViewController.h"
#import "RRBuyCar/UIView+RRLoad.h"
#import "RRBuyCar/haveGoodsView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"购物车";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    haveGoodsView *havegoodsView = [haveGoodsView loadWithXib];
    havegoodsView.frame = [UIScreen mainScreen].bounds;
    [self.view addSubview:havegoodsView];
}



@end
