//
//  BookStackViewController.m
//  Case01_BookReader
//
//  Created by 李海龙 on 15/11/23.
//  Copyright © 2015年 北京千锋互联科技有限公司（大连）. All rights reserved.
//

#import "BookStackViewController.h"
#import "CategoryDataInfo.h"
#import "CategoyItemInfo.h"
#import "CategoryItemTableViewCell.h"
#import "ApplicationUiMetaData.h"
#import "UIImageView+WebCache.h"


#import "BookListViewController.h"

#define CATEGORY_CELL_ID @"CellId"

@interface BookStackViewController ()

@end

@implementation BookStackViewController {
    UITableView *mainTableView;
    
    CategoryDataInfo *allCategoryData;
    
    NSInteger flag;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    int i, j;
//    dispatch_queue_t que = dispatch_queue_create(@"my", DISPATCH_QUEUE_SERIAL);
//    dispatch_apply(3, que, ^(size_t i) {
//        NSLog(@"3");
//        dispatch_apply(3, que, ^(size_t) {
//            NSLog(@"4");
//        })
//    });
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self createTableView];
//    [self loadNetworkData];
    

    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    // 获取点击了什么
    NSInteger index = [[user objectForKey:@"selectedIndex"] integerValue];
    if (index == 0) {
        flag = 3;
        
    } else {
        flag = 1;
    }
    [self loadNetworkData2];
//    [self createUISegment];
}

/**
  *  分段控制器
  */
- (void)createUISegment
{
    //    UISementedViewController *segment = [[UISementedViewController alloc] init];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithFrame:CGRectMake(10, 100, 200, 30)];
    // 添加分段文字
    [segment insertSegmentWithTitle:@"出版图书" atIndex:0 animated:NO];
    
    [segment insertSegmentWithTitle:@"原创文学" atIndex:1 animated:NO];
    
    
    [segment addTarget:self action:@selector(clickSegment:) forControlEvents:UIControlEventValueChanged];
    
    
    // 添加分段图片
//    [segment insertSegmentWithImage:[UIImage imageNamed:@"tab_0"] atIndex:3 animated:YES];
    // 设置默认选择
    if ([user objectForKey:@"selectedIndex"] == nil) {
        segment.selectedSegmentIndex = 0;
    } else {
        NSInteger selectIndex = [[user objectForKey:@"selectedIndex"] integerValue];
        segment.selectedSegmentIndex = selectIndex;
    }
    
    
    // 设置颜色
    segment.tintColor = barBackgroundColor;
    
    // 修改某个分段
//    [segment setTitle:@"呵呵" forSegmentAtIndex:0];
    
    // 修改某个分段的图片
    //    [segment setImage:[UIImage imageNamed:@""] forSegmentAtIndex:0];
    // 读取某个分段的标题
//    self.navigationItem.titleView = segment;
    self.parentViewController.navigationItem.titleView = segment;
}

- (void)clickSegment:(UISegmentedControl *)sender
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    // 获取点击了什么
    NSInteger index = sender.selectedSegmentIndex;
    if (index == 0) {
        flag = 3;
        
    } else {
        flag = 1;
    }
    [user setObject:[NSString stringWithFormat:@"%ld", index] forKey:@"selectedIndex"];
    [self loadNetworkData2];
}

- (void)viewDidAppear:(BOOL)animated {
    [self createUISegment];
//    self.parentViewController.navigationItem.title = @"书库";
}

- (void)viewWillDisappear:(BOOL)animated {
    self.parentViewController.navigationItem.titleView = nil;
}


#pragma mark UITableView相关处理与设置

/**
 *  UITableView初始化
 */
- (void)createTableView {
    mainTableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    [self.view addSubview:mainTableView];
    
    [mainTableView registerNib:[UINib nibWithNibName:@"CategoryItemTableViewCell" bundle:nil] forCellReuseIdentifier:CATEGORY_CELL_ID];

}

