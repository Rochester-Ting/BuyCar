//
//  BuyCarCell.m
//  xpet
//
//  Created by 丁瑞瑞 on 21/7/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "BuyCarCell.h"
#import "buyCarItem.h"
#import "UIView+Frame.h"
#import "UIImageView+WebCache.h"
@interface BuyCarCell ()
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIImageView *catImageView;
@property (weak, nonatomic) IBOutlet UILabel *shopName;
@property (weak, nonatomic) IBOutlet UIButton *minusBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end
@implementation BuyCarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectBtn.layer.cornerRadius = self.selectBtn.rr_width * 0.5;
    self.minusBtn.layer.cornerRadius = self.minusBtn.rr_width * 0.5;
    self.addBtn.layer.cornerRadius = self.addBtn.rr_width * 0.5;
    self.minusBtn.layer.borderWidth = 1;
    self.addBtn.layer.borderWidth = 1;
    self.minusBtn.enabled = NO;
    self.addBtn.enabled = NO;
//    self.buyCarItem.count = 1;
//    self.numLabel.text = @"1";
}
- (IBAction)minusClick:(id)sender {
    NSInteger num = self.numLabel.text.integerValue;
    num--;
    self.numLabel.text = [NSString stringWithFormat:@"%zd",num];
//    修改模型
    self.buyCarItem.count--;
    self.minusBtn.enabled = self.numLabel.text.integerValue > 1;
}
- (IBAction)addClick:(id)sender {
    NSInteger num = self.numLabel.text.integerValue;
    num++;
//    修改模型
    self.buyCarItem.count++;
    self.numLabel.text = [NSString stringWithFormat:@"%zd",num];
    self.minusBtn.enabled = self.numLabel.text.integerValue > 1;
}
- (IBAction)selectClick:(id)sender {
//    记录按钮的选中状态,改变模型数据
    self.buyCarItem.isSelected = !self.buyCarItem.isSelected;
//    改变按钮的选中状态
    self.selectBtn.selected = !self.selectBtn.selected;
    if (self.selectBtn.selected == 1) {
        if (_priceBlock) {
            _priceBlock(self.priceLabel.text,1);
        }
    }else{
        if (_priceBlock) {
            _priceBlock(self.priceLabel.text,0);
        }
    }
    
  
    
    if (_selectBlock) {
        
        _selectBlock(@"选中");
    }
    
}

- (void)setBuyCarItem:(buyCarItem *)buyCarItem
{
    _buyCarItem = buyCarItem;
    self.selectBtn.selected = buyCarItem.isSelected;

    NSURL *url = [NSURL URLWithString:buyCarItem.image];
    [self.catImageView sd_setImageWithURL:url];
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",buyCarItem.money];
    self.numLabel.text = [NSString stringWithFormat:@"%zd",_buyCarItem.count];
    self.shopName.text = buyCarItem.name;
}
@end
