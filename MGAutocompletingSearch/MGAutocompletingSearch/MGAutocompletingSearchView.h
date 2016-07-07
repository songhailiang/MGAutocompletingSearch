//
//  MGAutocompletingSearchView.h
//  MGAutocompletingSearch
//
//  Created by 宋海梁 on 16/6/30.
//
//

#import <UIKit/UIKit.h>

@class MGAutocompletingSearchView;

@protocol MGAutocompletingSearchViewDelegate <NSObject>

@required
//搜索内容改变时回调
- (void)searchView:(MGAutocompletingSearchView *)searchView searchTextDidChanged:(NSString *)searchText;
//指定suggestTable中的行数
- (NSInteger)searchView:(MGAutocompletingSearchView *)searchView numberOfRowsInSection:(NSInteger)section;
/**
 *  指定suggestTable中indexPath的Cell
 *  suggestTable默认注册了UITableViewCell（reuseIdentifier=NSStringFromClass([UITableViewCell class])）
 */
- (UITableViewCell *)searchView:(MGAutocompletingSearchView *)searchView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (void)searchViewDidHidden:(MGAutocompletingSearchView *)searchView;
- (NSInteger)searchView:(MGAutocompletingSearchView *)searchView numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)searchView:(MGAutocompletingSearchView *)searchView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)searchView:(MGAutocompletingSearchView *)searchView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

//点击键盘上的搜索按钮时会执行此delegate
- (void)searchView:(MGAutocompletingSearchView *)searchView didSearchWithSearchText:(NSString *)searchText;
@end

@interface MGAutocompletingSearchView : UIView

@property (nonatomic, weak) id<MGAutocompletingSearchViewDelegate> delegate;

@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UITableView *suggestTable;

//是否激活状态
@property (nonatomic, assign, readonly) BOOL isActive;
//是否显示蒙屏背景（默认YES）
@property (nonatomic, assign) BOOL dimsBackground;

- (instancetype)initWithViewController:(UIViewController *)viewController;

//显示在navigationbar的titleView中
- (void)showInNavigationbar;

//隐藏SearchView，会移除searchTextField和suggestTable
- (void)hidden;

//刷新suggestTable数据
- (void)reloadData;

@end
