//
//  QFModelProtocol.h
//  MutableCellTableView
//
//  Created by 情风 on 2018/9/19.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QFModelProtocol <NSObject>
@optional
- (NSString *)identifier;
- (CGFloat)height;
@end