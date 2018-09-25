//
//  ModelOne.h
//  MutableCellTableView
//
//  Created by 情风 on 2018/9/19.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QFModelProtocol.h"

@interface QFModelOne : NSObject <QFModelProtocol>

@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, copy) NSString *subTitleString;

@end
