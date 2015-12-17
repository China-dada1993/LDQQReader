//
//  headView.h
//  Case01_BookReader1126
//
//  Created by qianfeng on 15/11/28.
//  Copyright (c) 2015年 WP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface headView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *bookTitle;
@property (weak, nonatomic) IBOutlet UILabel *bookScore;
@property (weak, nonatomic) IBOutlet UILabel *wordAndChapCount;
@property (weak, nonatomic) IBOutlet UILabel *detailmsg;
@property (weak, nonatomic) IBOutlet UILabel *intro;

@end
