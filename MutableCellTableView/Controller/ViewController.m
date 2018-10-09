//
//  ViewController.m
//  MutableCellTableView
//
//  Created by 情风 on 2018/9/19.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import "ViewController.h"
#import "QFDetailViewController.h"

#import "QFViewModel.h"

#import "UIResponder+QFEventHandle.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/// ViewModel
@property (nonatomic, strong) QFViewModel *viewModel;

/// 事件策略字典 key:事件名 value:事件的invocation对象
@property (nonatomic, strong) NSDictionary *eventStrategy;

@end

NSString *const kEventOneName = @"QFCellOneEvent";
NSString *const kEventTwoName = @"QFCellTwoEvent";

@implementation ViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initAppreaence];
}

#pragma mark - InitAppreaence
- (void)initAppreaence {
    [self.view addSubview:self.viewModel.tableView];
}

#pragma mark - Event Response
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    // 处理事件
    [self handleEventWithName:eventName parameter:userInfo];
    
    // 把响应链继续传递下去
    [super routerEventWithName:eventName userInfo:userInfo];
}

- (void)handleEventWithName:(NSString *)eventName parameter:(NSDictionary *)parameter {
    // 获取invocation对象
    NSInvocation *invocation = self.strategyDictionary[eventName];
    // 设置invocation参数
    [invocation setArgument:&parameter atIndex:2];
    // 调用方法
    [invocation invoke];
}

- (void)cellOneEventWithParamter:(NSDictionary *)paramter {
    NSLog(@"第一种cell事件---------参数：%@",paramter);
    QFDetailViewController *viewController = [QFDetailViewController new];
    viewController.typeName = @"Cell类型一";
    viewController.paramterDic = paramter;
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)cellTwoEventWithParamter:(NSDictionary *)paramter {
    NSLog(@"第二种cell事件---------参数：%@",paramter);
    QFDetailViewController *viewController = [QFDetailViewController new];
    viewController.typeName = @"Cell类型二";
    viewController.paramterDic = paramter;
    [self presentViewController:viewController animated:YES completion:nil];
}


#pragma mark - Getters
- (QFViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = QFViewModel.new;
    }
    return _viewModel;
}

- (NSDictionary <NSString *, NSInvocation *>*)strategyDictionary {
    if (!_eventStrategy) {
        _eventStrategy = @{
                           kEventOneName:[self createInvocationWithSelector:@selector(cellOneEventWithParamter:)],
                           kEventTwoName:[self createInvocationWithSelector:@selector(cellTwoEventWithParamter:)]
                           };
    }
    return _eventStrategy;
}
@end
