//
//  QFDetailViewController.m
//  MutableCellTableView
//
//  Created by 李一平 on 2018/10/9.
//  Copyright © 2018年 qingfengiOS. All rights reserved.
//

#import "QFDetailViewController.h"

@interface QFDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UITextView *paramterTextView;
@end

@implementation QFDetailViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.typeLabel.text = self.typeName;
    self.paramterTextView.text = [self dictionaryToString:self.paramterDic];
}


#pragma mark - Event Response
- (IBAction)closeButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - CustomMethod
- (NSString*)dictionaryToString:(NSDictionary *)parameter {
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameter options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
