//
//  ViewController.m
//  联动
//
//  Created by 123 on 2019/10/16.
//  Copyright © 2019 123. All rights reserved.
//

#import "ViewController.h"
#import "TitleButton.h"
#import "VideoViewController.h"
#import "VoiceViewController.h"
#import "WordViewController.h"
#import "PictureViewController.h"
#import "AllViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIView *titlesView;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) TitleButton *previousClickedTitleVutton;
@property (nonatomic, weak) UIView *titleUnderline;
@end

@implementation ViewController

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加自控制器
    [self setupAllChildVcs];
    
    [self setScrollView];
    
    [self setTitlesView];
    // Do any additional setup after loading the view.
}

- (void)setupAllChildVcs
{
    [self addChildViewController:[[AllViewController alloc] init]];
    [self addChildViewController:[[VoiceViewController alloc] init]];
    [self addChildViewController:[[VideoViewController alloc] init]];
    [self addChildViewController:[[WordViewController alloc] init]];
    [self addChildViewController:[[PictureViewController alloc] init]];
}

- (void)setScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    //    scrollView.backgroundColor = [UIColor greenColor];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    [self.scrollView setPagingEnabled:YES];
    self.scrollView.delegate = self;
    for (NSUInteger i = 0; i < 5; i++) {
        //        UITableView *tableView = [[UITableView alloc] init];
        //        tableView.frame = CGRectMake(i * scrollView.frame.size.width, 79, scrollView.frame.size.width, scrollView.frame.size.height);
        //        tableView.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
        //        [scrollView addSubview:tableView];
    }
    for (NSUInteger i = 0; i < 5; i++) {
        //子控制器view
        UIView *childVcView = self.childViewControllers[i].view;
        childVcView.frame = CGRectMake(i * scrollView.frame.size.width, 79, scrollView.frame.size.width, scrollView.frame.size.height);
        [scrollView addSubview:childVcView];
    }
    scrollView.contentSize = CGSizeMake(5 * scrollView.frame.size.width, 0);
}

/**
 * 标题栏
 */
- (void)setTitlesView {
    UIView *titlesView = [[UIView alloc]init];
    titlesView.frame = CGRectMake(0, 44, self.view.bounds.size.width, 35);
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    [self setupTitleButtons];
    
    //标题下划线
    [self setupTitleUnderline];
}

- (void)setupTitleButtons {
    NSArray *arr = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    CGFloat btnSize = self.view.bounds.size.width / 5;
    for (NSInteger i = 0; i < 5; i++) {
        TitleButton *titleButton = [[TitleButton alloc] init];
        titleButton.tag = i;
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesView addSubview:titleButton];
        titleButton.frame = CGRectMake(i * btnSize, 0, btnSize, 35);
        [titleButton setTitle:arr[i] forState:UIControlStateNormal];
    }
}

- (void)setupTitleUnderline
{
    TitleButton *firstTitleButton = self.titlesView.subviews.firstObject;
    
    //下划线
    UIView *titleUnderline = [[UIView alloc] init];
    titleUnderline.frame = CGRectMake(0, 35, 70, 2);
    titleUnderline.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    [self.titlesView addSubview:titleUnderline];
    self.titleUnderline = titleUnderline;
    //默认点击第一个按钮
    [self titleButtonClick:firstTitleButton];
}

#pragma mark - 监听
- (void)titleButtonClick:(TitleButton *)titleButton {
    //    [self.previousClickedTitleVutton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    //    [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //    self.previousClickedTitleVutton = titleButton;
    self.previousClickedTitleVutton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedTitleVutton = titleButton;
    
    [UIView animateWithDuration:0.15 animations:^{
        CGRect temp = self.titleUnderline.bounds;
        temp.size.width = [titleButton.currentTitle sizeWithAttributes:@{ NSFontAttributeName: titleButton.titleLabel.font }].width;
        self.titleUnderline.bounds = temp;
        
        self.titleUnderline.center = CGPointMake(titleButton.frame.origin.x + titleButton.frame.size.width / 2, 35);
        //滚动scrollView
        //        NSUInteger index = [self.titlesView.subviews indexOfObject:titleButton];
        CGFloat OffsetX = self.scrollView.bounds.size.width * titleButton.tag;
        self.scrollView.contentOffset = CGPointMake(OffsetX, self.scrollView.contentOffset.y);
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //求出按钮的索引
    NSUInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    TitleButton *titleButton = self.titlesView.subviews[index];
    [self titleButtonClick:titleButton];
}

@end
