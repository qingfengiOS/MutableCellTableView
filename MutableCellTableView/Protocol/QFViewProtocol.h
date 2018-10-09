//
//  QFViewProtocol.h
//  MutableCellTableView
//
//  Created by 情风 on 2018/9/19.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QFModelProtocol.h"

/**
 协议用于保存每个cell的数据源设置方法，也可以不用，直接在每个类型的cell头文件中定义，考虑到开放封闭原则，建议使用
 */
@protocol QFViewProtocol <NSObject>

/**
 通过model 配置cell展示

 @param model model
 */
- (void)configCellDateByModel:(id<QFModelProtocol>)model;

@end
