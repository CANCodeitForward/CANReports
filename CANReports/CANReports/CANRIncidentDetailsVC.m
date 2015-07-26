//
//  CANRIncidentDetailsVC.m
//  CANReports
//
//  Created by Abegael Jackson on 2015-07-26.
//  Copyright (c) 2015 Canucks Autism Network. All rights reserved.
//

#import "CANRIncidentDetailsVC.h"
#import "XLForm.h"
#import "CANRIncident.h"

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
    
    typeOfIncidentRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"typeOfIncident" rowType:XLFormRowDescriptorTypeMultipleSelector title:@"Multiple Selector"];
    typeOfIncidentRow.selectorOptions = @[@"Physical Abuse", @"Sexual Abuse", @"Emotional Abuse", @"Neglect", @"Financial Abuse", @"Unexpected Illness", @"Disease Outbreak", @"Death", @"Fall", @"Motor Vehicle Injury", @"Other Injury", @"Poisoning", @"Agressive/Unusual Behaviour", @"Missing Person", @"Medication Error"];
    typeOfIncidentRow.valueTransformer = [NSArrayValueTrasformer class];
    [typeOfIncidentSection addFormRow:typeOfIncidentRow];
    
    
    
    // Details
    XLFormSectionDescriptor *detailsOfIncidentSection;
    XLFormRowDescriptor *detailsOfIncidentRow;
    
    detailsOfIncidentSection = [XLFormSectionDescriptor formSectionWithTitle:@"Details"];
    [detailsOfIncidentForm addFormSection:detailsOfIncidentSection];
    
    detailsOfIncidentRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"dateOfIncident" rowType:XLFormRowDescriptorTypeDateInline title:@"Date"];
    detailsOfIncidentRow.value = [NSDate new];
    [detailsOfIncidentSection addFormRow:detailsOfIncidentRow];
    
    detailsOfIncidentRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"timeOfIncident" rowType:XLFormRowDescriptorTypeTimeInline title:@"Time"];
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

    
    actionTakenRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"visitedClinic" rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"Visited Clinic"];
    actionTakenRow.value = @0;
    [actionTakenSection addFormRow:actionTakenRow];
    
    actionTakenRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"clinicDoctorName" rowType:XLFormRowDescriptorTypeText];
    actionTakenRow.hidden = [NSString stringWithFormat:@"$%@==0", @"visitedClinic"];
    [actionTakenRow.cellConfigAtConfigure setObject:@"Clinic Doctor Name" forKey:@"textField.placeholder"];
    [actionTakenSection addFormRow:actionTakenRow];
    
    
    actionTakenRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"visitedHospital" rowType:XLFormRowDescriptorTypeBooleanSwitch title:@"Visited Hospital"];
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
    self.data = [[CANRIncident alloc]init];
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(savePressed:)];
}


-(void)savePressed:(UIBarButtonItem * __unused)button
{
    NSArray * validationErrors = [self formValidationErrors];
    if (validationErrors.count > 0){
        [self showFormValidationError:[validationErrors firstObject]];
        return;
    }
    [self.tableView endEditing:YES];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED < 80000
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Valid Form", nil)
                                                      message:@"No errors found"
                                                     delegate:nil
                                            cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                            otherButtonTitles:nil];
    [message show];
#else
    if ([UIAlertController class]){
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Valid Form", nil)
                                                                                  message:@"No errors found"
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil)
                                                            style:UIAlertActionStyleDefault
                                                          handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else{
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Valid Form", nil)
                                                          message:@"No errors found"
                                                         delegate:nil
                                                cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                                otherButtonTitles:nil];
        [message show];
    }
#endif
}

@end
