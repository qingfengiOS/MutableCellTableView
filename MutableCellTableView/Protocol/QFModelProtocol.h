//
//  QFModelProtocol.h
//  MutableCellTableView
//
//  Created by 情风 on 2018/9/19.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 协议用于保存每个model对应cell的重用标志符和行高，也可以不使用这个协议 直接在对一个的model里指明
 */
@protocol QFModelProtocol <NSObject>

- (NSString *)identifier;

- (CGFloat)height;

@end
