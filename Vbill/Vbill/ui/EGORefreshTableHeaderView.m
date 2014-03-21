


#define  RefreshViewHight 65.0f

#import "EGORefreshTableHeaderView.h"
#import "Common.h"


//#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define TEXT_COLOR	 [UIColor blackColor]
//#define TEXT_COLOR [UIColor colorWithRed:196/255.0f green:196/255.0f blue:196/255.0f alpha:1.0f]

#define FLIP_ANIMATION_DURATION 0.25f


@implementation EGORefreshTableHeaderView

@synthesize delegate=_delegate;
@synthesize tableViewLeft = mpTableViewLeft;
@synthesize tableViewRight = mpTableViewRight;
@synthesize states = miStates;
@synthesize type;


-(void)addSubviewsDown
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, RefreshViewHight - 30.0f, 320.0f, 20.0f)];
    label.font = [UIFont systemFontOfSize:12.0f];
    label.textColor = TEXT_COLOR;
    //    label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    //    label.shadowOffset = CGSizeMake(0.0f, 1.0f);
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    _lastUpdatedLabel=label;
    [label release];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, RefreshViewHight - 48.0f,  320.0f, 20.0f)];
    label.font = [UIFont boldSystemFontOfSize:13.0f];
    label.textColor = TEXT_COLOR;
    //    label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    //    label.shadowOffset = CGSizeMake(0.0f, 1.0f);
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    _statusLabel=label;
    [label release];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(25.0f, 10, 30.0f, 55.0f);
    layer.contentsGravity = kCAGravityResizeAspect;
    layer.contents = (id)[UIImage imageNamed:@"grayArrow.png"].CGImage;
    
    
    [[self layer] addSublayer:layer];
    _arrowImage=layer;
    
    UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    view.frame = CGRectMake(25.0f, RefreshViewHight - 38.0f, 20.0f, 20.0f);
    [self addSubview:view];
    _activityView = view;
    [view release];
}

-(void)addSubviewsUp

{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, RefreshViewHight - 30.0f + 580, 320, 20.0f)];
    label.font = [UIFont systemFontOfSize:12.0f];
    label.textColor = TEXT_COLOR;
    //    label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    //    label.shadowOffset = CGSizeMake(0.0f, 1.0f);
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    _lastUpdatedLabel=label;
    [label release];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, RefreshViewHight - 48.0f + 580, 320, 20.0f)];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.font = [UIFont boldSystemFontOfSize:13.0f];
    label.textColor = TEXT_COLOR;
    //    label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
    //    label.shadowOffset = CGSizeMake(0.0f, 1.0f);
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    _statusLabel=label;
    [label release];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(25.0f, RefreshViewHight - RefreshViewHight + 580, 30.0f, 55.0f);
    layer.contentsGravity = kCAGravityResizeAspect;
    layer.contents = (id)[UIImage imageNamed:@"grayArrow.png"].CGImage;
    
    
    [[self layer] addSublayer:layer];
    _arrowImage=layer;
    
    UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    view.frame = CGRectMake(25.0f, RefreshViewHight - 38.0f + 580, 20.0f, 20.0f);
    [self addSubview:view];
    _activityView = view;
    [view release];
}

-(void)addSubviews
{
    if (type == FOOT) {
        [self addSubviewsDown];
    } else {
        [self addSubviewsUp];
    }
    [self setViewState:EGOOPullRefreshNormal];
}


-(id)initHeadFreshView
{
    CGRect freshFrame = CGRectMake(0.0f, -650, 320, 650);
    self = [super initWithFrame: freshFrame];
    if (self) {
        self.backgroundColor = cellBackColor;
        type = HEAD;
        [self addSubviews];
        [self refreshLastUpdatedDate];
    }
    return self;
}

