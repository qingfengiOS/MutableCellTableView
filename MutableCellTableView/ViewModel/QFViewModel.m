//
//  ViewModel.m
//  MutableCellTableView
//
//  Created by 情风 on 2018/9/19.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import "QFViewModel.h"

#import "QFModelOne.h"
#import "QFModeTwo.h"

@interface QFViewModel ()
@property (nonatomic, strong) NSArray *dataArray;//数据源数组
@end

@implementation QFViewModel

#pragma mark - Life Cycle
- (instancetype)init {
    if (self = [super init]) {
        [self initDataSource];
    }
    return self;
}

#pragma mark - InitDataSource
- (void)initDataSource {
    QFModelOne *modelOne = [QFModelOne new];
    QFModeTwo *modelTwo = [QFModeTwo new];
    self.dataArray = @[modelOne,modelTwo,modelOne,modelTwo,modelTwo,modelOne];
}

#pragma mark - TableViewDelegate/dataSource
- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (id<QFModelProtocol>)tableView:(UITableView *)tableView itemForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<QFModelProtocol> model = self.dataArray[indexPath.row];
    return model;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<QFModelProtocol> model = self.dataArray[indexPath.row];
    return model.height;
}



@end
