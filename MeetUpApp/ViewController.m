//
//  ViewController.m
//  MeetUpApp
//
//  Created by Shannon Beck on 1/19/15.
//  Copyright (c) 2015 Shannon Beck. All rights reserved.
//

#import "ViewController.h"
#import "Events.h"
#import "DetailViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
@property NSDictionary *meetUpDict;
@property NSMutableArray *meetUpArray;
@property (strong, nonatomic) IBOutlet UITableView *meetUpTableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property NSString *searchURL;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.meetUpArray = [[NSMutableArray alloc]init];
    NSURL *url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=477d1928246a4e162252547b766d3c6d"];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^
     (NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         // block - will run when finish connection
         self.meetUpDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
         [self.meetUpTableView reloadData];

         NSArray *myArray = self.meetUpDict[@"results"];
         NSLog(@"HEY\n");
         for (NSDictionary *dict in myArray)
         {
             [self unpackDictionary:dict];

         }

          [self.meetUpTableView reloadData];
         // end block

     }];
}




-(void)unpackDictionary:(NSDictionary *)dict
{
    Events *event = [Events new];

    NSDictionary *diction = dict[@"venue"];
    NSString *stringy = diction[@"address_1"];
    event.address = stringy;
    event.eventName = dict[@"name"];
    event.eventDescription = dict[@"description"];
    event.rsvpCounts = dict[@"yes_rsvp_count"];
    event.eventURL = dict[@"event_url"];
    diction = dict[@"group"];
    event.hostingGroup = diction[@"name"];

    
    [self.meetUpArray addObject:event];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.meetUpArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    Events *evnts = [self.meetUpArray objectAtIndex:indexPath.row];

    cell.textLabel.text = evnts.eventName;
    cell.detailTextLabel.text = evnts.address;
    cell.imageView.image = [UIImage imageNamed:@"meetup-icon2.png"];
    cell.detailTextLabel.numberOfLines = 2;
    
    return cell;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.meetUpArray removeAllObjects];

    self.searchURL = [NSString stringWithFormat:@"https://api.meetup.com/2/open_events.json?zip=60604&text=%@&time=,1w&key=477d1928246a4e162252547b766d3c6d", searchBar.text];

    NSURL *url = [NSURL URLWithString:self.searchURL];

    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^
     (NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         // block - will run when finish connection
         self.meetUpDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
         [self.meetUpTableView reloadData];

         NSArray *myArray = self.meetUpDict[@"results"];
         NSLog(@"HEY\n");
         for (NSDictionary *dict in myArray)
         {
             [self unpackDictionary:dict];

         }

         [self.meetUpTableView reloadData];
         // end block
         
     }];

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"SegueToDetail"])
    {
        DetailViewController *dvc = segue.destinationViewController;

        NSIndexPath *path = [self.meetUpTableView indexPathForCell:sender];
        Events *thisEvent = [self.meetUpArray objectAtIndex:path.row];
        dvc.evt = thisEvent;
    }
}

@end
