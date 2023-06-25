//
//  NextMetroStationViewController.m
//  NextMetroSTL
//
//  Created by Mike Menne on 8/9/15.
//  Copyright (c) 2015 com.menne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NextMetroStationStore.h"
#import "NextMetroStationViewController.h"
#import "NextMetroStationCell.h"
#import "NextMetroStation.h"

@interface NextMetroStationViewController()<UITableViewDataSource, UITableViewDelegate> {

}

@property(nonatomic, strong) UITableView *tableView;
@end

@implementation NextMetroStationViewController

@synthesize stationNames;

-(id) initWithStationList:(NSMutableArray *)stationNames
{
    NSLog(@"We have stations");
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.stationNames = [[NSMutableArray alloc] init];
    [self.stationNames addObjectsFromArray:[NextMetroStationStore defaultStore].stationOptions];
    [self.tableView registerClass:[NextMetroStationCell class] forCellReuseIdentifier:@"NextMetroStationCell"];
    [self.view addSubview:self.tableView];
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return stationNames.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NextMetroStationCell"];
    if (cell == nil) {
        cell = [[NextMetroStationCell alloc] initWithStation:[stationNames objectAtIndex:[indexPath row]]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Caught the selection");
    //[tableView deselectRowAtIndexPath:indexPath animated:NO];
    //BATTrailsViewController *trailsController = [[BATTrailsViewController alloc] initWithStyle:UITableViewStylePlain];
    //trailsController.selectedRegion = [regions objectAtIndex:indexPath.row];
    //[[self navigationController] pushViewController:trailsController animated:YES];
}

@end