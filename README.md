# NJKWebViewProgress

NJKWebViewProgress was a progress interface library for UIWebView, as it doesn't had official progress interface in iOS 7. This version is updated to use WKWebView instead, to let old projects pass AppStore-Upload with UIWebView deprecation. You can implement progress bar for your in-app browser using this module.

<img src="./DemoApp/Screenshot/screenshot1.png" alt="iOS ScreenShot 1" width="240px" style="width: 240px;" />

NJKWebViewProgress doesn't use CocoaTouch's private methods. It's AppStore safe.

## Used in Production

- [Yahoo! JAPAN](https://itunes.apple.com/app/yahoo!-japan/id299147843?mt=8)
- [Facebook](https://itunes.apple.com/app/facebook/id284882215?mt=8‎)

## Requirements

- iOS 12.0 or later
- ARC

## Usage

Instance `NJKWebViewProgress` and set `WKNavigationDelegate`. If you set `webViewProxyDelegate`, `NJKWebViewProgress` should perform as a proxy object.

```objc
_progressProxy = [[NJKWebViewProgress alloc] init]; // instance variable
webView.navigationDelegate = _progressProxy;
_progressProxy.webViewProxyDelegate = self;
_progressProxy.progressDelegate = self;
```

When WKWebView start loading, `NJKWebViewProgress` call delegate method and block with progress.

```objc
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [progressView setProgress:progress animated:NO];
}
```

```objc
progressProxy.progressBlock = ^(float progress) {
    [progressView setProgress:progress animated:NO];
};
```

You can determine the current state of the document by comparing the `progress` value to one of the provided constants:

```objc
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    if (progress == NJKInteractiveProgressValue) {
        // The web view has finished parsing the document,
        // but is still loading sub-resources
    }
}
```

This repository contains iOS 7 Safari style bar `NJKWebViewProgressView`. You can choose `NJKWebViewProgressView`, `UIProgressView` or your custom bar.

## Install

### CocoaPods

```sh
pod 'NJKWebViewProgress', :git => 'https://github.com/rafaelmaeuer/NJKWebViewProgress.git'
```

## License

[Apache]: http://www.apache.org/licenses/LICENSE-2.0
[MIT]: http://www.opensource.org/licenses/mit-license.php
[GPL]: http://www.gnu.org/licenses/gpl.html
[BSD]: http://opensource.org/licenses/bsd-license.php
[MIT license][MIT].
