//
//  buyCarItem.h
//  xpet
//
//  Created by 丁瑞瑞 on 21/7/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface buyCarItem : NSObject

/** 记录是否被选中*/
@property (nonatomic,assign) BOOL isSelected;
/******image****/
@property (nonatomic,strong) NSString *image;
/******name****/
@property (nonatomic,strong) NSString *name;
/******money****/
@property (nonatomic,strong) NSString *money;
/******count****/
@property (nonatomic,assign) int count;
/******记录leftButton是否被选中****/
@property (nonatomic,assign) BOOL isLeftBtnSelected;
@end
