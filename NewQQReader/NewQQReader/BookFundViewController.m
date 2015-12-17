//
//  BookFundViewController.m
//  Case01_BookReader
//
//  Created by 李海龙 on 15/11/23.
//  Copyright © 2015年 北京千锋互联科技有限公司（大连）. All rights reserved.
//

#import "BookFundViewController.h"

@interface BookFundViewController ()

@end

@implementation BookFundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor blueColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    }
- (void)viewDidAppear:(BOOL)animated {
    self.parentViewController.navigationItem.title = @"发现";
}

- (void)viewWillDisappear:(BOOL)animated{
    self.parentViewController.navigationItem.title = nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
