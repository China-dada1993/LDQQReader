//
//  FourBookTableViewCell.m
//  Case01_BookReader1126
//
//  Created by qianfeng on 15/11/28.
//  Copyright (c) 2015年 WP. All rights reserved.
//

#import "FourBookTableViewCell.h"
#import "BookView.h"
#import "SameAuthorModel.h"
#import "SameCategoryModel.h"
#import "OthersReadedModel.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
//#import "SameCategoryView.h"

@implementation FourBookTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubView];
//        [self createSameCategoryView];
    }
    return self;
}

- (void)setSameCategoryModelList:(NSArray *)sameCategoryModelList
{
    _sameCategoryModelList = sameCategoryModelList;
    // 给cell赋值
    int  i = 0;
    for (SameCategoryModel *model in _sameCategoryModelList) {
        NSInteger tag = 400 + i;
        BookView *bookView = (BookView *)[self viewWithTag:tag];
        
        NSString *imageName = [NSString stringWithFormat:@"http://wfqqreader.3g.qq.com/cover/%ld/%ld/t4_%ld.jpg", [model.bid integerValue] - ([model.bid integerValue]/1000)*1000, [model.bid integerValue], [model.bid integerValue]];
        
        [bookView.bookImageView sd_setImageWithURL:[NSURL URLWithString:imageName]];
        bookView.bookTitle.text = model.title;
        i ++;
    }
}


- (void)createSubView
{
    int  count = 4;
    CGFloat marginX = 3;
    CGFloat marginY = 5;
    CGFloat cellH = self.frame.size.height;
    CGFloat cellW = 375;
    CGFloat subViewH = cellH - 2 * marginY;
    CGFloat subViewW = (cellW - (count + 1) * marginX) / count;

    for (int i = 0; i < count; i ++) {
        BookView *bookView = [[[NSBundle mainBundle] loadNibNamed:@"BookView" owner:self options:nil] lastObject];
        bookView.tag = 400 + i;
        bookView.frame = CGRectMake(marginX + (marginX + subViewW) * i, marginY, subViewW, subViewH);
        [self addSubview:bookView];
    }
}


- (void)setSameAuthorModelList:(NSArray *)sameAuthorModelList
{

    _sameAuthorModelList = sameAuthorModelList;
    // 给cell赋值
    int  i = 0;
    for (SameAuthorModel *model in _sameAuthorModelList) {
        NSInteger tag = 400 + i;
        BookView *bookView = (BookView *)[self viewWithTag:tag];
        
        [bookView.bookImageView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:nil];
    
        bookView.bookTitle.text = model.title;
        i ++;
    }

}


- (void)setOthersReadedModelList:(NSArray *)othersReadedModelList
{
    
    _othersReadedModelList = othersReadedModelList;
    // 给cell赋值
    int  i = 0;
    for (OthersReadedModel *model in _othersReadedModelList) {
        NSInteger tag = 400 + i;
        BookView *bookView = (BookView *)[self viewWithTag:tag];
       
        NSString *imageName = [NSString stringWithFormat:@"http://wfqqreader.3g.qq.com/cover/%ld/%ld/t4_%ld.jpg", [model.bid integerValue] - ([model.bid integerValue]/1000)*1000, [model.bid integerValue], [model.bid integerValue]];

        [bookView.bookImageView sd_setImageWithURL:[NSURL URLWithString:imageName]];
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
