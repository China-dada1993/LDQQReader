//
//  BookDetailViewController.m
//  Case01_BookReader1126
//
//  Created by qianfeng on 15/11/28.
//  Copyright (c) 2015年 WP. All rights reserved.
//
/*

 http://ios.reader.qq.com/v5_0/queryintro?cataRecFlag=1&expRecFlag=1&bid=227524&authorRecFlag=1


 */
#import "BookDetailViewController.h"
#import "CommenDataDefine.h"
#import "UIImageView+WebCache.h"
#import "BookDetailItemModel.h"
#import "oneCellTableViewCell.h"
#import "commentModel.h"
#import "commentTableViewCell.h"
#import "CommentHeadView.h"
#import "SameCategoryModel.h"
#import "SameAuthorModel.h"
#import "OthersReadedModel.h"
#import "FourBookTableViewCell.h"
#import "SameCategoryTableViewCell.h"
#import "ApplicationUiMetaData.h"
#import "DatabaseControl.h"
#import "FMDatabase.h"
#import "SQLiteBookModel.h"

@interface BookDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollview;
@property (nonatomic, strong) UITableView *tableView;

/**
 *  查看目录的tableview
 */
@property (nonatomic, strong) UITableView *oneCellTableView;
/**
 *  tableView
 */
@property (nonatomic, strong) UITableView *commentTableView;
@property (nonatomic, strong) BookDetailItemModel *curentBookModel;
@property (nonatomic, strong) NSMutableArray *commentArray;
@property (nonatomic, strong) NSString *commmentCount;

@property (nonatomic, strong) NSMutableArray *sameAuthorModelList;
@property (nonatomic, strong) NSMutableArray *sameCategoryModelList;
@property (nonatomic, strong) NSMutableArray *othersReadedModelList;

@end

@implementation BookDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self getNetData];
    
    [self createToolBar];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = YES;
}

- (void)createToolBar
{
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.navigationController.toolbar.userInteractionEnabled = YES;
    self.navigationController.toolbar.tintColor = MainBackColor;
    
    UIBarButtonItem *barSep0 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *barDownload = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"bookdetail_download"] style:UIBarButtonItemStylePlain target:nil action:nil];

    UIBarButtonItem *barSep1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    barSep1.width = 50;
    UIBarButtonItem *barSave = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"bookdetail_addbookshelf"] style:UIBarButtonItemStylePlain target:self action:@selector(saveBook)];
    
    UIBarButtonItem *barSep2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    
    barSep2.width = 50;
    UIBarButtonItem *barTry = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"found_browse_empty"] style:UIBarButtonItemStylePlain target:nil action:nil];

    
    barTry.width = 120;
    UIBarButtonItem *barSep3 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.toolbarItems = @[barSep0, barDownload, barSep1, barTry, barSep2, barSave, barSep3];

}

- (void)saveBook {

    SQLiteBookModel *sModel = [[SQLiteBookModel alloc] init];
    sModel.bid = self.model.bid;
    sModel.lastCname = self.curentBookModel.lastCname;
    sModel.title = self.model.title;
    DatabaseControl *dbc = [[DatabaseControl alloc] init];
    // 先查询，如果有结果 return
    NSArray *books = [dbc getBooks];
    for (SQLiteBookModel *tmpModel in books) {
        if ([tmpModel.bid isEqualToString:sModel.bid]) {
            return;
        }
    }
    // 无结果就给模型赋值，吧模型的值传回去
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addBook" object:sModel];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:NO];
}

- (void) viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = self.model.title;
}

