//
//  Demo1Controller.m
//  MGAutocompletingSearch
//
//  Created by 宋海梁 on 16/7/6.
//
//

#import "Demo1Controller.h"
#import "UIViewController+NavigationBar.h"
#import "UITextField+Extension.h"
#import "MGAutocompletingSearchView.h"

#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self

@interface Demo1Controller ()<MGAutocompletingSearchViewDelegate>

@property (nonatomic, strong) MGAutocompletingSearchView *searchView;

@property (nonatomic, strong) NSArray *allItems;
@property (nonatomic, strong) NSArray *suggestItems;

@end

@implementation Demo1Controller

#pragma mark - Life Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupViewUI];
    [self prepareDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    NSLog(@"【dealloc】%@", NSStringFromClass([self class]));
}

#pragma mark - UI

- (void)setupViewUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.searchView = [[MGAutocompletingSearchView alloc] initWithViewController:self];
    self.searchView.delegate = self;
    [self.searchView.searchTextField setPaddingLeftSpace:15.0f];
    self.searchView.suggestTable.backgroundColor = [UIColor clearColor];
    
    WeakSelf(weakSelf);
    [self setNavigationBar:NavigationBarPositionRight withImageName:@"search_icon" touched:^{
        [weakSelf showSearchView];
    }];
}

- (void)showSearchView {
    
    [self.searchView showInNavigationbar];
    [self.searchView.searchTextField becomeFirstResponder];
    [self setNavigationBar:NavigationBarPositionRight withText:@"搜索" touched:^{
        //TODO: do search job...
        NSLog(@"do search job...");
    }];
    
    WeakSelf(weakSelf);
    [self setNavigationBar:NavigationBarPositionLeft withText:@"取消" touched:^{
        [weakSelf.searchView hidden];
    }];
}

#pragma mark - Data

- (void)prepareDataSource {
    
    self.allItems = [@[
                       @"Debbie Cawthon", @"Philip Mahan", @"Susie Sloan", @"Melinda Wurth", @"Flora Bible",
                       @"Marlene Collier", @"John Trammell", @"Kristina Chun", @"Linda Caldera", @"Veronica Jaime",
                       @"Rosie Melo", @"Joyce Vella", @"Douglas Leger", @"Brandon Koon", @"Rachel Peeples",
                       @"Vicki Castor", @"Benjamin Lynch", @"Velma Vann", @"Della Sherrer", @"Aaron Lyle",
                       @"Arthur Jonas", @"Irma Atwood", @"Randy Cheatham", @"Billy Voyles", @"Michele Crouch",
                       @"Kenneth Shankle", @"Fred Anglin", @"Dennis Fries", @"Lillie Albertson", @"Iris Bertram"
                       ] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                           return [(NSString*)obj1 compare:(NSString*)obj2];
                       }];
}

#pragma mark - MGAutocompletingSearchViewDelegate

- (void)searchViewDidHidden:(MGAutocompletingSearchView *)searchView {
    
    self.navigationItem.leftBarButtonItems = nil;
    
    WeakSelf(weakSelf);
    [self setNavigationBar:NavigationBarPositionRight withImageName:@"search_icon" touched:^{
        [weakSelf showSearchView];
    }];
}

- (void)searchView:(MGAutocompletingSearchView *)searchView searchTextDidChanged:(NSString *)searchText {
    
    NSLog(@"searchText:%@",searchText);
    //do something like http request....
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",searchText];
        self.suggestItems = [self.allItems filteredArrayUsingPredicate:pred];
        [self.searchView reloadData];
    });
}

- (NSInteger)searchView:(MGAutocompletingSearchView *)searchView numberOfRowsInSection:(NSInteger)section {
    
    return self.suggestItems.count;
}

- (UITableViewCell *)searchView:(MGAutocompletingSearchView *)searchView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [searchView.suggestTable dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [self.suggestItems objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

@end
