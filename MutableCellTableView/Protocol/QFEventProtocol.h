//
//  QFEventProtocol.h
//  MutableCellTableView
//
//  Created by 情风 on 2018/9/19.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^HandleEventBlock)(NSDictionary *params, NSString *identifier);

@protocol QFEventProtocol <NSObject>

// 用于传递事件（identifier用于标记是哪一个事件， params为需传参数）
- (void)handleEvent:(HandleEventBlock)block;

@end
