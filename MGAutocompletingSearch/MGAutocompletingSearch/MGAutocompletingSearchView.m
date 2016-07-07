//
//  MGAutocompletingSearchView.m
//  MGAutocompletingSearch
//
//  Created by 宋海梁 on 16/6/30.
//
//

#import "MGAutocompletingSearchView.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define kSearchTextFieldHeight  35.0

@interface MGAutocompletingSearchView ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic, weak) UIViewController *viewController;

@property (nonatomic, strong) UIView *backgroundView;

@property (nonatomic, weak) NSTimer *delayTimer;

@property (nonatomic, assign) BOOL isActive;

@end

@implementation MGAutocompletingSearchView

#pragma mark - Life Circle

- (instancetype)initWithViewController:(UIViewController *)viewController {

    self = [super init];
    if (self) {
        self.viewController = viewController;
        [self setupUI];
    }
    
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:_searchTextField];
}

#pragma mark - UI

- (void)setupUI {

    UITapGestureRecognizer *backgroundViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewTapped:)];
    self.backgroundView.userInteractionEnabled = YES;
    [self.backgroundView addGestureRecognizer:backgroundViewTap];
    
    //设置默认值
    self.dimsBackground = YES;
}

#pragma mark - Public Method

- (void)showInNavigationbar {
    
    _isActive = YES;

    self.viewController.navigationItem.titleView = self.searchTextField;
    
    if (self.dimsBackground) {
        [self.viewController.view addSubview:self.backgroundView];
    }
}

- (void)hidden {

    _isActive = NO;
    
    self.viewController.navigationItem.titleView = nil;
    [self.backgroundView removeFromSuperview];
    [self.suggestTable removeFromSuperview];
    self.searchTextField.text = @"";
    
    if (_delayTimer) {
        [_delayTimer invalidate];
        _delayTimer = nil;
    }
    
    if ([self.delegate respondsToSelector:@selector(searchViewDidHidden:)]) {
        [self.delegate searchViewDidHidden:self];
    }
}

- (void)reloadData {
    
    if (!_isActive) {
        return;
    }

    [self.suggestTable reloadData];
    
    //有数据
    if ([self mg_itemsCount] > 0) {
        if (!self.suggestTable.superview) {
            self.suggestTable.frame = self.viewController.view.bounds;
            [self.viewController.view addSubview:self.suggestTable];
        }
    }
    else {
        [self.suggestTable removeFromSuperview];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchView:numberOfSectionsInTableView:)]) {
        return [self.delegate searchView:self numberOfSectionsInTableView:tableView];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchView:numberOfRowsInSection:)]) {
        return [self.delegate searchView:self numberOfRowsInSection:section];
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchView:cellForRowAtIndexPath:)]) {
        return [self.delegate searchView:self cellForRowAtIndexPath:indexPath];
    }
    
    return [UITableViewCell new];
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchView:heightForRowAtIndexPath:)]) {
        return [self.delegate searchView:self heightForRowAtIndexPath:indexPath];
    }
    
    return 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_delayTimer) {
        [_delayTimer invalidate];
        _delayTimer = nil;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchView:didSelectRowAtIndexPath:)]) {
        [self.delegate searchView:self didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark - UIScrollView delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    if (scrollView == self.suggestTable) {
        [self.searchTextField resignFirstResponder];
    }
}

#pragma mark - UITextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (!textField.text.length) {
        return NO;
    }
    
    if (_delayTimer) {
        [_delayTimer invalidate];
        _delayTimer = nil;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchView:didSearchWithSearchText:)]) {
        [self.delegate searchView:self didSearchWithSearchText:textField.text];
    }
    
    return YES;
}

#pragma mark - Private Method

- (void)backgroundViewTapped:(UITapGestureRecognizer *)recognizer {

    [self hidden];
}

- (void)searchTextDidChange {

    if (_delayTimer) {
        [_delayTimer invalidate];
        _delayTimer = nil;
    }
    
    _delayTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(doSearch) userInfo:nil repeats:NO];
}

- (void)doSearch {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchView:searchTextDidChanged:)]) {
        [self.delegate searchView:self searchTextDidChanged:self.searchTextField.text];
    }
    
    _delayTimer = nil;
}

- (NSInteger)mg_itemsCount {
    NSInteger items = 0;
    
    if (![self.suggestTable respondsToSelector:@selector(dataSource)]) {
        return items;
    }
    
    id <UITableViewDataSource> dataSource = [self.suggestTable performSelector:@selector(dataSource)];
    
    NSInteger sections = 1;
    if ([dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [dataSource numberOfSectionsInTableView:self.suggestTable];
    }
    
    for (NSInteger i = 0; i < sections; i++) {
        items += [dataSource tableView:self.suggestTable numberOfRowsInSection:i];
    }
    
    return items;
}

#pragma mark - Property

- (UITextField *)searchTextField {
    
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH-40, kSearchTextFieldHeight)];
        _searchTextField.font = [UIFont systemFontOfSize:14.0];
        _searchTextField.layer.cornerRadius = 5;
        _searchTextField.clearButtonMode = UITextFieldViewModeAlways;
        _searchTextField.backgroundColor = [UIColor colorWithRed:228/255.0 green:228/255.0 blue:228/255.0 alpha:1.0];
        _searchTextField.returnKeyType = UIReturnKeySearch;
        _searchTextField.inputAccessoryView = [UIView new];
        _searchTextField.enablesReturnKeyAutomatically = YES;
        _searchTextField.delegate = self;
        _searchTextField.placeholder = @"搜索...";
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchTextDidChange) name:UITextFieldTextDidChangeNotification object:_searchTextField];
    }
    return _searchTextField;
}

- (UIView *)backgroundView {

    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:self.viewController.view.frame];
        _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.66];
    }
    
    return _backgroundView;
}

- (UITableView *)suggestTable {

    if (!_suggestTable) {
        _suggestTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _suggestTable.delegate = self;
        _suggestTable.dataSource = self;
        _suggestTable.tableFooterView = [UIView new];
        
        [_suggestTable registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _suggestTable;
}

@end
