//
//  CANRReportData.m
//  CANReports
//
//  Created by Abegael Jackson on 2015-07-28.
//  Copyright (c) 2015 Canucks Autism Network. All rights reserved.
//

#import "CANRReportData.h"

@implementation CANRReportData

-(instancetype)initWithLabel:(NSString*)label andData:(NSString*)data{
    self = [super init];
    if (self) {
        _label = label;
        _data = data;
    }
    return self;
}

@end
