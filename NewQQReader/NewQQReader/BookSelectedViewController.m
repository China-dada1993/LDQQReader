//
//  BookSelectedViewController.m
//  Case01_BookReader
//
//  Created by 李海龙 on 15/11/23.
//  Copyright © 2015年 北京千锋互联科技有限公司（大连）. All rights reserved.
//

#import "BookSelectedViewController.h"
#import "NetWorkCallbackDelegate.h"
#import "NetworkDataAccess.h"
#import "ADSModel.h"
#import "AdsContentViewController.h"
#import "SelectBookModel.h"
#import "CommenDataDefine.h"
#import "BookDetailTableViewCell.h"
#import "BookTopicInfoModel.h"
#import "BookTopicListModel.h"
#import "BookTopicForeImagesTableViewCell.h"
#import "BookTopicInfoFore1ImageModel.h"
#import "BookTopicFor1ImageTableViewCell.h"
#import "UrlModel.h"
#import "MJRefresh.h"
#import "TopicViewController.h"

#import <UIImageView+WebCache.h>

@interface BookSelectedViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@end

@implementation BookSelectedViewController {
    UIBarButtonItem *rightButton;
    NSMutableArray *AdsdataArray;
    UIPageViewController *adsPageViewControl;
    AdsContentViewController *adsContentViewContrller;
    UIPageControl *pageControl;
    int currentIndex;
    UITableView *mainView;
    NSMutableArray *mainViewDataList;
}

- (void)viewDidLoad {
    AdsdataArray = [[NSMutableArray alloc] init];
    mainViewDataList = [[NSMutableArray alloc] init];
    NSLog(@"哈哈");
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = YES;
   

    [super viewDidLoad];
    NSOperationQueue *q = [[NSOperationQueue alloc] init];
    q.maxConcurrentOperationCount = 1;
    
    NSBlockOperation *op1 = [[NSBlockOperation alloc] init];
    [op1 addExecutionBlock:^{
        [self getAdsData];
    }];
    
    NSBlockOperation *op2 = [[NSBlockOperation alloc] init];
    [op2 addExecutionBlock:^{
        [self getTableViewData];
    }];
    [q addOperation:op1];
    [q addOperation:op2];
}

