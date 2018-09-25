//
//  ViewController.m
//  MutableCellTableView
//
//  Created by 情风 on 2018/9/19.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import "ViewController.h"

#import "QFCellOne.h"
#import "QFCellTwo.h"

#import "QFViewModel.h"

#import "QFViewProtocol.h"

#import "UIResponder+QFEventHandle.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) QFViewModel *viewModel;
@end
static NSString *const kCellOneIdentifier = @"QFCellOne";
static NSString *const kCellTwoIdentifier = @"QFCellTwo";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initAppreaence];
    
}

#pragma mark - InitAppreaence
- (void)initAppreaence {
    [self.tableView registerClass:[QFCellOne class] forCellReuseIdentifier:kCellOneIdentifier];
    [self.tableView registerClass:[QFCellTwo class] forCellReuseIdentifier:kCellTwoIdentifier];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.viewModel numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<QFModelProtocol> model = [self.viewModel modelForRowAtIndexPath:indexPath];
    id<QFViewProtocol> cell = [tableView dequeueReusableCellWithIdentifier:model.identifier];
    [cell configCellDateByModel:model];
    return (UITableViewCell *)cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.viewModel heightForRowAtIndexPath:indexPath];
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    [self handleEventWithName:eventName parameter:userInfo];
    
    // ？？？？？
    [super routerEventWithName:eventName userInfo:userInfo];
}

- (void)handleEventWithName:(NSString *)eventName parameter:(NSDictionary *)parameter {
    if ([eventName isEqualToString:@"QFCellOne"]) {
        NSLog(@"~~~~~~~~~QFCellOne~~~~~~~~~\n paramter: %@",parameter);
    }
    
    if ([eventName isEqualToString:@"QFCellTwo"]) {
        NSLog(@"~~~~~~~~~QFCellTwo~~~~~~~~~\n paramter: %@",parameter);
    }
}

#pragma mark - Getters
- (QFViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = QFViewModel.new;
    }
    return _viewModel;
}
@end
