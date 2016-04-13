//
//  ViewController.m
//  KtTableView
//
//  Created by baidu on 16/4/13.
//  Copyright © 2016年 zxy. All rights reserved.
//

#import "KTMainViewController.h"
#import "KtMainTableViewCell.h"

@interface KTMainViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *items;

@end

@implementation KTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.items = [NSMutableArray arrayWithObjects:@"第一条消息", @"第二条消息", @"第三条消息", @"第四条消息", @"第五条消息", nil];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init]; // 去掉多余分割线
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"KtMainTableViewCell";
    [self.tableView registerClass:[KtMainTableViewCell class] forCellReuseIdentifier:identifier];
    
    KtMainTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath]; // 会调用到 initWithStyle:reuseIdentifier: 方法
    cell.textLabel.text = [self.items objectAtIndex:[indexPath row]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
