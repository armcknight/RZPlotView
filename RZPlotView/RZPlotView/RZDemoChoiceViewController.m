//
//  RZDemoChoiceViewController.m
//  RZPlotView
//
//  Created by Andrew McKnight on 12/13/13.
//  Copyright (c) 2013 raizlabs. All rights reserved.
//

#import "RZDemoChoiceViewController.h"
#import "RZSolidStreamingPlotDemo.h"
#import "RZScatterPlotDemo.h"
#import "RZPulsePlotDemo.h"

@interface RZDemoChoiceViewController () <RZCollectionListTableViewDataSourceDelegate, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) RZArrayCollectionList *demoChoiceACL;
@property (strong, nonatomic) RZCollectionListTableViewDataSource *tableViewDataSource;

@end

@implementation RZDemoChoiceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.demoChoiceACL = [[RZArrayCollectionList alloc] initWithSectionTitlesAndSectionArrays:
                          @"Streaming Plots", @[
                                                NSStringFromClass([RZSolidStreamingPlotDemo class]),
                                                NSStringFromClass([RZPulsePlotDemo class])
                                                ],
                          @"Static Plots", @[
                                             NSStringFromClass([RZScatterPlotDemo class])
                                             ],
                          nil];
    
    self.tableViewDataSource = [[RZCollectionListTableViewDataSource alloc] initWithTableView:self.tableView
                                                                               collectionList:self.demoChoiceACL
                                                                                     delegate:self];
}

#pragma mark - RZCollectionListTableViewDataSourceDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForObject:(id)object atIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = object;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id object = [self.demoChoiceACL objectAtIndexPath:indexPath];
    
    UIViewController *vcToPush = nil;
    if ([object isKindOfClass:[NSString class]]) {
        if ([object isEqualToString:NSStringFromClass([RZSolidStreamingPlotDemo class])]) {
            vcToPush = [[RZSolidStreamingPlotDemo alloc] init];
        } else if ([object isEqualToString:NSStringFromClass([RZPulsePlotDemo class])]) {
            vcToPush = [[RZPulsePlotDemo alloc] init];
        } else if ([object isEqualToString:NSStringFromClass([RZScatterPlotDemo class])]) {
            vcToPush = [[RZScatterPlotDemo alloc] init];
        }
    }
    
    [self.navigationController pushViewController:vcToPush animated:YES];
}

@end
