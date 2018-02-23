//
//  ZRLogConsoleView.m
//  RescueExam
//
//  Created by Ryan on 2017/12/5.
//  Copyright © 2017年 xiaohesong. All rights reserved.
//

#import "ZRLogConsoleView.h"
#import "ZRLogModel.h"
#import "ZRLogHelper.h"

@interface ZRLogConsoleView()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIButton *closeBtn;
@property (nonatomic, weak) UIButton *deleteBtn;

@property (nonatomic, weak) UIView *line;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic,weak) UITextView *detailTextView;

@property (nonatomic, weak) UIButton *cancelBtn;
/**
 日志数组
 */
@property (nonatomic, copy) NSArray *arrLog;
@end

@implementation ZRLogConsoleView

+ (void)show {
    ZRLogConsoleView *consoleView = [[ZRLogConsoleView alloc] init];
    [[UIApplication sharedApplication].keyWindow addSubview:consoleView];
    consoleView.frame = [UIApplication sharedApplication].keyWindow.bounds;
}

- (void)close {
    [self removeFromSuperview];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (NSArray *)arrLog {
    return [ZRLogHelper shareInstance].arrLog;
}

- (void)setupUI {
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"log日志";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIButton *closeBtn = [[UIButton alloc] init];
    [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [closeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self addSubview:closeBtn];
    self.closeBtn = closeBtn;

    UIButton *deleteBtn = [[UIButton alloc] init];
    [deleteBtn setTitle:@"全部删除" forState:UIControlStateNormal];
    [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [deleteBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self addSubview:deleteBtn];
    self.deleteBtn = deleteBtn;
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor grayColor];
    [self addSubview:line];
    self.line = line;
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self addSubview:tableView];
    self.tableView = tableView;

    UITextView *detailTextView = [[UITextView alloc] init];
    [self addSubview:detailTextView];
    self.detailTextView = detailTextView;
    detailTextView.hidden = YES;
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [detailTextView addSubview:cancelBtn];
    self.cancelBtn = cancelBtn;
    
//    tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
//        [self.tableView reloadData];
//        [self.tableView.mj_header endRefreshing];
//    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat itemW = self.frame.size.width;
    CGFloat itemH = self.frame.size.height;
    
    self.titleLabel.frame = CGRectMake((itemW - 150) / 2, 20,150, 44);
    self.closeBtn.frame = CGRectMake(0, 20, 100, 44);
    self.deleteBtn.frame = CGRectMake(itemW - 100, 20, 100, 44);
    self.line.frame = CGRectMake(0, 63, itemW, 0.5);
    self.tableView.frame = CGRectMake(0, 64, itemW, itemH - 64);
    self.detailTextView.frame = self.bounds;
    self.cancelBtn.frame = CGRectMake(itemW - 100, 0, 100, 64);
}

- (void)closeBtnClick {
    [self close];
}

- (void)deleteBtnClick {
    [[ZRLogHelper shareInstance] deleteAllLog];
    [self.tableView reloadData];
}

- (void)cancelBtnClick {
    self.detailTextView.hidden = YES;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrLog.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    ZRLogModel *logModel = self.arrLog[indexPath.row];
    
    cell.textLabel.text = logModel.title;
    cell.detailTextLabel.text = logModel.time;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZRLogModel *logModel = self.arrLog[indexPath.row];
    
    self.detailTextView.text = logModel.content;
    self.detailTextView.hidden = NO;
}
@end
