//
//  MJRefreshBaseView.h
//  MJRefresh
//  
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.

#import <UIKit/UIKit.h>

@class MJRefreshBaseView;

#pragma mark - 控件的刷新状态
typedef enum {
	MJRefreshStatePulling = 1, // 松开就可以进行刷新的状态
	MJRefreshStateNormal = 2, // 普通状态
	MJRefreshStateRefreshing = 3, // 正在刷新中的状态
    MJRefreshStateWillRefreshing = 4
} MJRefreshState;

#pragma mark - 控件的类型
typedef enum {
    MJRefreshViewTypeHeader = -1, // 头部控件
    MJRefreshViewTypeFooter = 1 // 尾部控件
} MJRefreshViewType;

/**
 类的声明
 */
@interface MJRefreshBaseView : UIView <UIAppearance>

// 刷新箭头图片名称
@property (nonatomic, copy) NSString *arrowImageName UI_APPEARANCE_SELECTOR;

// 拉动时默认标题
@property (nonatomic, copy) NSString *pullNormalTitle UI_APPEARANCE_SELECTOR;

// 拉动时松手标题
@property (nonatomic, copy) NSString *pullReleaseTitle UI_APPEARANCE_SELECTOR;

// 拉动时刷新标题
@property (nonatomic, copy) NSString *pullRefreshingTitle UI_APPEARANCE_SELECTOR;

// 最后更新时间标题
@property (nonatomic, copy) NSString *lastRefreshingDateTitle UI_APPEARANCE_SELECTOR;

#pragma mark - 父控件
@property (nonatomic, weak, readonly) UIScrollView *scrollView;
@property (nonatomic, assign, readonly) UIEdgeInsets scrollViewOriginalInset;

#pragma mark - 内部的控件
@property (nonatomic, weak, readonly) UILabel *statusLabel;
@property (nonatomic, weak, readonly) UIImageView *arrowImage;
@property (nonatomic, weak, readonly) UIActivityIndicatorView *activityView;

@property (assign, nonatomic) BOOL arrowHidden;

#pragma mark - 回调
/**
 *  开始进入刷新状态的监听器
 */
@property (weak, nonatomic) id beginRefreshingTaget;
/**
 *  开始进入刷新状态的监听方法
 */
@property (assign, nonatomic) SEL beginRefreshingAction;
/**
 *  开始进入刷新状态就会调用
 */
@property (nonatomic, copy) void (^beginRefreshingCallback)();

#pragma mark - 刷新相关
/**
 *  是否正在刷新
 */
@property (nonatomic, readonly, getter=isRefreshing) BOOL refreshing;

/**
 *  开始刷新
 */
- (void)beginRefreshing;
/**
 *  结束刷新
 */
- (void)endRefreshing;

#pragma mark - 交给子类去实现 和 调用
@property (assign, nonatomic) MJRefreshState state;
@end