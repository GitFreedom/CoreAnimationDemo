//
//  WJDBaseWebViewController.m
//  SafePartner
//
//  Created by 王俊东 on 2019/2/26.
//

#import "WJDBaseWebViewController.h"
#import <WebKit/WebKit.h>
#import "WJDDevice.h"

static const NSString *wkWebViewProgressPath = @"estimatedProgress";
static const NSString *wkWebViewTitlePath = @"title";

@interface WJDBaseWebViewController ()<WKNavigationDelegate>
//视图
@property (nonatomic, strong) UIProgressView *progressView;//进度条
@property (nonatomic, strong) WKWebView *webView;//网页视图

@end

@implementation WJDBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self __loadRequest];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self __addObservers];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self __removeObservers];
}

#pragma mark - Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:(NSString *)wkWebViewProgressPath]) {//加载进度
        if (object == self.webView) {
            self.progressView.alpha = 1;
            [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
            if(self.webView.estimatedProgress >= 1.0f) {
                [UIView animateWithDuration:0.3 animations:^{
                    self.progressView.alpha = 0;
                } completion:^(BOOL finished) {
                    [self.progressView setProgress:0.0f animated:NO];
                }];
            }
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
    else if ([keyPath isEqualToString:(NSString *)wkWebViewTitlePath]) { //网页title
        if (object == self.webView) {
            self.navigationItem.title = self.webView.title;
        } else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    if (navigationAction.navigationType == WKNavigationTypeLinkActivated) {//跨域
        
        WJDBaseWebViewController *webVC = [[WJDBaseWebViewController alloc]init];
        webVC.urlString                 = navigationAction.request.URL.absoluteString;
        [self.navigationController pushViewController:webVC animated:YES];
        decisionHandler(WKNavigationActionPolicyCancel);
    } else {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    
}
#pragma mark - Getter

- (UIProgressView *)progressView {
    
    if (_progressView == nil) {
        _progressView = [[UIProgressView alloc] init];
        _progressView.progress       = 0.0f;
        _progressView.trackTintColor = [UIColor whiteColor];
    }
    return _progressView;
}

- (WKWebView *)webView {
    
    if (_webView == nil) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
        _webView = [[WKWebView alloc]initWithFrame:CGRectZero configuration:configuration];
        _webView.navigationDelegate = self;
    }
    return _webView;
}

#pragma mark - Setter

- (void)setUrlString:(NSString *)urlString {
    
    if (!_urlString) {
        _urlString = urlString;
        [self __loadRequest];
    } else {
        if (![urlString isEqualToString:urlString]) {
            _urlString = urlString;
        }
        [self __loadRequest];
    }
}

#pragma mark - OverreadMethod

- (void)setupViews {
    
    CGFloat height = WJDDevice.screenHeight;
    if (self.navigationStatus != NavigationStatus_hidden) {
        height -= (WJDDevice.statusBarHeight + 44);
    }
    if (self.tabbarStatus != TabbarStatus_hidden) {
        if (self.tabbarStatus == TabbarStatus_show) {
            height -= (WJDDevice.bottomOffset + 49);
        } else {
            if (self.navigationController.viewControllers.count <= 1) {
                height -= (WJDDevice.bottomOffset + 49);
            }
        }
    }
    self.progressView.frame = CGRectMake(0, 0, self.view.frame.size.width, 2.0f);
    [self.view addSubview:self.progressView];
    self.webView.frame = CGRectMake(0, self.progressView.frame.size.height, self.view.frame.size.width, height - self.progressView.frame.size.height);
    [self.view addSubview:self.webView];
}

#pragma mark = PrivateMethod

- (void)__loadRequest {
    
    if (_urlString == nil) {
        return;
    }
    NSURL *url;
    if ([_urlString hasPrefix:@"http"]) {
        url = [NSURL URLWithString:self.urlString];
    } else {
        if ([[NSFileManager defaultManager] fileExistsAtPath:self.urlString]) {
            url = [NSURL fileURLWithPath:self.urlString];
        }
    }
    if (url) {
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
}

- (void)__addObservers {
    
    if (self.navigationStatus != NavigationStatus_hidden && self.title == nil) {
        [self.webView addObserver:self forKeyPath:(NSString *)wkWebViewTitlePath options:NSKeyValueObservingOptionNew context:nil];
    }
    [self.webView addObserver:self forKeyPath:(NSString *)wkWebViewProgressPath options:NSKeyValueObservingOptionNew context:nil];
}

- (void)__removeObservers {
    
    if (self.navigationStatus != NavigationStatus_hidden && self.title == nil) {
        [self.webView removeObserver:self forKeyPath:(NSString *)wkWebViewTitlePath];
    }
    [self.webView removeObserver:self forKeyPath:(NSString *)wkWebViewProgressPath];
}
@end