- (void)createMainView {
    mainView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SIZE.width, SIZE.height) style:UITableViewStylePlain];
    mainView.delegate = self;
    mainView.dataSource = self;
    [mainView registerNib:[UINib nibWithNibName:@"BookDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"l"];
    
    [mainView registerNib:[UINib nibWithNibName:@"BookTopicForeImagesTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BTFITVC"];
    
    [mainView registerNib:[UINib nibWithNibName:@"BookTopicFor1ImageTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"BT"];
    
    mainView.tableHeaderView = adsPageViewControl.view;
    
    mainView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self getTableViewData];
    }];
    
    
    pageControl = [[UIPageControl alloc] init];
    pageControl.frame = CGRectMake(0, 160, 150, 30);
    pageControl.numberOfPages = AdsdataArray.count;
    pageControl.currentPage = 0;
    pageControl.userInteractionEnabled = NO;
    [mainView.tableHeaderView addSubview:pageControl];
    [self.view addSubview:mainView];
}

#pragma mark -k tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return mainViewDataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = mainViewDataList[indexPath.row];
    if ([[model cmd] isEqualToString:@"goBookDetail"]) {
        BookDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"l" forIndexPath:indexPath];
        SelectBookModel *dModel = (SelectBookModel *)model;
        cell.bookAuthorLable.text = dModel.author;
        cell.bookCatel2NameLable.text = dModel.catel2name;
        [cell.bookCatel2NameLable.layer setBorderColor:[[UIColor colorWithRed:160 / 255.f green:179 / 255.f blue:200 / 255.f alpha:1] CGColor]];
        [cell.bookCatel2NameLable.layer setBorderWidth:1];
        [cell.bookCatel2NameLable.layer setCornerRadius:5];
        [cell.bookCatel2NameLable.layer setMasksToBounds:YES];
        cell.bookCatel2NameLable.textColor = [UIColor colorWithRed:160 / 255.f green:179 / 255.f blue:200 / 255.f alpha:1];
        
        cell.bookCatel3NameLable.text = dModel.catel3name;
        [cell.bookCatel3NameLable.layer setBorderColor:[[UIColor colorWithRed:160 / 255.f green:179 / 255.f blue:200 / 255.f alpha:1] CGColor]];
        [cell.bookCatel3NameLable.layer setBorderWidth:1];
        [cell.bookCatel3NameLable.layer setCornerRadius:5];
        [cell.bookCatel3NameLable.layer setMasksToBounds:YES];
        cell.bookCatel3NameLable.textColor = [UIColor colorWithRed:160 / 255.f green:179 / 255.f blue:200 / 255.f alpha:1];
        
        cell.bookTitleLable.text = dModel.title;
        cell.bokkDescLable.text = dModel.desc;
        int wordCount = [dModel.wordcount intValue] / 10000;
        cell.bookWordCountLable.text = [NSString stringWithFormat:@"%d万字", wordCount];
        [cell.bookWordCountLable.layer setBorderColor:[[UIColor colorWithRed:160 / 255.f green:179 / 255.f blue:200 / 255.f alpha:1] CGColor]];
        [cell.bookWordCountLable.layer setBorderWidth:1];
        cell.bookWordCountLable.textColor = [UIColor colorWithRed:160 / 255.f green:179 / 255.f blue:200 / 255.f alpha:1];
        [cell.bookWordCountLable.layer setCornerRadius:5];
        [cell.bookWordCountLable.layer setMasksToBounds:YES];
        
        
        NSString *imageName = [NSString stringWithFormat:@"http://wfqqreader.3g.qq.com/cover/%ld/%ld/t4_%ld.jpg", [dModel.bid integerValue] - ([dModel.bid integerValue]/1000)*1000, [dModel.bid integerValue], [dModel.bid integerValue]];
        [cell.bookImageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:nil];
        
        return cell;
    }
    //BookTopicForeImagesTableViewCell
    if ([model style] != 2 && [model style] != 0) {
        BookTopicForeImagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BTFITVC"];
        BookTopicListModel *bModel = (BookTopicListModel *)model;
        cell.titleLable.text = bModel.title;
        cell.descLable.text = bModel.desc;
        
        NSString *imageName1 = [NSString stringWithFormat:@"http://wfqqreader.3g.qq.com/cover/%ld/%ld/t4_%ld.jpg", [[bModel.books[0] bid] integerValue] - ([[bModel.books[0] bid] integerValue]/1000)*1000, [[bModel.books[0] bid] integerValue], [[bModel.books[0] bid] integerValue]];
        [cell.book1imageView sd_setImageWithURL:[NSURL URLWithString:imageName1]];
        
        NSString *imageName2 = [NSString stringWithFormat:@"http://wfqqreader.3g.qq.com/cover/%ld/%ld/t4_%ld.jpg", [[bModel.books[1] bid] integerValue] - ([[bModel.books[1] bid] integerValue]/1000)*1000, [[bModel.books[1] bid] integerValue], [[bModel.books[1] bid] integerValue]];
        [cell.book2imageView sd_setImageWithURL:[NSURL URLWithString:imageName2]];
        
        NSString *imageName3 = [NSString stringWithFormat:@"http://wfqqreader.3g.qq.com/cover/%ld/%ld/t4_%ld.jpg", [[bModel.books[2] bid] integerValue] - ([[bModel.books[2] bid] integerValue]/1000)*1000, [[bModel.books[2] bid] integerValue], [[bModel.books[2] bid] integerValue]];
        [cell.book3imageView sd_setImageWithURL:[NSURL URLWithString:imageName3]];
        
        NSString *imageName4 = [NSString stringWithFormat:@"http://wfqqreader.3g.qq.com/cover/%ld/%ld/t4_%ld.jpg", [[bModel.books[3] bid] integerValue] - ([[bModel.books[3] bid] integerValue]/1000)*1000, [[bModel.books[3] bid] integerValue], [[bModel.books[3] bid] integerValue]];
        [cell.book4imageView sd_setImageWithURL:[NSURL URLWithString:imageName4]];
        
        return cell;
    }
    // BookTopicFor1ImageTableViewCell

    if ([model style] == 2) {
        BookTopicFor1ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BT"];
        BookTopicInfoFore1ImageModel *imodel = (BookTopicInfoFore1ImageModel *)model;
        
        cell.titleLable.text = imodel.title;
        cell.descLabel.text = imodel.desc;
        UrlModel *urlModel = imodel.urls[0];
        [cell.bookImageView sd_setImageWithURL:[NSURL URLWithString:urlModel.url]];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[mainViewDataList[indexPath.row] cmd] isEqualToString:@"goBookDetail"]) {
        return 140;
    } else if ([[mainViewDataList[indexPath.row] cmd] isEqualToString:@"goTopic"]) {
        return 150;
    }
    return 0;
}

