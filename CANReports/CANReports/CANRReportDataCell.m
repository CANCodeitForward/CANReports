//
//  CANRReportDataCell.m
//  CANReports
//
//  Created by Abegael Jackson on 2015-07-28.
//  Copyright (c) 2015 Canucks Autism Network. All rights reserved.
//

#import "CANRReportDataCell.h"

@interface CANRReportDataCell ()

@property (weak, nonatomic) IBOutlet UILabel *rowNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rowDataLabel;

@end


@implementation CANRReportDataCell


-(void)configureWithReportData:(CANRReportData *)data{
    self.rowNameLabel.text = data.label;
    if (data.data) {
        self.rowDataLabel.text = data.data;
    }
    else{
        self.rowDataLabel.text = @" ";
    }
}

@end
