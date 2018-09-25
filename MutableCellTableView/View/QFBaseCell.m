//
//  BaseCell.m
//  MutableCellTableView
//
//  Created by 情风 on 2018/9/19.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import "QFBaseCell.h"

@implementation QFBaseCell

#pragma mark - 抽象类 具体实现交给子类
- (void)configCellDateByModel:(id<QFModelProtocol>)model{
    
}

- (void)handleEvent:(HandleEventBlock)block{
    
}

@end
