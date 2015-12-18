//
//  AdsContentViewController.h
//  NewQQReader
//
//  Created by qianfeng on 15/12/14.
//  Copyright © 2015年 刘达. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdsContentViewController : UIViewController
@property (nonatomic, strong) UILabel *lblDesc;
@property (nonatomic, strong) UILabel *lblTitle;
@property (nonatomic, strong) UILabel *lblIntro;
@property (nonatomic, strong) UIImageView *bookImageView;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) int currentIndex;

- (void)setDesc:(NSString *)desc title:(NSString *)title intro:(NSString *)intro bookImageName:(NSString *)imageName;
@end