- (void) viewWillDisappear:(BOOL)animated
{
    self.navigationItem.title = nil;
    [self.navigationController setToolbarHidden:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        if (section == 1) {
            return 3;
        } else {
            return 1;
        }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 34;
    }
    if (indexPath.section == 1) {
        return 84;
    }
    if (indexPath.section == 5) {
        return 34;
    }
    else {
        return 134;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 260;
    }
    if (section == 1) {
        return 34;
    } else {
        return 54;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lable = [[UILabel alloc] init];
    if (section == 0) {
        [self addHeadView];
        
        return self.bookHeadView;
    }
    if (section == 1) {
        CommentHeadView *commentHeadView = [[[NSBundle mainBundle] loadNibNamed:@"CommentHeadView" owner:self options:nil] lastObject];
        commentHeadView.commentCount.text = [NSString stringWithFormat:@"%@条", self.commmentCount];
        return commentHeadView;
    } else if (section == 2) {
        lable.text = @"同作者作品";
    } else if (section == 3) {
        lable.text = @"同类别作品";
    } else if (section == 4) {
        lable.text = @"其他人还阅读过";
    } else {
        lable.text = @"版权说明";
    }
    return lable;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        //加载自定义的cell
        switch (indexPath.section) {
                // 评论的部分
            case 0:{
                oneCellTableViewCell *cell = (oneCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"ONECELL" forIndexPath:indexPath];
                cell.lastCname.text = self.curentBookModel.lastCname;
                cell.lastChapterUploadTime.text = self.curentBookModel.lastChapterUpdateTime;
                return cell;
            }
                break;
                //评论的部分
            case 1:
            {
                commentTableViewCell *cell = (commentTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"commentTableViewCell" forIndexPath:indexPath];
                if (self.commentArray != nil) {
                    commentModel *model = self.commentArray[indexPath.row];
                    cell.nick.text = model.nick;
                    cell.content.text = model.content;
                    [cell.userIcon.layer setCornerRadius:22];
                    [cell.userIcon.layer setMasksToBounds:YES];
                    [cell.userIcon sd_setImageWithURL:[NSURL URLWithString:model.userIcon] placeholderImage:nil];
                    
                }
                return cell;
            }
                break;
                // 同作者
            case 2:
            {
                self.commentTableView.rowHeight = 134;
                FourBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sameAuthor"];
                if (cell == nil) {
                    cell = [[FourBookTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sameAuthor"];
                }
                cell.sameAuthorModelList = self.sameAuthorModelList;
                return cell;
            }
                break;
                // 同类别
            case 3:
            {
                self.commentTableView.rowHeight = 134;
                FourBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sameCategory"];
                if (cell == nil) {
                    cell = [[FourBookTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sameCategory"];
                }
                cell.sameCategoryModelList = self.sameCategoryModelList;
                return cell;
            }
                break;
                //其他人还在看
            case 4:
            {
                self.commentTableView.rowHeight = 134;
                FourBookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OtherReaded"];
                if (cell == nil) {
                    cell = [[FourBookTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OtherReaded"];
                }
                cell.othersReadedModelList = self.othersReadedModelList;
                return cell;
            }
                break;
                //版权说明
            case 5:
            {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hehe"];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hehe"];
                }
                cell.textLabel.text = @"此版权归你无情的达哥所有";
                return cell;
            }
                break;
            default:
                break;
        }
    
    return nil;
    
}

- (void)addHeadView
{
    self.bookHeadView = [[[NSBundle mainBundle] loadNibNamed:@"headView" owner:self options:nil] lastObject];
    self.bookHeadView.frame = CGRectMake(0, 0, SIZE.width, 260);
//    [self.scrollview addSubview:self.bookHeadView];
    //self.bookHeadView.bookImageView.image =
    
    
    // 设置毛玻璃效果
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    
    effectview.frame = CGRectMake(0, 0, self.bookHeadView.backGroundImageView.frame.size.width, self.bookHeadView.backGroundImageView.frame.size.height);
    
    [self.bookHeadView.backGroundImageView addSubview:effectview];
    
    NSString *imageName = [NSString stringWithFormat:@"http://wfqqreader.3g.qq.com/cover/%ld/%ld/t4_%ld.jpg", [self.model.bid integerValue] - ([self.model.bid integerValue]/1000)*1000, [self.model.bid integerValue], [self.model.bid integerValue]];
    
    [self.bookHeadView.bookImageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:nil];
    
    [self.bookHeadView.backGroundImageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:nil ];
    
    self.bookHeadView.intro.text = self.model.intro;
    self.bookHeadView.intro.numberOfLines = 3;
    self.bookHeadView.bookTitle.text = self.model.title;
    self.bookHeadView.bookScore.text = self.curentBookModel.bookScore;
    self.bookHeadView.detailmsg.text = self.curentBookModel.detailmsg;
    self.bookHeadView.wordAndChapCount.text = [NSString stringWithFormat:@"共%@章", self.curentBookModel.chapSize];
    float scoreF = [self.curentBookModel.bookScore floatValue];
    int scoreI = [self.curentBookModel.bookScore intValue];
    int flag = 0;
    if (scoreF - scoreI >= 0.5) {
        flag = 1;
        scoreI ++;
    }
    for (int i = 0; i < scoreI; i ++) {
        NSInteger tag = 200 + i;
        UIImageView *imageview = (UIImageView *)[self.view viewWithTag:tag];
        imageview.image = [UIImage imageNamed:@"quanbu"];
        if (i == scoreI - 1 && flag == 1) {
            imageview.image = [UIImage imageNamed:@"yiban"];
        }
        imageview.alpha = 0.5;
    }
//    [self createOneCellTableView];
}

- (void)createCommentTableView
{
    self.commentTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    [self.view addSubview:self.commentTableView];
    self.commentTableView.dataSource = self;

    self.commentTableView.delegate = self;
    [self.commentTableView registerNib:[UINib nibWithNibName:@"commentTableViewCell" bundle:nil] forCellReuseIdentifier:@"commentTableViewCell"];
    
    [self.commentTableView registerNib:[UINib nibWithNibName:@"oneCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"ONECELL"];
    
}


- (void)getNetData
{
    self.commentArray = [[NSMutableArray alloc] init];
    self.sameCategoryModelList = [[NSMutableArray alloc] init];
    self.sameAuthorModelList = [[NSMutableArray alloc] init];
    self.othersReadedModelList = [[NSMutableArray alloc] init];
    
    NSString *address = [NSString stringWithFormat:@"http://ios.reader.qq.com/v5_0/queryintro?cataRecFlag=1&expRecFlag=1&bid=%@&authorRecFlag=1", self.model.bid];
    NSURL *url = [NSURL URLWithString:address];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"数据详细页面的网络请求失败");
        }
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        self.curentBookModel = [[BookDetailItemModel alloc] initWithDictionary:dataDict error:nil];
        self.commmentCount =[NSString stringWithFormat:@"%@", [dataDict[@"commentList"] objectForKey:@"totalComments"]];
        
        NSArray *commentData = [dataDict[@"commentList"] objectForKey:@"commentList"];
       
        for (NSDictionary *tmp in commentData) {
            commentModel *cModel = [[commentModel alloc] initWithDict:tmp];
            [self.commentArray addObject:cModel];
        }
        
        // 解析同作者数据
        NSArray *sameAuthor = [dataDict[@"authorRec"] objectForKey:@"authorRecList"];
        for (NSDictionary *dict in sameAuthor) {
            SameAuthorModel *model = [[SameAuthorModel alloc] initWithDict:dict];
            [self.sameAuthorModelList addObject:model];
        }
        
        // 解析其他人阅读过的和同类别书籍
        NSArray *otherAndSameCategory = [dataDict[@"expRec"] objectForKey:@"expRecList"];
        
        int i = 0;
        
        for (NSDictionary *dict in otherAndSameCategory) {
            if (i < 4) {
                SameCategoryModel *model = [[SameCategoryModel alloc] initWithDict:dict];
                [self.sameCategoryModelList addObject:model];
            } else {
                OthersReadedModel *model = [[OthersReadedModel alloc] initWithDict:dict];
                [self.othersReadedModelList addObject:model];
            }
            i ++;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self addHeadView];
            [self createCommentTableView];
//            [self.commentTableView reloadData];
        });
        
    }];
    
    [task resume];

}


@end
