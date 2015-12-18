//
//  BookLibraryViewController.m
//  Case01_BookReader
//
//  Created by 李海龙 on 15/11/23.
//  Copyright © 2015年 北京千锋互联科技有限公司（大连）. All rights reserved.
//

#import "BookLibraryViewController.h"
#import "SQLiteBookModel.h"
#import "DatabaseControl.h"
#import "BookLibraryTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "CommenDataDefine.h"

@interface BookLibraryViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
/**
 *  tableView的数据源数组
 */
@property (nonatomic, strong) NSMutableArray *datas;
/**
 *   操作数据库的属性
 */
@property (nonatomic, strong) DatabaseControl *dbc;

@property (nonatomic, strong) UIBarButtonItem *deleteItem;
@property (nonatomic, assign, getter=isSeleteEditBtn) BOOL isSeleteEditBtn;
@property (nonatomic, strong) UILabel *noDataLabel;

@end

@implementation BookLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dbc = [[DatabaseControl alloc] init];
    self.datas = [[NSMutableArray alloc] init];
//    self.datas = [NSMutableArray arrayWithArray:[self.dbc getBooks]];
    [self initNodataLabel];
//    [self.view addSubview:self.noDataView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveData:) name:@"addBook" object:nil];
    [self createTableView];
}

- (void)initNodataLabel {
    CGFloat labelH = 44;
    CGFloat labelW = 88;
    CGFloat marginX = (SIZE.width - labelW) / 2;
    CGFloat marginY = (SIZE.height - labelH) / 2;
    self.noDataLabel = [[UILabel alloc] initWithFrame:CGRectMake(marginX, marginY, labelW, labelH)];
    self.noDataLabel.text = @"暂无书籍";
    self.noDataLabel.textColor = [UIColor colorWithRed:188 / 255.f green:205 / 255.f blue:201 / 255.f alpha:1];
}
/**
 *  刷新页面，保存数据到数据库
 *
 *  @param sender <#sender description#>
 */
- (void)saveData:(NSNotification *)sender {
    SQLiteBookModel *model = (SQLiteBookModel *)sender.object;
    
    [self.dbc insertStudent:model];
    [self.datas insertObject:model atIndex:0];
    [self.tableView reloadData];
}

- (void)createTableView {
    self.datas = [NSMutableArray arrayWithArray:[self.dbc getBooks]];
    if (self.datas.count == 0) {
        [self.view addSubview:self.noDataLabel];
        return;
    } else {
        [self.noDataLabel removeFromSuperview];
    }
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 100;
    [self.tableView registerNib:[UINib nibWithNibName:@"BookLibraryTableViewCell" bundle:nil] forCellReuseIdentifier:@"LibraryCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewDidAppear:(BOOL)animated {
    self.parentViewController.navigationItem.title = @"书架";
//    self.parentViewController.navigationItem.leftBarButtonItem = self.editButtonItem;
    [self setDeleteAndEditBtn];
    [self createTableView];
}

- (void)viewWillDisappear:(BOOL)animated {
    self.parentViewController.navigationItem.title = nil;
    self.parentViewController.navigationItem.leftBarButtonItem = nil;
    self.deleteItem = nil;
}

#pragma mark -k 数据源的方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SQLiteBookModel *model = self.datas[indexPath.row];
    BookLibraryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LibraryCell" forIndexPath:indexPath];
    
    NSString *imageName = [NSString stringWithFormat:@"http://wfqqreader.3g.qq.com/cover/%ld/%ld/t4_%ld.jpg", [model.bid integerValue] - ([model.bid integerValue]/1000)*1000, [model.bid integerValue], [model.bid integerValue]];
    cell.bookLastCnameLable.text = model.lastCname;
    cell.bookTitleLable.text = model.title;
    [cell.bookImageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:nil];
    [cell.bookImageView.layer setCornerRadius:5];
    [cell.bookImageView.layer setMasksToBounds:YES];
    return cell;
}

- (void)setDeleteAndEditBtn
{
    // 下边是编辑按钮
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(clickEditBtn)];

    self.parentViewController.navigationItem.leftBarButtonItem = edit;

    UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(clickDeleteBtn:)];
    self.deleteItem = deleteItem;
}

/**
 *  点击删除触发的事件
 */
- (void)clickDeleteBtn:(UIBarButtonItem *)sender{
    NSArray *array = [_tableView indexPathsForSelectedRows];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSIndexPath *indexpath in array) {
        [arrayM addObject:[NSNumber numberWithInteger:indexpath.row]];
    }
    //sort
    NSArray *arraySort = [ arrayM sortedArrayUsingSelector:@selector(compare:)];
    //10 - > 1 删除
    for (NSInteger i = array.count - 1; i >= 0;i --) {
        NSInteger index = [arraySort[i] integerValue];
        SQLiteBookModel *model = [self.datas objectAtIndex:i];
        [self.datas removeObjectAtIndex:index];
        [self.dbc deleteStudent:model];
    }
    [_tableView deleteRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationFade];
    [self createTableView];
}

/**
 *  点击编辑触发的事件
 */
- (void)clickEditBtn
{
    
    self.isSeleteEditBtn = !self.isSeleteEditBtn;
    [self.tableView setEditing:self.isSeleteEditBtn animated:YES];
    
    // 允许table多选
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    
    if (self.isSeleteEditBtn) {
        self.parentViewController.navigationItem.rightBarButtonItem = self.deleteItem;
    } else {
        self.parentViewController.navigationItem.rightBarButtonItem = nil;
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}



//#pragma mark 点击编辑按钮触发的事件
//- (void)setEditing:(BOOL)editing animated:(BOOL)animated
//{
//    // 1. 重写编辑按钮点击事件 首先要调用父类的方法
//    [super setEditing:editing animated:YES];
//    
//    // 2. 打开UITableView 的编辑模式
//    [_tableView setEditing:editing animated:YES];
//    
//}
//
//// 3. 允许row 编辑
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
//// 4. 设置编辑样式
//- (UITableViewCellEditingStyle )tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //    UITableViewCellEditingStyleNone,
//    //    UITableViewCellEditingStyleDelete,
//    //    UITableViewCellEditingStyleInsert
//    return UITableViewCellEditingStyleDelete;
//}
//
//// 5. 提交编辑效果
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // 从数据源删除数据
//        [self.datas removeObjectAtIndex:indexPath.row];
//        SQLiteBookModel *model = [[SQLiteBookModel alloc] init];
//        model = self.datas[indexPath.row];
//        [self.dbc deleteStudent:model];
//        // 提交并刷新列表
//        [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
//}


@end