- (void)getTableViewData {
    NSString *urlString = @"http://ios.reader.qq.com/v5_0/infostreamslist";
    NSDictionary *parameter = @{@"endshowtime":@"2015092216"};
    [NetworkDataAccess accessWithAddress:urlString parameters:parameter method:NetWorkAccessMethodGet completionHandler:^(id data, int resultCode, NSString *resultMessage, NSError *innerError) {
        NSArray *dataArray = [[data[@"areas"] firstObject] objectForKey:@"infos"];
        for (NSDictionary *tmp in dataArray) {
            if ([[tmp[@"cmd"] objectForKey:@"cmd"] isEqualToString:@"goBookDetail"]) {
                SelectBookModel *model = [[SelectBookModel alloc] initWithDictionary:tmp error:nil];
                [mainViewDataList addObject:model];
            }
            if ([[tmp[@"cmd"] objectForKey:@"cmd"] isEqualToString:@"goTopic"] && [[tmp[@"info"] objectForKey:@"books"] count] == 4) {
                BookTopicListModel *model = [[BookTopicListModel alloc] initWithDictionary:tmp error:nil];
                [mainViewDataList addObject:model];
            }
            if ([tmp[@"style"] integerValue] == 2) {
                BookTopicInfoFore1ImageModel *model = [[BookTopicInfoFore1ImageModel alloc] initWithDictionary:tmp error:nil];
                [mainViewDataList addObject:model];
            }
        }
        [mainView.footer endRefreshing];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.view.subviews containsObject:mainView]) {
                [mainView reloadData];
            } else {
                [self createMainView];
            }
        });
    }];
}

- (void)getAdsData {
    NSString *URLString = @"http://ios.reader.qq.com/v5_0/queryads";
    NSDictionary *parameter = @{@"adids":@"102580"};
    [NetworkDataAccess accessWithAddress:URLString parameters:parameter method:NetWorkAccessMethodGet completionHandler:^(id data, int resultCode, NSString *resultMessage, NSError *innerError) {
        NSArray *ads = [[data[@"ads"] objectForKey:@"102580"] objectForKey:@"adList"];
        for (NSDictionary *tmp in ads) {
            ADSModel *model = [[ADSModel alloc] initWithDictionary:tmp error:nil];
            if ([model.desc isEqualToString:@"0"]) {
                model.desc = @"";
            }
       
            [AdsdataArray addObject:model];
        }
       dispatch_async(dispatch_get_main_queue(), ^{
           [self createAdsView];
       });
    }];
}

- (void)createAdsView {
    adsPageViewControl = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    adsPageViewControl.delegate = self;
    adsPageViewControl.dataSource = self;
    
    [self addChildViewController:adsPageViewControl];
    adsPageViewControl.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 200);
    
    adsContentViewContrller = [[AdsContentViewController alloc] init];

    adsContentViewContrller.view.backgroundColor = [UIColor colorWithRed:73 / 255.f green:110 / 255.f blue:167 / 255.f alpha:1];
    adsContentViewContrller.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 200);
    [adsPageViewControl.view addSubview:adsContentViewContrller.view];
    
    ADSModel *startModle = [AdsdataArray firstObject];
    
    [adsContentViewContrller setDesc:startModle.desc title:startModle.title intro:startModle.intro bookImageName:startModle.imageUrl];

    
    [adsPageViewControl setViewControllers:@[adsContentViewContrller] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

    
    
    
    [self performSelector:@selector(changeToNextPage) withObject:nil afterDelay:2];
}

