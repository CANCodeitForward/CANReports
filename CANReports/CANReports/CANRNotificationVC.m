//
//  CANRNotificationVC.m
//  CANReports
//
//  Created by Abegael Jackson on 2015-07-26.
//  Copyright (c) 2015 Canucks Autism Network. All rights reserved.
//

#import "CANRNotificationVC.h"
#import "XLForm.h"
#import "CANRReportData.h"

@interface CANRNotificationVC ()

@property (strong, nonatomic) NSMutableDictionary *dataDictionary;
@property (strong, nonatomic) NSMutableArray *reportArray;

@end

@implementation CANRNotificationVC

-(instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeForm];
    }
    return self;
}

-(instancetype)init
{
    self = [super init];
    if (self){
        [self initializeForm];
    }
    return self;
}

-(void)initializeForm
{
    XLFormDescriptor *notificationForm = [XLFormDescriptor formDescriptorWithTitle:@"Notification"];
    
    //    backgroundForm.assignFirstResponderOnShow = YES;
    
    // Was Family Notified
    XLFormSectionDescriptor *notificationSection;
    XLFormRowDescriptor *notificationRow;
    
    notificationSection = [XLFormSectionDescriptor formSectionWithTitle:nil];
    [notificationForm addFormSection:notificationSection];
    
    notificationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"familyNotified" rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"Family Notified"];
    [notificationSection addFormRow:notificationRow];
    notificationRow.value = @0;
    
    
    // Family Member Notified
    notificationSection = [XLFormSectionDescriptor formSectionWithTitle:@"Family Member Notified"];
    [notificationForm addFormSection:notificationSection];
    notificationSection.hidden = [NSString stringWithFormat:@"$%@==0", @"familyNotified"];
    
    notificationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"familyNotifiedAtDateTime" rowType:XLFormRowDescriptorTypeDateTimeInline title:@"When?"];
    [notificationSection addFormRow:notificationRow];
    notificationRow.value = [NSDate new];
    
    notificationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"familyMemberNotified" rowType:XLFormRowDescriptorTypeText];
    [notificationSection addFormRow:notificationRow];
    [notificationRow.cellConfigAtConfigure setObject:@"Family Member Notified" forKey:@"textField.placeholder"];
    
    notificationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"familyMemberRelationship" rowType:XLFormRowDescriptorTypeText];
    [notificationSection addFormRow:notificationRow];
    [notificationRow.cellConfigAtConfigure setObject:@"Relationship" forKey:@"textField.placeholder"];
    
    notificationRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"familyMemberPhone" rowType:XLFormRowDescriptorTypePhone];
    [notificationSection addFormRow:notificationRow];
    [notificationRow.cellConfigAtConfigure setObject:@"Phone Number" forKey:@"textField.placeholder"];
    
    
    
    // Reporter
    XLFormSectionDescriptor *reporterSection;
    XLFormRowDescriptor *reporterRow;
    
    reporterSection = [XLFormSectionDescriptor formSectionWithTitle:@"Reporter"];
    [notificationForm addFormSection:reporterSection];
    
    reporterRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"reporterName" rowType:XLFormRowDescriptorTypeText];
    [reporterSection addFormRow:reporterRow];
    [reporterRow.cellConfigAtConfigure setObject:@"Reporter" forKey:@"textField.placeholder"];
    
    reporterRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"reporterPosition" rowType:XLFormRowDescriptorTypeText];
    [reporterSection addFormRow:reporterRow];
    [reporterRow.cellConfigAtConfigure setObject:@"Position" forKey:@"textField.placeholder"];
    
    
    
    // Witness
    XLFormSectionDescriptor *witessSection;
    XLFormRowDescriptor *witnessRow;
    
    witessSection = [XLFormSectionDescriptor formSectionWithTitle:@"Witness"];
    [notificationForm addFormSection:witessSection];
    
    witnessRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"witnessName" rowType:XLFormRowDescriptorTypeText];
    [witessSection addFormRow:witnessRow];
    [witnessRow.cellConfigAtConfigure setObject:@"Witness" forKey:@"textField.placeholder"];
    
    witnessRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"witnessPosition" rowType:XLFormRowDescriptorTypeText];
    [witessSection addFormRow:witnessRow];
    [witnessRow.cellConfigAtConfigure setObject:@"Position" forKey:@"textField.placeholder"];
    
    
    
    // Reporter
    XLFormSectionDescriptor *supervisorSection;
    XLFormRowDescriptor *supervisorRow;
    
    supervisorSection = [XLFormSectionDescriptor formSectionWithTitle:@"Supervisor"];
    [notificationForm addFormSection:supervisorSection];
    
    supervisorRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"supervisorName" rowType:XLFormRowDescriptorTypeText];
    [supervisorSection addFormRow:supervisorRow];
    [supervisorRow.cellConfigAtConfigure setObject:@"Supervisor" forKey:@"textField.placeholder"];
    
    supervisorRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"supervisorPosition" rowType:XLFormRowDescriptorTypeText];
    [supervisorSection addFormRow:supervisorRow];
    [supervisorRow.cellConfigAtConfigure setObject:@"Position" forKey:@"textField.placeholder"];

    
    
    self.form = notificationForm;
    
}


-(void)viewDidLoad
{
    [super viewDidLoad];
}


-(void)makeReportArray{
    NSMutableDictionary *reportDictionary = [NSMutableDictionary dictionaryWithDictionary:[self formValues]];
    NSLog(@"%@", reportDictionary);
    self.reportArray = [[NSMutableArray alloc] init];
    [reportDictionary enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL *stop) {
        NSString *rowLabel = key;
        NSString *rowValue;
        if (obj != [NSNull null]) {
            rowValue = obj;
        }
        else {
            rowValue = @" ";
        }
        CANRReportData *rowData = [[CANRReportData alloc] initWithLabel:rowLabel andData:rowValue];
        [self.reportArray addObject:rowData];
    }];
}


- (IBAction)didTapSaveButton:(id)sender {
    [self makeReportArray];
    [self performSegueWithIdentifier:@"showReportReview" sender:self];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"showReportReview"]) {

        [[segue destinationViewController] setReportArray:self.reportArray];
    }
}


@end