/**
 *  返回TableView中Section的数量
 *
 *  @param tableView 参数名
 *
 *  @return 返回
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

/**
 *  <#Description#>
 *
 *  @param tableView <#tableView description#>
 *  @param section   <#section description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (allCategoryData) {
        if (flag == 1) {
            switch (section) {
            case 0:
                return allCategoryData.boyCategoryList.count;
                break;
            case 1:
                return allCategoryData.girlCategoryList.count;
                break;
            default:
                break;
            }
        }else {
            return allCategoryData.publishCategoryList.count;
        }

    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CategoryItemTableViewCell *cell = (CategoryItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CATEGORY_CELL_ID forIndexPath:indexPath];
    NSArray *collection = [[NSArray alloc] init];
    if (flag == 1) {
        collection = indexPath.section==0?allCategoryData.boyCategoryList:allCategoryData.girlCategoryList;
    } else {
        collection = allCategoryData.publishCategoryList;
    }
    
    
    CategoyItemInfo *info = [collection objectAtIndex:indexPath.row];
    
    cell.categoryNameLabel.text = info.categoryName;
    cell.categoryL3NameLabel.text = info.categoryL3Name;
    cell.bookCountLabel.text = [NSString stringWithFormat:@"%ld", info.bookCount];

    [cell.categoryPictureImageView sd_setImageWithURL:[NSURL URLWithString:info.imageName] placeholderImage:nil];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *collection = [[NSArray alloc] init];
    if (flag == 1) {
        collection = indexPath.section==0?allCategoryData.boyCategoryList:allCategoryData.girlCategoryList;
    } else {
        collection = allCategoryData.publishCategoryList;
    }
    
    CategoyItemInfo *info = [collection objectAtIndex:indexPath.row];

    
    BookListViewController *target = [[BookListViewController alloc] init];
    // ...
    target.actionId = [NSString stringWithFormat:@"%ld", info.actionId];
    target.bookListTitle = info.categoryName;
    
    [self.tabBarController.navigationController pushViewController:target animated:YES];
    
}





#pragma mark 关于网络数据操作

- (void) loadNetworkData {
    // http://ios.reader.qq.com/v5_0/category?categoryflag=1
    
    NSString *hostName = @"http://ios.reader.qq.com/v5_0";
    NSString *categoryAddress = @"/category";
    
    NSString *address = [NSString stringWithFormat:@"%@%@", hostName, categoryAddress];
    
    NSString *param_categoryFlag = @"categoryflag";
    NSInteger value_categoryFlag = 1;
    
    NSString *parameterString = [NSString stringWithFormat:@"%@=%ld", param_categoryFlag, value_categoryFlag];
    parameterString = [parameterString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSString *urlAddress = [NSString stringWithFormat:@"%@?%@", address, parameterString];
    
//    NSString *urlAddress = @"http://ios.reader.qq.com/v5_0/category?categoryflag=1";
    
    
    NSLog(@"URL Address : %@", urlAddress);
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            NSLog(@"网络访问错误：%@", error);
            return ;
        }
        
        NSHTTPURLResponse *rep = (NSHTTPURLResponse *)response;
        if (rep.statusCode != 200) {
            NSLog(@"网络访问错误，错误代码：%ld", rep.statusCode);
            return;
        }
        
        
        // 解析JSON数据
        NSError *jsonError;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&jsonError];
        if (jsonError) {
            NSLog(@"JSON解析错误");
            return;
        }
        
        
     //   NSLog(@"Dictionary Data : %@", dictionary);
        
        allCategoryData              = [[CategoryDataInfo alloc] init];
        allCategoryData.lineTitle    = [[dictionary objectForKey:@"line"] objectForKey:@"title"];
        allCategoryData.allBookCount = [[[dictionary objectForKey:@"count"] objectForKey:@"bookCount"] integerValue];
        allCategoryData.newBookCount = [[[dictionary objectForKey:@"count"] objectForKey:@"newBookCount"] integerValue];
        
        NSArray *boyData = [dictionary objectForKey:@"boyCategoryList"];
        NSMutableArray *boyCategoryListData = [[NSMutableArray alloc] init];
        for (NSDictionary *itemData in boyData) {
            CategoyItemInfo *itemInfo = [[CategoyItemInfo alloc] init];
            
            itemInfo.actionId       = [[itemData objectForKey:@"actionId"]integerValue];
            itemInfo.categoryName   = [itemData objectForKey:@"categoryName"];
            itemInfo.categoryL3Name = [itemData objectForKey:@"level3categoryName"];
            itemInfo.bookCount      = [[itemData objectForKey:@"bookCount"] integerValue];
            itemInfo.imageName      = [itemData objectForKey:@"img"];
            
            [boyCategoryListData addObject:itemInfo];
        }
        allCategoryData.boyCategoryList = boyCategoryListData;
        
        NSArray *girlData = [dictionary objectForKey:@"girlCategoryList"];
        NSMutableArray *girlCategoryListData = [[NSMutableArray alloc] init];
        for (NSDictionary *itemData in girlData) {
            CategoyItemInfo *itemInfo = [[CategoyItemInfo alloc] init];
            
            itemInfo.actionId = [[itemData objectForKey:@"actionId"]integerValue];
            itemInfo.categoryName = [itemData objectForKey:@"categoryName"];
            itemInfo.categoryL3Name = [itemData objectForKey:@"level3categoryName"];
            itemInfo.bookCount = [[itemData objectForKey:@"bookCount"] integerValue];
            itemInfo.imageName = [itemData objectForKey:@"img"];
            
            [girlCategoryListData addObject:itemInfo];
        }
        allCategoryData.girlCategoryList = girlCategoryListData;
        
        // OK
//        [self testData];
        
        // 异步处理数据后通知前台刷新控件数据，以后再讲！！！
        dispatch_async(dispatch_get_main_queue(), ^{
            [mainTableView reloadData];
        });
        
        
    }];
    [dataTask resume];
}


- (void)testData {
    NSLog(@"Line title is %@", allCategoryData.lineTitle);
    NSLog(@"BookCount is %ld", allCategoryData.allBookCount);
    NSLog(@"NewBookCount is %ld", allCategoryData.newBookCount);
    
    NSLog(@"===============Boy CategoryList==================");
    for (CategoyItemInfo *itemInfo in allCategoryData.boyCategoryList) {
        NSLog(@"Category Name is %@, actionId is %ld", itemInfo.categoryName, itemInfo.actionId);
    }
    
    NSLog(@"===============Girl CategoryList==================");
    for (CategoyItemInfo *itemInfo in allCategoryData.girlCategoryList) {
        NSLog(@"Category Name is %@, actionId is %ld", itemInfo.categoryName, itemInfo.actionId);
    }
}

- (void)loadNetworkData2 {
    [StackDataControl getCategoryListWithflag:flag requestCode:0 callBackDelegate:self];
}

- (void)callBackWithData:(id)data requestCode:(int)requestCode {
    dispatch_async(dispatch_get_main_queue(), ^{
        allCategoryData = data;
        [mainTableView reloadData];
    });
}

- (void)callBackWithErrorCode:(int)code message:(NSString *)message innerError:(NSError *)error requestCode:(int)requestCode {
    NSLog(@"错误");
    dispatch_async(dispatch_get_main_queue(), ^{
        // 显示错误信息
    });
}
@end
