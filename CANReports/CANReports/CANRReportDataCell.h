//
//  CANRReportDataCell.h
//  CANReports
//
//  Created by Abegael Jackson on 2015-07-28.
//  Copyright (c) 2015 Canucks Autism Network. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CANRReportData.h"


@interface CANRReportDataCell : UITableViewCell

-(void)configureWithReportData:(CANRReportData *)data;

@end
