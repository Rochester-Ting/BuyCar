//
//  haveGoodsView.m
//  xpet
//
//  Created by 丁瑞瑞 on 21/7/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "haveGoodsView.h"
#import "BuyCarCell.h"
#import "MJExtension.h"
#import "buyCarItem.h"
#import "UIView+Frame.h"

@interface haveGoodsView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *moneyBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftSelectedBtn;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;
/** 总价*/
@property (nonatomic,assign) NSInteger totalPrice;
/******模型数组****/
@property (nonatomic,strong) NSMutableArray *catArrM;
//记录被选中的cell的indexPath
@property (nonatomic ,strong)NSMutableArray *seletedIndexPaths;
/******记录被选中的cell的模型****/
@property (nonatomic,strong) NSMutableArray *selectedBuyCarItem;
@end
@implementation haveGoodsView
NSString *buyCarID = @"BuyCarID";
- (NSMutableArray *)seletedIndexPaths
{
    if (!_seletedIndexPaths) {
        _seletedIndexPaths = [NSMutableArray array];
    }
    return _seletedIndexPaths;
}
- (NSMutableArray *)selectedBuyCarItem{
    if (!_selectedBuyCarItem) {
        _selectedBuyCarItem = [NSMutableArray array];
    }
    return _selectedBuyCarItem;
}
- (NSMutableArray *)catArrM{
    if (!_catArrM) {
        _catArrM = [buyCarItem mj_objectArrayWithFilename:@"wine.plist"];
    }
    return _catArrM;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setTable];
    [self setSelect];
    
}
#pragma mark - setSelect -- 设置选中圈
- (void)setSelect{
    self.leftSelectedBtn.layer.cornerRadius = self.leftSelectedBtn.rr_width * 0.5;
    [self.leftSelectedBtn addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    [self.selectBtn addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 实现全选按钮的监听方法
- (void)tap{
    self.leftSelectedBtn.selected = !self.leftSelectedBtn.selected;
    self.totalPrice = 0;
//    取出模型
    for (buyCarItem *item in self.catArrM) {
//        设置按钮的选中状态
        item.isSelected = self.leftSelectedBtn.selected;
        item.isLeftBtnSelected = self.leftSelectedBtn.selected;
        [self caculatePrice:item];
        
    }
    if (self.leftSelectedBtn.selected) {
        
        //        重新计算价格
        NSString *money = [NSString stringWithFormat:@"需支付不含运费:¥%zd",self.totalPrice];
        [self.moneyBtn setTitle:money forState:UIControlStateNormal];
    }else{
        [self.seletedIndexPaths removeAllObjects];
        
        self.totalPrice = 0;
        [self.moneyBtn setTitle:@"需支付不含运费:¥0" forState:UIControlStateNormal];
    }
    
    [self.tableView reloadData];
}
#pragma mark - 重新计算价格
- (void)caculatePrice:(buyCarItem *)item{
//    取出所有的模型计算价格
    
    self.totalPrice += item.money.integerValue;
    
}
#pragma mark - setTable
- (void)setTable{
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BuyCarCell class]) bundle:nil] forCellReuseIdentifier:buyCarID];
//    设置模型默认的数量为1,默认选中状态为0
    for (buyCarItem *item in self.catArrM) {
        item.count = 1;
        item.isSelected = NO;
    }
}
/**去支付按钮**/
- (IBAction)payClick:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"去结算"]) {
        NSLog(@"去支付");
    }else if([sender.titleLabel.text isEqualToString:@"删除"]){
//        获取要删除的模型
        NSMutableArray *deleteArr = [NSMutableArray array];
        for (NSIndexPath *indexPath in self.seletedIndexPaths) {
            [deleteArr addObject:self.catArrM[indexPath.row]];
        }
//        删除模型
        [self.catArrM removeObjectsInArray:deleteArr];
//        刷新tableView,设置总价为0
        [UIView animateWithDuration:1 animations:^{
            //        刷新表格
            [self.tableView deleteRowsAtIndexPaths:self.seletedIndexPaths withRowAnimation:UITableViewRowAnimationLeft];
            [self.seletedIndexPaths removeAllObjects];
            [self.tableView reloadData];
        } completion:^(BOOL finished) {
            
            self.totalPrice = 0;
            [self.moneyBtn setTitle:@"需支付不含运费:¥0" forState:UIControlStateNormal];
        }];
        if (self.leftSelectedBtn.selected) {
            [UIView animateWithDuration:0.25 animations:^{
                [self.catArrM removeAllObjects];
                [self.tableView reloadData];
            } completion:^(BOOL finished) {
                self.leftSelectedBtn.selected = NO;
            }];
            
        }
        
    }
}
/**编辑按钮点击事件**/
- (IBAction)editClick:(UIButton *)sender {
    self.moneyBtn.hidden = !self.editBtn.selected;
//    self.payBtn.selected = !self.payBtn.selected;
    self.editBtn.selected = !self.editBtn.selected;
    if (sender.selected) {
        [self.payBtn setTitle:@"删除" forState:UIControlStateNormal];
    }else{
        [self.payBtn setTitle:@"去结算" forState:UIControlStateNormal];
    }
}
#pragma mark - self.tableView.dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.catArrM.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuyCarCell *cell = [tableView dequeueReusableCellWithIdentifier:buyCarID];
    cell.buyCarItem = self.catArrM[indexPath.row];
//    计算价格
    cell.priceBlock = ^(NSString *price,NSInteger isSelcted){
        NSString *sePrice = [price componentsSeparatedByString:@"¥"].lastObject;
        NSInteger priceBNum = sePrice.integerValue;
        if (isSelcted) {
//            如果被选中
            _totalPrice = _totalPrice + priceBNum;
            [self.seletedIndexPaths addObject:indexPath];
        }else{
//            如果没被选中
            _totalPrice = _totalPrice - priceBNum;
            self.leftSelectedBtn.selected = NO;
            [self.seletedIndexPaths removeObject:indexPath];
        }
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        NSString *money = [NSString stringWithFormat:@"需支付不含运费:¥%zd",_totalPrice];
        [self.moneyBtn setTitle:money forState:UIControlStateNormal];
    };
    cell.selectBlock = ^(NSString *str){
//        遍历数据源数组
        int index = 0;
        for (buyCarItem *item in self.catArrM) {
            if (item.isSelected) {
                index++;
            }
        }
        if (index == self.catArrM.count) {
            self.leftSelectedBtn.selected = YES;
        }
    };
    return cell;
}
#pragma mark - self.tableView.delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
//左滑删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    //    取出模型
    buyCarItem *item = self.catArrM[indexPath.row];
//    删除数据模型
    [self.catArrM removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    if (item.isSelected) {
        self.totalPrice -= item.money.integerValue;
        NSString *money = [NSString stringWithFormat:@"需支付不含运费:¥%zd",_totalPrice];
        [self.moneyBtn setTitle:money forState:UIControlStateNormal];
    }
    
//    [self.tableView reloadData];
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
@end
