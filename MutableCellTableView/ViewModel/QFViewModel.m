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

#import "QFCellOne.h"
#import "QFCellTwo.h"

@interface QFViewModel ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSArray *dataArray;//数据源数组
@end

@implementation QFViewModel

static NSString *const kCellOneIdentifier = @"QFCellOne";
static NSString *const kCellTwoIdentifier = @"QFCellTwo";

#pragma mark - Life Cycle
- (instancetype)init {
    if (self = [super init]) {
        [self initDataSource];
        [self initAppreaence];
    }
    return self;
}

#pragma mark - InitAppreaence
- (void)initAppreaence {
    [self.tableView registerClass:[QFCellOne class] forCellReuseIdentifier:kCellOneIdentifier];
    [self.tableView registerClass:[QFCellTwo class] forCellReuseIdentifier:kCellTwoIdentifier];
}

#pragma mark - InitDataSource
- (void)initDataSource {
    QFModelOne *modelOne = [QFModelOne new];
    QFModeTwo *modelTwo = [QFModeTwo new];
    self.dataArray = @[modelOne,modelTwo,modelOne,modelTwo,modelTwo,modelOne];
}

#pragma mark - TableViewDelegate/dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<QFModelProtocol> model = self.dataArray[indexPath.row];
    id<QFViewProtocol> cell = [tableView dequeueReusableCellWithIdentifier:model.identifier];
    [cell configCellDateByModel:model];
    return (UITableViewCell *)cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<QFModelProtocol> model = self.dataArray[indexPath.row];
    return model.height;
}


#pragma mark - Getters
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}


@end
