//
//  ViewController.h
//  WebViewDemo
//
//  Created by Satoshi Asano on 4/20/13.
//  Copyright (c) 2013 Satoshi Asano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "NJKWebViewProgress.h"

@interface ViewController : UIViewController<WKNavigationDelegate, NJKWebViewProgressDelegate>
@end
