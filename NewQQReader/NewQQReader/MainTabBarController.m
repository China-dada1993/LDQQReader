
//
//  MainTabBarController.m
//  Case01_BookReader1126
//
//  Created by mac on 15/11/26.
//  Copyright (c) 2015年 WP. All rights reserved.
//

#import "MainTabBarController.h"

#import "BookFundViewController.h"
#import "BookLibraryViewController.h"
#import "BookSelectedViewController.h"
#import "BookStackViewController.h"

#import "ApplicationUiMetaData.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = YES;
    // Do any additional setup after loading the view.
    self.tabBar.tintColor = barBackgroundColor;
//    self.tabBar.barTintColor = [UIColor colorWithRed:85 / 255.f green:133 / 255.f blue:193 / 255.f alpha:1];
        // 所在与TabBarController相关的代码
    BookLibraryViewController *library = [[BookLibraryViewController alloc] init];
    library.tabBarItem.title = @"书架";
    library.tabBarItem.tag = 0;
    library.tabBarItem.image = [[UIImage imageNamed:@"tabbar_book_library"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    library.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_book_library_hl"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    BookSelectedViewController *selected = [[BookSelectedViewController alloc] init];
    selected.tabBarItem.title = @"精选";
    selected.tabBarItem.tag = 1;
    selected.tabBarItem.image = [[UIImage imageNamed:@"tabbar_book_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    selected.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_book_selected_hl"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    BookStackViewController *stack = [[BookStackViewController alloc] init];
    stack.tabBarItem.title = @"书库";
    stack.tabBarItem.tag = 2;
    stack.tabBarItem.image = [[UIImage imageNamed:@"tabbar_book_stack"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    stack.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_book_stack_hl"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    BookFundViewController *fund = [[BookFundViewController alloc] init];
    fund.tabBarItem.title = @"发现";
    fund.tabBarItem.image = [[UIImage imageNamed:@"tabbar_book_fund"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    fund.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_book_fund_hl"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    fund.tabBarItem.tag = 3;
    
    self.viewControllers = @[library, selected, stack, fund];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
