//
//  CANRIncidentDetailsVC.m
//  CANReports
//
//  Created by Abegael Jackson on 2015-07-26.
//  Copyright (c) 2015 Canucks Autism Network. All rights reserved.
//

#import "CANRIncidentDetailsVC.h"
#import "XLForm.h"

#pragma mark - NSValueTransformer

@interface NSArrayValueTrasformer : NSValueTransformer
@end

@implementation NSArrayValueTrasformer

+ (Class)transformedValueClass
{
    return [NSString class];
}

+ (BOOL)allowsReverseTransformation
{
    return NO;
}

- (id)transformedValue:(id)value
{
    if (!value) return nil;
    if ([value isKindOfClass:[NSArray class]]){
        NSArray * array = (NSArray *)value;
        return [NSString stringWithFormat:@"%@ Item%@", @(array.count), array.count > 1 ? @"s" : @""];
    }
    return nil;
}

@end

@interface CANRIncidentDetailsVC ()

@end

@implementation CANRIncidentDetailsVC

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
    XLFormDescriptor *detailsOfIncidentForm = [XLFormDescriptor formDescriptorWithTitle:@"Incident Details"];
    
    //    backgroundForm.assignFirstResponderOnShow = YES;
    
    // Type of Incident
    XLFormSectionDescriptor *typeOfIncidentSection;
    XLFormRowDescriptor *typeOfIncidentRow;
    
    typeOfIncidentSection = [XLFormSectionDescriptor formSectionWithTitle:@"Type of Incident"];
    [detailsOfIncidentForm addFormSection:typeOfIncidentSection];
    
    typeOfIncidentRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"typeOfIncident" rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Type of Incident"];
    typeOfIncidentRow.selectorOptions = @[@"Physical Abuse", @"Sexual Abuse", @"Emotional Abuse", @"Neglect", @"Financial Abuse", @"Unexpected Illness", @"Disease Outbreak", @"Death", @"Fall", @"Motor Vehicle Injury", @"Other Injury", @"Poisoning", @"Agressive/Unusual Behaviour", @"Missing Person", @"Medication Error"];
    typeOfIncidentRow.valueTransformer = [NSArrayValueTrasformer class];
    [typeOfIncidentSection addFormRow:typeOfIncidentRow];
    
    
    
    // Details
    XLFormSectionDescriptor *detailsOfIncidentSection;
    XLFormRowDescriptor *detailsOfIncidentRow;
    
    detailsOfIncidentSection = [XLFormSectionDescriptor formSectionWithTitle:@"Details"];
    [detailsOfIncidentForm addFormSection:detailsOfIncidentSection];
    
    detailsOfIncidentRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"incidentDate" rowType:XLFormRowDescriptorTypeDateInline title:@"Date"];
    detailsOfIncidentRow.value = [NSDate new];
    [detailsOfIncidentSection addFormRow:detailsOfIncidentRow];
    
    detailsOfIncidentRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"incidentTime" rowType:XLFormRowDescriptorTypeTimeInline title:@"Time"];
    detailsOfIncidentRow.value = [NSDate new];
    [detailsOfIncidentSection addFormRow:detailsOfIncidentRow];
    
    
    detailsOfIncidentRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"incidentDescription" rowType:XLFormRowDescriptorTypeTextView];
    [detailsOfIncidentRow.cellConfigAtConfigure setObject:@"Description of Incident" forKey:@"textView.placeholder"];
    [detailsOfIncidentSection addFormRow:detailsOfIncidentRow];
    
    
    
    // Action Taken
    XLFormSectionDescriptor *actionTakenSection;
    XLFormRowDescriptor *actionTakenRow;
    
    actionTakenSection = [XLFormSectionDescriptor formSectionWithTitle:@"Action Taken"];
    [detailsOfIncidentForm addFormSection:actionTakenSection];
    
    
    actionTakenRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"firstAidGiven" rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"First Aid Given"];
    actionTakenRow.value = @0;
    [actionTakenSection addFormRow:actionTakenRow];
    
    actionTakenRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"firstAidGivenBy" rowType:XLFormRowDescriptorTypeText];
    actionTakenRow.hidden = [NSString stringWithFormat:@"$%@==0", @"firstAidGiven"];
    [actionTakenRow.cellConfigAtConfigure setObject:@"First Aid Given By" forKey:@"textField.placeholder"];
    [actionTakenSection addFormRow:actionTakenRow];

    
    actionTakenRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"clinicVisited" rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"Visited Clinic"];
    actionTakenRow.value = @0;
    [actionTakenSection addFormRow:actionTakenRow];
    
    actionTakenRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"clinicDoctorName" rowType:XLFormRowDescriptorTypeText];
    actionTakenRow.hidden = [NSString stringWithFormat:@"$%@==0", @"visitedClinic"];
    [actionTakenRow.cellConfigAtConfigure setObject:@"Clinic Doctor Name" forKey:@"textField.placeholder"];
    [actionTakenSection addFormRow:actionTakenRow];
    
    
    actionTakenRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"hospitalVisited" rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"Visited Hospital"];
    actionTakenRow.value = @0;
    [actionTakenSection addFormRow:actionTakenRow];
    
    actionTakenRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"hospitalDoctorName" rowType:XLFormRowDescriptorTypeText];
    actionTakenRow.hidden = [NSString stringWithFormat:@"$%@==0", @"visitedHospital"];
    [actionTakenRow.cellConfigAtConfigure setObject:@"Hospital Doctor Name" forKey:@"textField.placeholder"];
    [actionTakenSection addFormRow:actionTakenRow];
    
    
    self.form = detailsOfIncidentForm;
    
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(savePressed:)];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([[segue identifier] isEqualToString:@"showNotification"]) {
        NSDictionary *typeOfIncidentDictionary = [self makeTypeOfIncidentDictionary];
        NSDictionary *incidentDetailsDictionary = [self makeIncidentDetailsDictionary];
        NSDictionary *actionTakenDictionary = [self makeActionTakenDictionary];
        
        [self.dataDictionary setObject:typeOfIncidentDictionary forKey:@"typeOfIncident"];
        [self.dataDictionary setObject:incidentDetailsDictionary forKey:@"incidentDetails"];
        [self.dataDictionary setObject:actionTakenDictionary forKey:@"actionTaken"];
        
        [[segue destinationViewController] setDataDictionary:self.dataDictionary];
        
    }
}


