//
//  ViewModel.h
//  MutableCellTableView
//
//  Created by 情风 on 2018/9/19.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QFModelProtocol.h"

@interface QFViewModel : NSObject

- (NSInteger)numberOfRowsInSection:(NSInteger)section;

- (id<QFModelProtocol>)tableView:(UITableView *)tableView itemForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
