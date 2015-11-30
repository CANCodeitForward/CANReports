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
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.reportDictionary.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *sectionKey = self.reportDictionary.allKeys[section];
    NSArray *sectionArray = self.reportDictionary[sectionKey];
    return sectionArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CANRReportDataCell *cell = (CANRReportDataCell*)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *sectionKey = self.reportDictionary.allKeys[indexPath.section];
    NSArray *sectionArray = [NSArray arrayWithArray:[self.reportDictionary objectForKey:sectionKey]];
    CANRReportData *rowData = sectionArray[indexPath.row];
    
    [cell configureWithReportData:rowData];
    
    return cell;
}

#pragma mark - Table view delegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *sectionKey = self.reportDictionary.allKeys[section];
    return sectionKey;
}


@end
