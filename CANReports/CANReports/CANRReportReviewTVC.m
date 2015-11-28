//
//  CANRReportReviewTVC.m
//  CANReports
//
//  Created by Abegael Jackson on 2015-07-28.
//  Copyright (c) 2015 Canucks Autism Network. All rights reserved.
//

#import "CANRReportReviewTVC.h"
#import "CANRReportDataCell.h"

@interface CANRReportReviewTVC ()

@end

@implementation CANRReportReviewTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (CANRReportData *x in self.reportArray) { NSLog(@"%@: %@", x.label, x.data); }
    

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.reportArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CANRReportDataCell *cell = (CANRReportDataCell*)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    CANRReportData *rowData = [self.reportArray objectAtIndex:indexPath.row];
    [cell configureWithReportData:rowData];
    
    return cell;
}


@end
