# MGAutocompletingSearch

将用于展示suggest的TableView进行简单的封装，跟主ViewController的TableView Delegate分离，方便管理，不至于混淆。

1. 搜索输入框激活时，支持蒙屏，蒙屏点击后可隐藏搜索输入框
2. 支持自定义suggest的TableViewCell，为了能灵活用于各种奇葩的TableViewCell，已经将suggestTable属性暴露出来，可自行registe自定义的tableviewcell
3. 实现延迟搜索，快速输入文字期间不会回调，只有输入完一定时间间隙后才回调，可避免频繁请求服务端接口

# 效果

![] (https://github.com/songhailiang/MGAutocompletingSearch/blob/master/screenshot/screenshot1.gif)
![] (https://github.com/songhailiang/MGAutocompletingSearch/blob/master/screenshot/screenshot2.gif)


