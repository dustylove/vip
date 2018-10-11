# vip
一款简单实用的vipView
```
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    NSArray *imgs = @[[UIImage imageNamed:@"会员"],[UIImage imageNamed:@"会员"],[UIImage imageNamed:@"会员"],[UIImage imageNamed:@"会员"],[UIImage imageNamed:@"会员"],[UIImage imageNamed:@"会员"]];
    NSArray *titles = @[@"vip",@"vip1",@"vip2",@"vip3",@"vip4",@"vip5"];
    ArcView *view = [[ArcView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300) imgs:imgs titles:titles maxScale:1.4 margin:UIEdgeInsetsMake(0, 50, 20, 50) defultIndex: 2 actionBlock:^(NSInteger index) {
        NSLog(@"滑到--%ld",(long)index);
    }];
    [self.view addSubview:view];
}
```
