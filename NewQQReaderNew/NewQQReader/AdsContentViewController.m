//
//  AdsContentViewController.m
//  NewQQReader
//
//  Created by qianfeng on 15/12/14.
//  Copyright © 2015年 刘达. All rights reserved.
//

#import "AdsContentViewController.h"
#import "CommenDataDefine.h"
#import <UIImageView+WebCache.h>

@interface AdsContentViewController ()

@end

@implementation AdsContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        CGFloat marginX = 15;
        CGFloat marginY = 10;
        self.lblDesc = [[UILabel alloc] init];
        self.lblIntro = [[UILabel alloc] init];
        self.lblTitle = [[UILabel alloc] init];
        self.bookImageView = [[UIImageView alloc] init];
        
        self.lblDesc.font = [UIFont systemFontOfSize:25];
        self.lblTitle.font = [UIFont systemFontOfSize:20];
        self.lblIntro.font = [UIFont systemFontOfSize:16];
        
        [self.view addSubview:self.lblTitle];
        [self.view addSubview:self.lblIntro];
        [self.view addSubview:self.lblDesc];
        [self.view addSubview:self.bookImageView];
        
        self.lblIntro.textColor = [UIColor colorWithRed:162 / 255.f green:197 / 255.f blue:236 / 255.f alpha:1];
        self.lblDesc.textColor = [UIColor whiteColor];
        self.lblTitle.textColor = [UIColor whiteColor];
        
        CGFloat descW = SIZE.width / 3.0 * 2 - marginX;
        CGFloat descH = 50;
        self.lblDesc.frame = CGRectMake(marginX, marginY, descW, descH);
        
        self.lblTitle.frame = CGRectMake(marginX, CGRectGetMaxY(self.lblDesc.frame), descW, descH);
        
        UILabel *lineLable = [[UILabel alloc] init];
        lineLable.frame = CGRectMake(marginX, CGRectGetMaxY(self.lblTitle.frame), descW, 0.5);
        
        lineLable.backgroundColor = [UIColor colorWithRed:146 / 255.f green:169 / 255.f blue:193 / 255.f alpha:1];
        [self.view addSubview:lineLable];

        
        self.lblIntro.frame = CGRectMake(marginX, CGRectGetMaxY(lineLable.frame), descW, descH);
        
        
        CGFloat imageViewW = SIZE.width / 3.0 - marginX;
        self.bookImageView.frame = CGRectMake(CGRectGetMaxX(self.lblTitle.frame), marginY, imageViewW, 3 * descH);
    }
    return self;
}

- (void)setDesc:(NSString *)desc title:(NSString *)title intro:(NSString *)intro bookImageName:(NSString *)imageName {
    self.lblDesc.text = desc;
    self.lblTitle.text = title;
    self.lblIntro.text = intro;
    [self.bookImageView sd_setImageWithURL:[NSURL URLWithString:imageName]];
}

@end
