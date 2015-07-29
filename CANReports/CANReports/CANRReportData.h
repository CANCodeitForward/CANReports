//
//  CANRReportData.h
//  CANReports
//
//  Created by Abegael Jackson on 2015-07-28.
//  Copyright (c) 2015 Canucks Autism Network. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CANRReportData : NSObject

@property (strong, nonatomic) NSString *label;
@property (strong, nonatomic) NSString *data;

-(instancetype)initWithLabel:(NSString*)label andData:(NSString*)data;

@end
