//
//  QFViewProtocol.h
//  MutableCellTableView
//
//  Created by 情风 on 2018/9/19.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QFModelProtocol.h"
#import "QFEventProtocol.h"

@protocol QFViewProtocol <NSObject>

/**
 通过model 配置cell展示

 @param model model
 */
- (void)configCellDateByModel:(id<QFModelProtocol>)model;
@end
