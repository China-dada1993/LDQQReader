//
//  TopicHeadView.m
//  NewQQReader
//
//  Created by qianfeng on 15/12/17.
//  Copyright © 2015年 刘达. All rights reserved.
//

#import "TopicHeadView.h"
/*
 @property (nonatomic, strong) UILabel *introLable;
 @property (nonatomic, strong) UILabel *titleLable;
 @property (nonatomic, strong) UILabel *readCntLable;
 @property (nonatomic, strong) UILabel *createTimeLable;
 @property (nonatomic, strong) UIImageView *backGroudImageView;

 */
@implementation TopicHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backGroudImageView = [[UIImageView alloc] initWithFrame:self.frame];
        [self addSubview:self.backGroudImageView];
        
        CGFloat marginX = 5;
        CGFloat marginY = 10;
        CGFloat titleW = 180;
        CGFloat titleH = 30;
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(marginX, marginY, titleW, titleH)];
        self.titleLable.textColor = [UIColor whiteColor];
        self.titleLable.font = [UIFont systemFontOfSize:20];
        [self addSubview:self.titleLable];
        
        self.createTimeLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLable.frame), marginY, titleW / 2, titleH / 2.0)];
        self.createTimeLable.textColor = [UIColor whiteColor];
        self.createTimeLable.font = [UIFont systemFontOfSize:10];
        [self addSubview:self.createTimeLable];
        
        self.readCntLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLable.frame), CGRectGetMaxY(self.createTimeLable.frame), titleW /2 , titleH / 2.0)];
        self.readCntLable.font = [UIFont systemFontOfSize:10];
        
        self.readCntLable.textColor = [UIColor whiteColor];
        
        [self addSubview:self.readCntLable];
        
        self.introLable = [[UILabel alloc] initWithFrame:CGRectMake(marginX, CGRectGetMaxY(self.titleLable.frame), titleW * 2, titleH)];
        self.introLable.font = [UIFont systemFontOfSize:12];
        self.introLable.textColor = [UIColor whiteColor];
        [self addSubview:self.introLable];
        
                
    }
    return self;
}

@end
