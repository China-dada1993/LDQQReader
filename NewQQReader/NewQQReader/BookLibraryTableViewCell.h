//
//  BookLibraryTableViewCell.h
//  Case01_BookReader1126
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 WP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookLibraryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;
@property (weak, nonatomic) IBOutlet UILabel *bookTitleLable;
@property (weak, nonatomic) IBOutlet UILabel *bookLastCnameLable;

@end
