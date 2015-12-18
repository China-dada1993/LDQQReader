//
//  TopicViewController.m
//  NewQQReader
//
//  Created by qianfeng on 15/12/15.
//  Copyright © 2015年 刘达. All rights reserved.
//

#import "TopicViewController.h"
#import "TopicModel.h"
#import "NetworkDataAccess.h"
#import "TopicTableViewCell.h"
#import "TopicListModel.h"
#import "TopicHeadView.h"
#import "TopicBookList.h"
#import "Topic102Model.h"
#import <UIImageView+WebCache.h>

@interface TopicViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation TopicViewController {
    NSMutableArray *books;
    UITableView *mainView;
    TopicListModel *headerViewModel;
    TopicHeadView *topicHeadView;
    NSInteger type;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createMainView];
    books = [[NSMutableArray alloc] init];
//    if (self.flag == 4) {
        [self getBooksInfo];
//    }
    
}

- (void)setCmdvalue:(NSString *)cmdvalue {
    _cmdvalue = cmdvalue;

    
}

- (void)createMainView {
    mainView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    mainView.delegate = self;
    mainView.dataSource = self;
    [self.view addSubview:mainView];
    mainView.rowHeight = 80;
    [mainView registerNib:[UINib nibWithNibName:@"TopicTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CELL"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    if (type == 106) {
        TopicModel *model = books[indexPath.row];
        
        NSString *imageName = [NSString stringWithFormat:@"http://wfqqreader.3g.qq.com/cover/%ld/%ld/t4_%ld.jpg", [model.bid integerValue] - ([model.bid integerValue]/1000)*1000, [model.bid integerValue], [model.bid integerValue]];
        [cell.bookImageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:nil];
        cell.bookTitleLable.text = model.title;
        cell.categoryLable.text = [NSString stringWithFormat:@"%@ | %@", model.categoryShortName, model.categoryName];
        cell.introLable.text = model.intro;
    } else if (type == 102) {
        NSArray *dataArray = [books[indexPath.section] bookList];
        Topic102Model *model = dataArray[indexPath.row];
        NSString *imageName = [NSString stringWithFormat:@"http://wfqqreader.3g.qq.com/cover/%ld/%ld/t4_%ld.jpg", [model.bid integerValue] - ([model.bid integerValue]/1000)*1000, [model.bid integerValue], [model.bid integerValue]];
        [cell.bookImageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:nil];
        cell.bookTitleLable.text = model.title;
        cell.categoryLable.text = [NSString stringWithFormat:@"%@ | %@", model.categoryShortName, model.author];
        cell.introLable.text = model.intro;
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (type == 102) {
        return books.count;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (type == 106) {
        return books.count;
    }else if (type == 102){
        
        return [[books[section] bookList] count];
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (type == 102) {
        NSString *str = [books[section] title];
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:headView.frame];
        [headView addSubview:imageView];
        imageView.image = [UIImage imageNamed:@"SectionHeadImage"];
        UILabel *label = [[UILabel alloc] initWithFrame:imageView.frame];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.text = str;
        label.textAlignment = NSTextAlignmentCenter;
        [imageView addSubview:label];
        return headView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (type == 106) {
        return 0;
    }
    if (type == 102) {
        return 44;
    }
    return 10;
}

- (void)getBooksInfo {
    NSString *address = @"http://ios.reader.qq.com/v5_0/topic";
    NSDictionary *parement = @{@"tid":_cmdvalue};
    [NetworkDataAccess accessWithAddress:address parameters:parement method:NetWorkAccessMethodGet completionHandler:^(id data, int resultCode, NSString *resultMessage, NSError *innerError) {
        
        headerViewModel = [[TopicListModel alloc] init];
        NSDictionary *dataDict = (NSDictionary *)data;
        headerViewModel.readCnt = dataDict[@"readCnt"];
        headerViewModel.imgurl = [[[dataDict[@"topic"] objectForKey:@"elements"] firstObject] objectForKey:@"imgurl"];
        headerViewModel.type = [dataDict[@"topic"] objectForKey:@"type"];
        headerViewModel.createTime = [dataDict[@"topic"] objectForKey:@"createTime"];
        headerViewModel.intro = [dataDict[@"topic"] objectForKey:@"intro"];
       
        headerViewModel.title = [dataDict[@"topic"] objectForKey:@"title"];
        
        type = [[dataDict[@"topic"] objectForKey:@"type"] integerValue];
        if (type == 106) {
            NSArray *array = [[[[(NSDictionary *)data objectForKey:@"topic"] objectForKey:@"elements"] lastObject] objectForKey:@"books"];
            
            for (NSDictionary *tmp in array) {
                NSDictionary *dataDict = tmp[@"book"];
                TopicModel *model = [[TopicModel alloc] initWithDictionary:dataDict error:nil];
                [books addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [mainView reloadData];
                [self createHeadView];
            });
        }
        
        if (type == 102) {
            NSArray *topicFirArray =[[[[(NSDictionary *)data objectForKey:@"topic"] objectForKey:@"elements"] objectAtIndex:2] objectForKey:@"books"];
            TopicBookList *list1 = [[TopicBookList alloc] init];
            NSString *title1 = [[[[(NSDictionary *)data objectForKey:@"topic"] objectForKey:@"elements"] objectAtIndex:2] objectForKey:@"title"];
            
            NSMutableArray *array1 = [[NSMutableArray alloc] init];
            for (NSDictionary *tmp in topicFirArray) {
                Topic102Model *modelFir = [[Topic102Model alloc] initWithDictionary:tmp error:nil];
                [array1 addObject:modelFir];
            }
            list1.bookList = array1;
            list1.title = title1;
            [books addObject:list1];
            
            NSArray *topicSecArray =[[[[(NSDictionary *)data objectForKey:@"topic"] objectForKey:@"elements"] objectAtIndex:3] objectForKey:@"books"];
            
            TopicBookList *list2 = [[TopicBookList alloc] init];
            NSString *title2 = [[[[(NSDictionary *)data objectForKey:@"topic"] objectForKey:@"elements"] objectAtIndex:3] objectForKey:@"title"];
            
                NSMutableArray *array2 = [[NSMutableArray alloc] init];
            for (NSDictionary *tmp in topicSecArray) {
                Topic102Model *modelFir = [[Topic102Model alloc] initWithDictionary:tmp error:nil];
                [array2 addObject:modelFir];
            }
            list2.bookList = array2;
            list2.title = title2;
            [books addObject:list2];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [mainView reloadData];
            [self createHeadView];
        });
    }];
}

- (void)createHeadView {
    topicHeadView = [[TopicHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
    if (type == 106) {
        topicHeadView.titleLable.text = headerViewModel.title;
        topicHeadView.introLable.text = headerViewModel.intro;
        [topicHeadView.backGroudImageView sd_setImageWithURL:[NSURL URLWithString:headerViewModel.imgurl]];
        topicHeadView.readCntLable.text = [NSString stringWithFormat:@"%@人已读", headerViewModel.readCnt];
        topicHeadView.createTimeLable.text = [NSString stringWithFormat:@"%@更新", [[headerViewModel.createTime componentsSeparatedByString:@" "] firstObject]];

    } if (type == 102) {
        [topicHeadView.backGroudImageView sd_setImageWithURL:[NSURL URLWithString:headerViewModel.imgurl]];
    }
    mainView.tableHeaderView = topicHeadView;
}
@end
