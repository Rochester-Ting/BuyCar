//
//  BuyCarCell.h
//  xpet
//
//  Created by 丁瑞瑞 on 21/7/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <UIKit/UIKit.h>
@class buyCarItem;
@interface BuyCarCell : UITableViewCell
/** 记录选中以后的价格*/
@property (nonatomic,copy) void(^priceBlock)(NSString *price,NSInteger isSelected);
//如果是全选那么让所有的cell添加到被选中的数组中
@property (nonatomic,copy) void(^selectBlock)(NSString *str);
/** 模型*/
@property (nonatomic,strong) buyCarItem *buyCarItem;
@end
