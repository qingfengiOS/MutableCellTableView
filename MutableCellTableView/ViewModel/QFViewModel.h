//
//  ViewModel.h
//  MutableCellTableView
//
//  Created by 情风 on 2018/9/19.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFViewModel : NSObject

/// 暴露一个tableView的属性 提供Controller使用
@property (nonatomic, strong) UITableView *tableView;

@end
