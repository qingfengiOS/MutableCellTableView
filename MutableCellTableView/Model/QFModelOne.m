//
//  ModelOne.m
//  MutableCellTableView
//
//  Created by 情风 on 2018/9/19.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import "QFModelOne.h"

@implementation QFModelOne

- (NSString *)titleString {
    return @"标题";
}

- (NSString *)subTitleString {
    return @"副标题";
}


- (NSString *)identifier {
    return @"QFCellOne";
}

- (CGFloat)height {
    return 65.0f;
}
@end
