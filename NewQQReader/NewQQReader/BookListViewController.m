//
//  BookListViewController.m
//  Case01_BookReader
//
//  Created by 李海龙 on 15/11/25.
//  Copyright © 2015年 北京千锋互联科技有限公司（大连）. All rights reserved.
//

#import "BookListViewController.h"
#import "BookListBtnInfo.h"
#import "ActionIdOptionViewController.h"
#import "BookListTableViewCell.h"
#import "CommenDataDefine.h"
#import "BookModel.h"
#import "UIImageView+WebCache.h"
#import "BookDetailViewController.h"
#import "BookListBtnInfo.h"

@interface BookListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIView *myHeaderView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *btnInfos;
@property (nonatomic, strong) NSString *actionTag;
@property (nonatomic, strong) UIButton *lastBtn;
@property (nonatomic, strong) UILabel *scrollLabel;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSMutableArray *btnTitles;
@property (nonatomic, assign) int flag;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@end

@implementation BookListViewController {
    UIBarButtonItem *rightButton;
}
/*
 // Do any additional setup after loading the view.
 
 
  http://ios.reader.qq.com/v5_0/listdispatch?action=category&actionTag=0&actionId=20001&page=1
 
 
 action    -->  固定为category
 actionId  --> 类别编号
 actionTag --> 排序方式
 page      --> 分页页码
 


// imageFileName = [NSString stringWithFormat:@"http://wfqqreader.3g.qq.com/cover/%d/%d/t4_%d.jpg", bid - (bid/1000)*1000, bid, bid];

 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.btnInfos = [[NSArray alloc] init];
    self.navigationItem.title = self.bookListTitle;
//    self.btnInfos = [[BookListBtnInfo alloc] BookListBtnInfoList];
    self.data = [[NSMutableArray alloc] init];
    [self createRightButton];
      
    [self createTableView];
    self.page = 1;
    self.actionTag = @"0";
    [self getNetData];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = YES;
    
}

- (void)createTableView
{
    [self createMyHeaderView];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = self.myHeaderView;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"BookListTableViewCell" bundle:nil] forCellReuseIdentifier:@"BookListTableViewCell"];

}

- (void)createMyHeaderView
{
    self.myHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 44)];
    
//    [self createFourBtn];
    [self createScrollLabel];
}

- (void)createScrollLabel
{
    CGFloat LabelW = SIZE.width / 4;
    self.scrollLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 44 - 2, LabelW, 2)];
    self.scrollLabel.backgroundColor = [UIColor blueColor];
    [self.myHeaderView addSubview:self.scrollLabel];
}

- (void)createFourBtn
{
    self.lastBtn = [[UIButton alloc] init];
    if (self.flag != 0) {
        return;
    }
    CGFloat btnW = SIZE.width / self.btnTitles.count;
    self.flag = 1;
    for (int i = 0; i < self.btnTitles.count; i ++) {
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnW * i, 0, btnW, 44)];
        [self.myHeaderView addSubview:btn];
        if (i == 0) {
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            self.lastBtn = btn;
        } else {
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
        BookListBtnInfo *info = self.btnTitles[i];
        [btn setTitle:info.title forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)click:(UIButton *)sender
{
    NSArray *titles = @[@"畅销",@"免费",@"新上架",@"完本"];
    NSInteger index = [titles indexOfObject:sender.titleLabel.text];
    self.actionTag = [NSString stringWithFormat:@"%ld", index];
    if (![self.lastBtn.titleLabel.text isEqualToString:sender.titleLabel.text]) {
            [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.lastBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.lastBtn = sender;
        [UITableView animateWithDuration:0.4 animations:^{
            self.scrollLabel.frame = CGRectMake(self.scrollLabel.frame.size.width * index, self.scrollLabel.frame.origin.y, self.scrollLabel.frame.size.width, self.scrollLabel.frame.size.height);
            self.data = [[NSMutableArray alloc] init];
             // 下载数据
            self.page = 1;
            [self getNetData];
        }];
        
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat height = scrollView.frame.size.height;
    CGFloat contentYoffSet = scrollView.contentOffset.y;
    CGFloat distance = scrollView.contentSize.height - contentYoffSet;
    if (distance == height) {
        self.page ++;
        [self getNetData];
        self.flag = 3;
    }
    
}

- (void)getNetData
{
    self.btnTitles = [[NSMutableArray alloc] init];
    
    NSString *home = @"http://ios.reader.qq.com/v5_0/listdispatch?action=category";
    NSString *urlstr = [NSString stringWithFormat:@"%@&actionTag=%@&actionId=%@&page=%d", home, self.actionTag, self.actionId, self.page];
    
    NSURL *url = [NSURL URLWithString:urlstr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSArray *array = dict[@"bookList"];
        for (NSDictionary *tmp in array) {
            BookModel *model = [[BookModel alloc] initWithDictionary:tmp error:nil];
            [self.data addObject:model];
        }
        //info actionIdList actionTagList
        NSArray *titles = [dict[@"info"] objectForKey:@"actionTagList"];
        for (NSDictionary *tmp in titles) {
            BookListBtnInfo *model = [[BookListBtnInfo alloc] initWithDict:tmp];
            [self.btnTitles addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            if (self.flag == 0) {
                [self createFourBtn];
            }

        });
        
    }];
    
    [task resume];

}

- (void)createRightButton
{
    rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(rightButton_Touch:)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)rightButton_Touch:(id)sender
{
    ActionIdOptionViewController *target = [[ActionIdOptionViewController alloc] init];
    
    target.modalPresentationStyle = UIModalPresentationPopover;
    target.preferredContentSize = CGSizeMake(180, 200);
    UIPopoverPresentationController *pop = target.popoverPresentationController;
    
    pop.barButtonItem = rightButton;
//    pop.sourceRect = ...
//    pop.souceView = ...
    
    pop.permittedArrowDirections = UIPopoverArrowDirectionUp;
    pop.delegate = self;

    
    [self presentViewController:target animated:YES completion:nil];
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {
    return UIModalPresentationNone;
}

#pragma mark -k 数据源的方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    BookListTableViewCell *cell = (BookListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"BookListTableViewCell" forIndexPath:indexPath];
    if (self.data != nil) {
        BookModel *model = self.data[indexPath.row];
    cell.sortValue.text = model.sortValue;
        cell.showPrice.text = model.showPrice;
        cell.title.text = model.title;
        cell.intro.text = model.intro;
        NSString *imageName = [NSString stringWithFormat:@"http://wfqqreader.3g.qq.com/cover/%ld/%ld/t4_%ld.jpg", [model.bid integerValue] - ([model.bid integerValue]/1000)*1000, [model.bid integerValue], [model.bid integerValue]];
        [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:nil];
    }
    
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookModel *model = self.data[indexPath.row];
    BookDetailViewController *next = [[BookDetailViewController alloc] init];
    next.model = model;
    [self.navigationController pushViewController:next animated:YES];
}
@end
