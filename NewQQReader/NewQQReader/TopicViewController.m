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
#import <UIImageView+WebCache.h>

@interface TopicViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation TopicViewController {
    NSMutableArray *books;
    UITableView *mainView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createMainView];
    books = [[NSMutableArray alloc] init];
    if (self.flag == 4) {
        [self getBooksInfo];
    }
    
}

- (void)setCmdvalue:(NSString *)cmdvalue {
    _cmdvalue = cmdvalue;

    
}

- (void)createMainView {
    mainView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    mainView.delegate = self;
    mainView.dataSource = self;
    [self.view addSubview:mainView];
    mainView.rowHeight = 80;
    [mainView registerNib:[UINib nibWithNibName:@"TopicTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CELL"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" forIndexPath:indexPath];
    TopicModel *model = books[indexPath.row];
    
    NSString *imageName = [NSString stringWithFormat:@"http://wfqqreader.3g.qq.com/cover/%ld/%ld/t4_%ld.jpg", [model.bid integerValue] - ([model.bid integerValue]/1000)*1000, [model.bid integerValue], [model.bid integerValue]];
    [cell.bookImageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:nil];
        cell.bookTitleLable.text = model.title;
    cell.categoryLable.text = [NSString stringWithFormat:@"%@ | %@", model.categoryShortName, model.categoryName];
    cell.introLable.text = model.intro;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return books.count;
}

- (void)getBooksInfo {
    NSString *address = @"http://ios.reader.qq.com/v5_0/topic";
    NSDictionary *parement = @{@"tid":_cmdvalue};
    [NetworkDataAccess accessWithAddress:address parameters:parement method:NetWorkAccessMethodGet completionHandler:^(id data, int resultCode, NSString *resultMessage, NSError *innerError) {
        NSArray *array = [[[[(NSDictionary *)data objectForKey:@"topic"] objectForKey:@"elements"] lastObject] objectForKey:@"books"];
        
        for (NSDictionary *tmp in array) {
            NSDictionary *dataDict = tmp[@"book"];
            TopicModel *model = [[TopicModel alloc] initWithDictionary:dataDict error:nil];
            [books addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [mainView reloadData];
        });
    }];
}
@end
