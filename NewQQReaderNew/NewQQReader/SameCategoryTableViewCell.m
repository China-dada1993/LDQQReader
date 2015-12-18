//
//  SameCategoryTableViewCell.m
//  Case01_BookReader1126
//
//  Created by qianfeng on 15/11/29.
//  Copyright (c) 2015年 WP. All rights reserved.
//

#import "SameCategoryTableViewCell.h"
#import "SameCategoryView.h"
#import "SameCategoryModel.h"
#import "UIImageView+WebCache.h"

@implementation SameCategoryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createSameCategoryView];
    }
    return self;
}


- (void)createSameCategoryView
{
    int  count = 4;
    CGFloat marginX = 3;
    CGFloat marginY = 5;
    CGFloat cellH = self.frame.size.height;
    CGFloat cellW = 375;
    CGFloat subViewH = cellH - 2 * marginY;
    CGFloat subViewW = (cellW - (count + 1) * marginX) / count;
    
    for (int i = 0; i < count; i ++) {
        SameCategoryView *bookView = [[[NSBundle mainBundle] loadNibNamed:@"SameCategoryView" owner:self options:nil] lastObject];
        bookView.tag = 500 + i;
        bookView.frame = CGRectMake(marginX + (marginX + subViewW) * i, marginY, subViewW, subViewH);
        [self addSubview:bookView];
    }
}
- (void)setSameCategoryModelList:(NSArray *)sameCategoryModelList
{
    _sameCategoryModelList = sameCategoryModelList;
    // 给cell赋值
    int  i = 0;
    for (SameCategoryModel *model in _sameCategoryModelList) {
        NSInteger tag = 500 + i;
        SameCategoryView *bookView = (SameCategoryView *)[self viewWithTag:tag];
        NSString *imageName = [NSString stringWithFormat:@"http://wfqqreader.3g.qq.com/cover/%ld/%ld/t4_%ld.jpg", [model.bid integerValue] - ([model.bid integerValue]/1000)*1000, [model.bid integerValue], [model.bid integerValue]];
        [bookView.bookImageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:nil];
        bookView.bookTitle.text = model.title;
        
        i ++;
    }
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
