


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum{
	EGOOPullRefreshPulling = 0,
	EGOOPullRefreshNormal,
	EGOOPullRefreshLoading,
} EGOPullRefreshState;

typedef enum {
    LOAD,FRESH
}loadType;

typedef enum {
    HEAD,FOOT
}freshViewType;


@protocol EGORefreshTableHeaderDelegate;
@interface EGORefreshTableHeaderView : UIView {
	
	id _delegate;
	EGOPullRefreshState miStates;
    
	UILabel *_lastUpdatedLabel;
	UILabel *_statusLabel;
	CALayer *_arrowImage;
	UIActivityIndicatorView *_activityView;
    //    NSInteger _loadTag;
    freshViewType type;
    BOOL _reloading;
}

//@property NSInteger loadTag;
@property (nonatomic, assign) UITableView * tableViewLeft;
@property (nonatomic, assign) UITableView * tableViewRight;
@property(nonatomic,assign) id <EGORefreshTableHeaderDelegate> delegate;
@property EGOPullRefreshState states;
@property(nonatomic,assign) freshViewType type;


- (void)refreshLastUpdatedDate;
- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;
-(id)initHeadFreshView;
-(id)initFootFreshView;
- (void)setViewState:(EGOPullRefreshState)aState;



@end
@protocol EGORefreshTableHeaderDelegate
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view loadType:(freshViewType)type;
//- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view;
@optional
//- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view;
@end
