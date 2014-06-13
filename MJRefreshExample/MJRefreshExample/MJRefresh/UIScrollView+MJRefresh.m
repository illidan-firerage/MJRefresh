//
//  UIScrollView+MJRefresh.m
//  MJRefreshExample
//
//  Created by MJ Lee on 14-5-28.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIScrollView+MJRefresh.h"
#import "MJRefreshHeaderView.h"
#import "MJRefreshFooterView.h"
#import <objc/runtime.h>

@interface UIScrollView()
@property (weak, nonatomic, readwrite) MJRefreshHeaderView *refreshHeader;
@property (weak, nonatomic, readwrite) MJRefreshFooterView *refreshFooter;
@end


@implementation UIScrollView (MJRefresh)

#pragma mark - 运行时相关
static char MJRefreshHeaderViewKey;
static char MJRefreshFooterViewKey;

- (void)setRefreshHeader:(MJRefreshHeaderView *)header {
    [self willChangeValueForKey:@"MJRefreshHeaderViewKey"];
    objc_setAssociatedObject(self, &MJRefreshHeaderViewKey,
                             header,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"MJRefreshHeaderViewKey"];
}

- (MJRefreshHeaderView *)refreshHeader {
    return objc_getAssociatedObject(self, &MJRefreshHeaderViewKey);
}

- (void)setRefreshFooter:(MJRefreshFooterView *)footer {
    [self willChangeValueForKey:@"MJRefreshFooterViewKey"];
    objc_setAssociatedObject(self, &MJRefreshFooterViewKey,
                             footer,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"MJRefreshFooterViewKey"];
}

- (MJRefreshFooterView *)refreshFooter {
    return objc_getAssociatedObject(self, &MJRefreshFooterViewKey);
}

#pragma mark - 下拉刷新
/**
 *  添加一个下拉刷新头部控件
 *
 *  @param callback 回调
 */
- (void)addHeaderWithCallback:(void (^)())callback
{
    // 1.创建新的header
    if (!self.refreshHeader) {
        MJRefreshHeaderView *header = [MJRefreshHeaderView header];
        [self addSubview:header];
        self.refreshHeader = header;
    }
    
    // 2.设置block回调
    self.refreshHeader.beginRefreshingCallback = callback;
}

/**
 *  添加一个下拉刷新头部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addHeaderWithTarget:(id)target action:(SEL)action
{
    // 1.创建新的header
    if (!self.refreshHeader) {
        MJRefreshHeaderView *header = [MJRefreshHeaderView header];
        [self addSubview:header];
        self.refreshHeader = header;
    }
    
    // 2.设置目标和回调方法
    self.refreshHeader.beginRefreshingTaget = target;
    self.refreshHeader.beginRefreshingAction = action;
}

/**
 *  移除下拉刷新头部控件
 */
- (void)removeHeader
{
    [self.refreshHeader removeFromSuperview];
    self.refreshHeader = nil;
}

/**
 *  主动让下拉刷新头部控件进入刷新状态
 */
- (void)headerBeginRefreshing
{
    [self.refreshHeader beginRefreshing];
}

/**
 *  让下拉刷新头部控件停止刷新状态
 */
- (void)headerEndRefreshing
{
    [self.refreshHeader endRefreshing];
}

/**
 *  下拉刷新头部控件的可见性
 */
- (void)setHeaderHidden:(BOOL)hidden
{
    self.refreshHeader.hidden = hidden;
}

- (BOOL)isHeaderHidden
{
    return self.refreshHeader.isHidden;
}

#pragma mark - 上拉刷新
/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param callback 回调
 */
- (void)addFooterWithCallback:(void (^)())callback
{
    // 1.创建新的footer
    if (!self.refreshFooter) {
        MJRefreshFooterView *footer = [MJRefreshFooterView footer];
        [self addSubview:footer];
        self.refreshFooter = footer;
    }
    
    // 2.设置block回调
    self.refreshFooter.beginRefreshingCallback = callback;
}

- (void)addFooterWithAutoLoading:(BOOL)autoLoading callback:(void (^)())callback
{
    // 1.创建新的footer
    if (!self.refreshFooter) {
        MJRefreshFooterView *footer = [MJRefreshFooterView footerWithAutoLoading:autoLoading];
        [self addSubview:footer];
        self.refreshFooter = footer;
    }
    
    // 2.设置block回调
    self.refreshFooter.beginRefreshingCallback = callback;
}

/**
 *  添加一个上拉刷新尾部控件
 *
 *  @param target 目标
 *  @param action 回调方法
 */
- (void)addFooterWithTarget:(id)target action:(SEL)action
{
    // 1.创建新的footer
    if (!self.refreshFooter) {
        MJRefreshFooterView *footer = [MJRefreshFooterView footer];
        [self addSubview:footer];
        self.refreshFooter = footer;
    }
    
    // 2.设置目标和回调方法
    self.refreshFooter.beginRefreshingTaget = target;
    self.refreshFooter.beginRefreshingAction = action;
}

- (void)addFooterWithTarget:(id)target action:(SEL)action autoLoading:(BOOL)autoLoading
{
    // 1.创建新的footer
    if (!self.refreshFooter) {
        MJRefreshFooterView *footer = [MJRefreshFooterView footerWithAutoLoading:autoLoading];
        [self addSubview:footer];
        self.refreshFooter = footer;
    }
    
    // 2.设置目标和回调方法
    self.refreshFooter.beginRefreshingTaget = target;
    self.refreshFooter.beginRefreshingAction = action;
}

/**
 *  移除上拉刷新尾部控件
 */
- (void)removeFooter
{
    [self.refreshFooter removeFromSuperview];
    self.refreshFooter = nil;
}

/**
 *  主动让上拉刷新尾部控件进入刷新状态
 */
- (void)footerBeginRefreshing
{
    [self.refreshFooter beginRefreshing];
}

/**
 *  让上拉刷新尾部控件停止刷新状态
 */
- (void)footerEndRefreshing
{
    [self.refreshFooter endRefreshing];
}

/**
 *  下拉刷新头部控件的可见性
 */
- (void)setFooterHidden:(BOOL)hidden
{
    self.refreshFooter.hidden = hidden;
}

- (BOOL)isFooterHidden
{
    return self.refreshFooter.isHidden;
}
@end
