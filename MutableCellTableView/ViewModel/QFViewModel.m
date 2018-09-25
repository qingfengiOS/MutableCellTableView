//
//  ViewModel.m
//  MutableCellTableView
//
//  Created by 情风 on 2018/9/19.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import "QFViewModel.h"
#import "QFModelOne.h"
#import "QFModeTwo.h"

@implementation QFViewModel
@synthesize dataArray;

#pragma mark - Life Cycle
- (instancetype)init {
    if (self = [super init]) {
        QFModelOne *modelOne = [QFModelOne new];
        QFModeTwo *modelTwo = [QFModeTwo new];
        self.dataArray = @[modelOne,modelOne,modelOne,modelTwo];
    }
    return self;
}

- (NSInteger)numberOfSections {
    return 1;
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (id<QFModelProtocol>)modelForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.dataArray[indexPath.row];
}
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<QFModelProtocol> model = self.dataArray[indexPath.row];
    return model.height;
}


@end
