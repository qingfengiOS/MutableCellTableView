//
//  QFCellOne.m
//  MutableCellTableView
//
//  Created by 情风 on 2018/9/19.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import "QFCellOne.h"
#import "QFModelOne.h"
#import "UIResponder+QFEventHandle.h"

@interface QFCellOne ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subLabel;
@end

@implementation QFCellOne

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initAppreaence];
    }
    return self;
}


#pragma mark - InitAppreaence
- (void)initAppreaence {
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20 )];
    self.titleLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:self.titleLabel];
    
    self.subLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, 100, 20 )];
    self.subLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:self.subLabel];
}

#pragma mark - Configration
- (void)configCellDateByModel:(id<QFModelProtocol>)model{
    QFModelOne *modelOne = (QFModelOne *)model;
    self.titleLabel.text = modelOne.titleString;
    self.subLabel.text = modelOne.subTitleString;
}

#pragma mark - Event Handle
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self routerEventWithName:@"QFCellOne" userInfo:@{@"key": @"value"}];
}

- (void)handleEvent:(HandleEventBlock)block{
    
}

@end
