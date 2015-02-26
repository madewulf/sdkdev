//
//  ViewController.m
//  sdk.dev
//
//  Created by Martin De Wulf on 21/02/15.
//  Copyright (c) 2015 Instaply. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIWebView * webview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.webview = [[UIWebView alloc] init];
    self.webview.frame = self.view.frame;
    [self.view addSubview:self.webview];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://vinchat.herokuapp.com"] cachePolicy: NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [self.webview loadRequest: request];
    self.webview.scrollView.bounces = NO;

}

-( void) viewDidAppear:(BOOL)animated
{
    [self registerForKeyboardNotifications];
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

   /* UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.webview.scrollView.contentInset = contentInsets;
    self.webview.scrollView.scrollIndicatorInsets = contentInsets;*/
    CGSize screenSize = [UIScreen mainScreen].applicationFrame.size;
    self.webview.frame = CGRectMake(0,0,screenSize.width,screenSize.height - kbSize.height);

}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    self.webview.frame = self.view.frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