- (void)changeToNextPage {
    AdsContentViewController *current = (AdsContentViewController *)[adsPageViewControl.viewControllers firstObject];
    int pageIndex = current.currentIndex;
    
    if (pageIndex == AdsdataArray.count-1) {
        pageIndex = 0;
    }
    else {
        pageIndex++;
    }
    AdsContentViewController *pageContent = [[AdsContentViewController alloc] init];
//    AdsContentViewController *pageContent = [[AdsContentViewController alloc] initWithContentText:[collection objectAtIndex:pageIndex]];
    ADSModel *model = AdsdataArray[pageIndex];
    [pageContent setDesc:model.desc title:model.title intro:model.intro bookImageName:model.imageUrl];
    pageContent.currentIndex = pageIndex;
    pageControl.currentPage = pageIndex;
    
    [adsPageViewControl setViewControllers:@[pageContent] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    
    pageContent.view.backgroundColor = [UIColor colorWithRed:73 / 255.f green:110 / 255.f blue:167 / 255.f alpha:1];
    pageContent.currentIndex = pageIndex;
    pageContent.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 200);
    
    [self performSelector:@selector(changeToNextPage) withObject:nil afterDelay:2];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    AdsContentViewController *current = (AdsContentViewController *)[pageViewController.viewControllers firstObject];
    int pageIndex = current.currentIndex;
    
    pageControl.currentPage = pageIndex;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    AdsContentViewController *current = (AdsContentViewController *)viewController;
    int index = current.currentIndex;
    if (index == AdsdataArray.count - 1) {
        index = 0;
    } else {
        index ++;
    }
    AdsContentViewController *next = [[AdsContentViewController alloc] init];
    ADSModel *model = AdsdataArray[index];
    
    [next setDesc:model.desc title:model.title intro:model.intro bookImageName:model.imageUrl];
    next.view.backgroundColor = [UIColor colorWithRed:73 / 255.f green:110 / 255.f blue:167 / 255.f alpha:1];
    next.currentIndex = index;
    next.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 200);
    return next;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    AdsContentViewController *current = (AdsContentViewController *)viewController;
    int index = current.currentIndex;
    if (index == 0) {
        index = (int)AdsdataArray.count - 1;
    } else {
        index --;
    }
    AdsContentViewController *next = [[AdsContentViewController alloc] init];
    ADSModel *model = AdsdataArray[index];
    [next setDesc:model.desc title:model.title intro:model.intro bookImageName:model.imageUrl];
    next.currentIndex = index;
    next.view.backgroundColor = [UIColor colorWithRed:73 / 255.f green:110 / 255.f blue:167 / 255.f alpha:1];
    next.view.frame = CGRectMake(0, 0, self.view.frame.size.width, 200);
    return next;

}

- (void)viewDidAppear:(BOOL)animated {
    if (!rightButton) {
        rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    }
    self.tabBarController.navigationItem.rightBarButtonItem = rightButton;
    self.parentViewController.navigationItem.title = @"精选";
}

- (void)viewWillDisappear:(BOOL)animated {
    self.parentViewController.navigationItem.title = nil;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = mainViewDataList[indexPath.row];
    if ([model style] == 0) {
        SelectBookModel *dModel = (SelectBookModel *)model;
        NSLog(@"SelectBookModel is %@", dModel.bid);
    } else if ([model style] != 2 && [model style] != 0 ) {
        BookTopicListModel *bModel = (BookTopicListModel *)model;
        TopicViewController *next = [[TopicViewController alloc] init];
        next.cmdvalue = bModel.cmdvalue;
        next.flag = 4;
        [self.parentViewController.navigationController pushViewController:next animated:YES];
        NSLog(@"BookTopicListModel is %@", bModel.cmdvalue);
    } else if ([model style] == 2) {
        BookTopicInfoFore1ImageModel *iModel = (BookTopicInfoFore1ImageModel *)model;
        NSLog(@"BookTopicInfoFore1ImageModel is %@", iModel.cmdvalue);
        TopicViewController *next = [[TopicViewController alloc] init];
        next.cmdvalue = iModel.cmdvalue;
        [self.parentViewController.navigationController pushViewController:next animated:YES];
    }
}
@end
