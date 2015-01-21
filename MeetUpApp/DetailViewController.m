//
//  DetailViewController.m
//  MeetUpApp
//
//  Created by Shannon Beck on 1/19/15.
//  Copyright (c) 2015 Shannon Beck. All rights reserved.
//

#import "DetailViewController.h"
#import "WebViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *rsvpLabel;
@property (strong, nonatomic) IBOutlet UILabel *hostGroupLabel;
@property (strong, nonatomic) IBOutlet UITextView *eventDescriptionTextView;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.eventNameLabel.text = self.evt.eventName;
    self.eventDescriptionTextView.text = self.evt.eventDescription;
    self.rsvpLabel.text = [NSString stringWithFormat:@"RSVP Count: %@", self.evt.rsvpCounts];
    self.hostGroupLabel.text = self.evt.hostingGroup;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"segueToWebView"])
    {
        WebViewController *wvc = segue.destinationViewController;

        wvc.eventForWeb = self.evt;
    }
}


@end
