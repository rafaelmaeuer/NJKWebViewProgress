//
//  ViewController.m
//  WebViewDemo
//
//  Created by Satoshi Asano on 4/20/13.
//  Copyright (c) 2013 Satoshi Asano. All rights reserved.
//

#import "ViewController.h"
#import "NJKWebViewProgressView.h"

@implementation ViewController
{
    //IBOutlet __weak UIWebView *_webView;
    IBOutlet WKWebView *_webView;
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Init WKWebView with config
    WKWebViewConfiguration *_webViewConfig = [[WKWebViewConfiguration alloc] init];
    _webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:_webViewConfig];
        
    if (@available(iOS 13.0, *)) {
        _webView.opaque = NO;
        _webView.backgroundColor = [UIColor systemBackgroundColor];
        _webView.scrollView.backgroundColor = [UIColor systemBackgroundColor];
    }
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.navigationDelegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;

    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;

    [self loadGoogle];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    // Remove progress view
    // because UINavigationBar is shared with other ViewControllers
    [_progressView removeFromSuperview];
}

- (IBAction)searchButtonPushed:(id)sender
{
    [self loadGoogle];
}

- (IBAction)reloadButtonPushed:(id)sender
{
    [_webView reload];
}

-(void)loadGoogle
{
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://duckduckgo.com"]];
    [_webView loadRequest:req];
    [self.view addSubview:_webView];
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    self.title = _webView.title;
}

@end
