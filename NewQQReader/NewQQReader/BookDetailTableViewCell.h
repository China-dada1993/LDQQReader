//
//  BookDetailTableViewCell.h
//  NewQQReader
//
//  Created by qianfeng on 15/12/14.
//  Copyright © 2015年 刘达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *bookWordCountLable;
@property (weak, nonatomic) IBOutlet UILabel *bookCatel3NameLable;
@property (weak, nonatomic) IBOutlet UILabel *bookCatel2NameLable;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthorLable;
@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;
@property (weak, nonatomic) IBOutlet UILabel *bookTitleLable;
@property (weak, nonatomic) IBOutlet UILabel *bokkDescLable;

@end
