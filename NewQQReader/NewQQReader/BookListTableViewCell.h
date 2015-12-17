//
//  BookListTableViewCell.h
//  Case01_BookReader
//
//  Created by qianfeng on 15/11/27.
//  Copyright (c) 2015年 北京千锋互联科技有限公司（大连）. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *intro;
@property (weak, nonatomic) IBOutlet UILabel *showPrice;
@property (weak, nonatomic) IBOutlet UILabel *sortValue;

@end