-(NSMutableDictionary*)makeTypeOfIncidentDictionary{
    NSMutableDictionary *typeOfIncident = [NSMutableDictionary dictionaryWithDictionary:[self formValues]];
    [typeOfIncident removeObjectsForKeys:@[@"clinicDoctorName", @"clinicVisited", @"firstAidGiven", @"firstAidGivenBy", @"hospitalDoctorName", @"hospitalVisited", @"incidentDate", @"incidentDescription", @"incidentTime"]];
    return typeOfIncident;
}

-(NSMutableDictionary*)makeIncidentDetailsDictionary{
    NSMutableDictionary *incidentDetails = [NSMutableDictionary dictionaryWithDictionary:[self formValues]];
    [incidentDetails removeObjectsForKeys:@[@"typeOfIncident", @"clinicDoctorName", @"clinicVisited", @"firstAidGiven", @"firstAidGivenBy", @"hospitalDoctorName", @"hospitalVisited"]];
    return incidentDetails;
}
// fix date and time 
-(NSMutableDictionary*)makeActionTakenDictionary{
    NSMutableDictionary *actionTaken = [NSMutableDictionary dictionaryWithDictionary:[self formValues]];
    [actionTaken removeObjectsForKeys:@[@"typeOfIncident", @"incidentDate", @"incidentDescription", @"incidentTime"]];
    return actionTaken;
}

@end
