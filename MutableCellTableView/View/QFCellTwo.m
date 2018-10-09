//
//  QFCellTwo.m
//  MutableCellTableView
//
//  Created by 情风 on 2018/9/19.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import "QFCellTwo.h"
#import "QFModeTwo.h"
#import "UIResponder+QFEventHandle.h"
@interface QFCellTwo ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *ageLabel;
@end

extern NSString *kEventTwoName;

@implementation QFCellTwo
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initAppreaence];
    }
    return self;
}

#pragma mark - InitAppreaence
- (void)initAppreaence {
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 12, 100, 20 )];
    self.nameLabel.textColor = [UIColor redColor];
    [self.contentView addSubview:self.nameLabel];
    
    self.ageLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 12, 100, 20 )];
    self.ageLabel.textColor = [UIColor redColor];
    self.ageLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.ageLabel];
    
}
#pragma mark - Configration
- (void)configCellDateByModel:(id<QFModelProtocol>)model{
    QFModeTwo *modelTwo = (QFModeTwo *)model;
    self.nameLabel.text = modelTwo.nameString;
    self.ageLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)modelTwo.age];
}

#pragma mark - Event Handle
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self routerEventWithName:kEventTwoName userInfo:@{@"keyTwo": @"valueTwo"}];
}


@end
