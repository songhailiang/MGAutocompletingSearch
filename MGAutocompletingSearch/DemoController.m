//
//  DemoController.m
//  MGAutocompletingSearch
//
//  Created by 宋海梁 on 16/7/6.
//
//

#import "DemoController.h"
#import "UIViewController+NavigationBar.h"
#import "Demo1Controller.h"
#import "Demo2Controller.h"

@interface DemoController ()

@end

@implementation DemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"MGAutocompletingSearchView";
    [self setLeftNavigationBarToBack];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"默认样式";
    }
    else {
        cell.textLabel.text = @"自定义展示Cell";
    }
    
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row == 0) {
        Demo1Controller *vc = [Demo1Controller new];
        vc.navigationItem.title = cell.textLabel.text;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        Demo2Controller *vc = [Demo2Controller new];
        vc.navigationItem.title = cell.textLabel.text;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
