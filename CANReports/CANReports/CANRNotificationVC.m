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

@property (strong, nonatomic) NSMutableDictionary *reportDictionary;

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
    
//    notificationForm.assignFirstResponderOnShow = YES;
    
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


-(void)makeReportDictionary{
    
    NSDictionary *notificationDictionary = [self makeNotificationDictionary];
    [self.dataDictionary setObject:notificationDictionary forKey:@"notificationGiven"];
    
    self.reportDictionary = [NSMutableDictionary dictionary];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterShortStyle;
    
    [self.dataDictionary enumerateKeysAndObjectsUsingBlock:^(NSString *outerKey, NSDictionary *dict, BOOL *stop) {
        
        NSMutableArray *reportArray = [NSMutableArray array];
        
        [dict enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
            
            if (!([obj isKindOfClass:[NSNull class]] || ([obj isKindOfClass:[NSString class]] && [[obj stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]))) {

                if ([obj isKindOfClass:[XLFormOptionsObject class]]) {
                    obj = [((XLFormOptionsObject *)obj) formValue];
                }
                if ([obj isKindOfClass:[NSNumber class]]) {
                    obj = ([((NSNumber *)obj) boolValue] ? @"Yes" : @"No");
                }
                if ([obj isKindOfClass:[NSDate class]]) {
                    obj = [formatter stringFromDate:obj];
                }
                if ([obj isKindOfClass:[NSArray class]]){
                    obj = [obj componentsJoinedByString:@", "];
                }
                
                key = [self makeCapitalized:key];

                
                NSLog(@"%@ --> %@: '%@'", [obj class], key, obj);
                
                NSString *rowLabel = key;
                NSString *rowValue = obj;
                CANRReportData *rowData;
                rowData = [[CANRReportData alloc] initWithLabel:rowLabel andData:rowValue];
                [reportArray addObject:rowData];
                
            }
            
        }];
        
        outerKey = [self makeCapitalized:outerKey];
        
        [self.reportDictionary setValue:reportArray forKey:outerKey];
        
    }];
    
}

-(NSString*)makeCapitalized:(NSString*)string{
    NSMutableString *newString = [NSMutableString string];
    
    for (NSInteger i=0; i<string.length; i++){
        NSString *character = [string substringWithRange:NSMakeRange(i, 1)];
        if ([character rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]].location != NSNotFound) {
            [newString appendString:@" "];
        }
        [newString appendString:character];
    }
    
    return [newString capitalizedString];
}

-(NSMutableDictionary*)makeNotificationDictionary{
    NSMutableDictionary *notification = [NSMutableDictionary dictionaryWithDictionary:[self formValues]];
    return notification;
}

- (IBAction)didTapSaveButton:(id)sender{
    [self makeReportDictionary];
    [self performSegueWithIdentifier:@"showReportReview" sender:self];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"showReportReview"]) {

        [[segue destinationViewController] setReportDictionary:self.reportDictionary];
    }
}


@end








