//
//  ModeTwo.h
//  MutableCellTableView
//
//  Created by 情风 on 2018/9/19.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QFModelProtocol.h"

@interface QFModeTwo : NSObject<QFModelProtocol>

@property (nonatomic, copy) NSString *nameString;
@property (nonatomic, assign) NSUInteger age;

@end
