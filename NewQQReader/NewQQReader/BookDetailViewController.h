//
//  BookDetailViewController.h
//  Case01_BookReader1126
//
//  Created by qianfeng on 15/11/28.
//  Copyright (c) 2015年 WP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookModel.h"
#import "headView.h"
#import "SelectBookModel.h"

@interface BookDetailViewController : UIViewController
@property (nonatomic, strong) headView *bookHeadView;
@property (nonatomic, strong) BookModel *model;
@property (nonatomic, strong) SelectBookModel *selectModel;
@end