-(id)initFootFreshView
{
    CGRect freshFrame = CGRectZero;
    self = [super initWithFrame: freshFrame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        type = FOOT;
        [self addSubviews];
        self.clipsToBounds = YES;
        [self refreshLastUpdatedDate];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


#pragma mark -
#pragma mark Setters

- (void)refreshLastUpdatedDate {
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setAMSymbol:@"上午"];
    [formatter setPMSymbol:@"下午"];
    [formatter setDateFormat:@"yyyy/MM/dd hh:mm:ss a"];
    
    if (type == FOOT) {
        _lastUpdatedLabel.text = [NSString stringWithFormat:@"最后加载: %@", [formatter stringFromDate:date]];
    } else {
        _lastUpdatedLabel.text = [NSString stringWithFormat:@"最后更新: %@", [formatter stringFromDate:date]];
    }
    //    NSString * key = [@"EGORefreshTableView_LastRefresh" stringByAppendingFormat:@"%d", _loadTag];
    //    [[NSUserDefaults standardUserDefaults] setObject:_lastUpdatedLabel.text forKey:key];
    //    [[NSUserDefaults standardUserDefaults] synchronize];
    [formatter release];
}

- (void)setViewState:(EGOPullRefreshState)aState{
    
	switch (aState) {
		case EGOOPullRefreshPulling:
			if (type == FOOT) {
                _statusLabel.text = @"松开即可加载...";
                
            } else {
                _statusLabel.text = @"松开即可更新...";
            }
			[CATransaction begin];
			[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
			_arrowImage.transform = CATransform3DMakeRotation((M_PI / 180.0) * 180.0f, 0.0f, 0.0f, 1.0f);
			[CATransaction commit];
			
			break;
		case EGOOPullRefreshNormal:
            if (miStates == EGOOPullRefreshPulling) {
				[CATransaction begin];
				[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
				_arrowImage.transform = CATransform3DIdentity;
				[CATransaction commit];
			}
			if (type == FOOT) {
                _statusLabel.text = @"上拉即可加载...";
                
            } else {
                _statusLabel.text = @"下拉即可更新...";
            }
            
            [_activityView stopAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
			_arrowImage.hidden = NO;
			_arrowImage.transform = CATransform3DIdentity;
			[CATransaction commit];
			break;
		case EGOOPullRefreshLoading:
            _reloading = YES;
            [self performSelector:@selector(egoRefreshScrollViewDataSourceDidFinishedLoading:) withObject:[self superview] afterDelay:20];
			_statusLabel.text = NSLocalizedString(@"加载中...", @"加载中...");
			[_activityView startAnimating];
			[CATransaction begin];
			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
			_arrowImage.hidden = YES;
			[CATransaction commit];
			break;
		default:
			break;
	}
	miStates = aState;
}


#pragma mark -
#pragma mark ScrollView Methods

//手指屏幕上不断拖动调用此方法
- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView {
    self.hidden = NO;
    
    if (type == FOOT) {
        //        UITableView * lpTableView = (UITableView *)[self superview];
        if (scrollView.contentSize.height > scrollView.frame.size.height) {
            self.frame = CGRectMake(0.0f, scrollView.contentSize.height, 320, 650);
        } else {
            self.frame = CGRectZero;
            return;
        }
    }
    
    
    self.alpha = 1.0;
    if (miStates == EGOOPullRefreshLoading) {
        if (type == FOOT) {
            //            CGFloat offset = MAX(scrollView.contentOffset.y, 0);
            //            offset = MIN(offset, 65);
            CGFloat offset = RefreshViewHight;
            scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0f, offset, 0.0f);
        } else {
            //            CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
            //            offset = MIN(offset, 65);
            CGFloat offset = RefreshViewHight;
            scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
        }
	} else if (scrollView.isDragging) {
		if (type == FOOT) {
            if (miStates == EGOOPullRefreshPulling
                && scrollView.contentOffset.y + (scrollView.frame.size.height) < scrollView.contentSize.height + RefreshViewHight
                && scrollView.contentOffset.y > 0.0f
                && !_reloading){
                
                [self setViewState:EGOOPullRefreshNormal];
                
            } else if (miStates == EGOOPullRefreshNormal
                       && scrollView.contentOffset.y + (scrollView.frame.size.height) > scrollView.contentSize.height + RefreshViewHight
                       && !_reloading) {
                
                [self setViewState:EGOOPullRefreshPulling];
                
            }
        }
        
        if (type == HEAD) {
            if (miStates == EGOOPullRefreshPulling
                && scrollView.contentOffset.y * -1 <  RefreshViewHight
                && scrollView.contentOffset.y * -1 > 0.0f
                && !_reloading){
                
                [self setViewState:EGOOPullRefreshNormal];
                
            } else if (miStates == EGOOPullRefreshNormal
                       && scrollView.contentOffset.y * -1 >  RefreshViewHight
                       && !_reloading) {
                
                [self setViewState:EGOOPullRefreshPulling];
            }
        }
        
        if (scrollView.contentInset.bottom != 0 || scrollView.contentInset.top != 0) {
            scrollView.contentInset = UIEdgeInsetsZero;
        }
    }
}

//当用户停止拖动，并且手指从屏幕中拿开的的时候调用此方法
- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView {
	
    if (type == FOOT) {
        UITableView * lpTableView = (UITableView *)[self superview];
        if (lpTableView.contentSize.height > lpTableView.frame.size.height) {
            self.frame = CGRectMake(0.0f, lpTableView.contentSize.height, 320, 650);
        } else {
            self.frame = CGRectZero;
            return;
        }
    }
    
    if (type == FOOT) {
        if (scrollView.contentOffset.y + (scrollView.frame.size.height) > scrollView.contentSize.height + RefreshViewHight && !_reloading) {
            
            [self setViewState:EGOOPullRefreshLoading];
            [UIView animateWithDuration:FLIP_ANIMATION_DURATION animations:^(void){
                scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, RefreshViewHight, 0.0f);
            }];
            
            if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDidTriggerRefresh:loadType:)]) {
                [_delegate egoRefreshTableHeaderDidTriggerRefresh:self loadType:type];
            }
        }
    } else {
        if (scrollView.contentOffset.y * -1.0 > RefreshViewHight && !_reloading && miStates != EGOOPullRefreshNormal) {
            [UIView animateWithDuration:FLIP_ANIMATION_DURATION animations:^(void){
                scrollView.contentInset = UIEdgeInsetsMake(RefreshViewHight, 0.0f, 0.0f, 0.0f);
            }];
            [self setViewState:EGOOPullRefreshLoading];
            if ([_delegate respondsToSelector:@selector(egoRefreshTableHeaderDidTriggerRefresh:loadType:)]) {
                [_delegate egoRefreshTableHeaderDidTriggerRefresh:self loadType:type];
            }
        }
    }
}
-(void)tableViewBackToInitPosition:(UIScrollView *)scrollView
{
    
    
}

//当开发者页面页面刷新完毕调用此方法，[delegate egoRefreshScrollViewDataSourceDidFinishedLoading: scrollView];
- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
    if (!_reloading) {
        return;
    } else {
        _reloading = NO;
    }
    
    [self setViewState:EGOOPullRefreshNormal];
    [UIView animateWithDuration:FLIP_ANIMATION_DURATION animations:^{
        [scrollView setContentInset:UIEdgeInsetsMake(0.0, 0.0f, 0.0f, 0.0f)];
    }];
    
    //    self.hidden = YES;
    [self refreshLastUpdatedDate];
}


#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
	
	_delegate=nil;
	_activityView = nil;
	_statusLabel = nil;
	_arrowImage = nil;
	_lastUpdatedLabel = nil;
    [super dealloc];
}


@end
