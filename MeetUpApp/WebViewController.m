//
//  WebViewController.m
//  MeetUpApp
//
//  Created by Shannon Beck on 1/19/15.
//  Copyright (c) 2015 Shannon Beck. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *forwardButton;

@end

@implementation WebViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *addressString = self.eventForWeb.eventURL;
    NSURL *addressURL = [NSURL URLWithString:addressString];
    NSURLRequest *addressRequest = [NSURLRequest requestWithURL:addressURL];
    [self.webView loadRequest:addressRequest];

}

- (IBAction)closeButton:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)onBackButtonTapped:(id)sender
{
    [self.webView goBack];

}

- (IBAction)onForwardButtonTapped:(id)sender
{
    [self.webView goForward];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.spinner startAnimating];
    self.spinner.hidden = false;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.spinner stopAnimating];
    self.spinner.hidden = true;
    if ([self.webView canGoBack] == true)
    {
        self.backButton.enabled = YES;
    }
    else
    {
        self.backButton.enabled = NO;
    }


    if ([self.webView canGoForward] == true)
    {
        self.forwardButton.enabled = YES;
    }
    else
    {
        self.forwardButton.enabled = NO;
    }

    
}



@end
