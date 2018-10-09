//
//  QFDetailViewController.h
//  MutableCellTableView
//
//  Created by 李一平 on 2018/10/9.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QFDetailViewController : UIViewController

/// 类型
@property (nonatomic, copy) NSString *typeName;

/// 参数
@property (nonatomic, strong) NSDictionary *paramterDic;

@end
