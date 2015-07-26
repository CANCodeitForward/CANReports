//
//  CANRBackgroundInfoVC.m
//  CANReports
//
//  Created by Abegael Jackson on 2015-07-26.
//  Copyright (c) 2015 Canucks Autism Network. All rights reserved.
//

#import "CANRBackgroundInfoVC.h"
#import "XLForm.h"
#import "FloatLabeledTextFieldCell.h"


NSString *const kName = @"name";
NSString *const kEmail = @"email";
NSString *const kTwitter = @"twitter";
NSString *const kNumber = @"number";
NSString *const kInteger = @"integer";
NSString *const kDecimal = @"decimal";
NSString *const kPassword = @"password";
NSString *const kPhone = @"phone";
NSString *const kUrl = @"url";
NSString *const kTextView = @"textView";
NSString *const kNotes = @"notes";



static NSString * const kCustomRowFirstRatingTag = @"CustomRowFirstRatingTag";
static NSString * const kCustomRowSecondRatingTag = @"CustomRowSecondRatingTag";
static NSString * const kCustomRowFloatLabeledTextFieldTag = @"CustomRowFloatLabeledTextFieldTag";
static NSString * const kCustomRowWeekdays = @"CustomRowWeekdays";
static NSString * const kCustomRowText = @"kCustomText";


@implementation CANRBackgroundInfoVC

-(id)init
{
    XLFormDescriptor *backgroundForm = [XLFormDescriptor formDescriptorWithTitle:@"Text Fields"];
    backgroundForm.assignFirstResponderOnShow = YES;
    
    
    // Provider (with pre-populated, editable data)
    XLFormSectionDescriptor *providerSection;
    XLFormRowDescriptor *providerRow;
    
    providerSection = [XLFormSectionDescriptor formSectionWithTitle:@"*Do NOT talk to the media at any time"];
    [backgroundForm addFormSection:providerSection];
    
    
    providerRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"providerName" rowType:XLFormRowDescriptorTypeText];
    [providerRow.cellConfigAtConfigure setObject:@"Canucks Autism Network" forKey:@"textField.placeholder"];
    providerRow.required = YES;
    [providerSection addFormRow:providerRow];
    
    // FIX THE FORMATTING OF ADDED PHONE NUMBER
    providerRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"providerPhone" rowType:XLFormRowDescriptorTypePhone];
    [providerRow.cellConfigAtConfigure setObject:@"604-685-4049" forKey:@"textField.placeholder"];
    providerRow.required = YES;
    [providerSection addFormRow:providerRow];
    
    providerRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"providerAddress" rowType:XLFormRowDescriptorTypeText];
    [providerRow.cellConfigAtConfigure setObject:@"101-2020 Yukon Street" forKey:@"textField.placeholder"];
    providerRow.required = YES;
    [providerSection addFormRow:providerRow];
    
    providerRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"providerCityProvince" rowType:XLFormRowDescriptorTypeText];
    [providerRow.cellConfigAtConfigure setObject:@"Vancouver, BC" forKey:@"textField.placeholder"];
    providerRow.required = YES;
    [providerSection addFormRow:providerRow];
    
    providerRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"providerPostalCode" rowType:XLFormRowDescriptorTypeText];
    [providerRow.cellConfigAtConfigure setObject:@"V5Y 3N8" forKey:@"textField.placeholder"];
    providerRow.required = YES;
    [providerSection addFormRow:providerRow];

    
    
    // Incident Location
    XLFormSectionDescriptor *locationSection;
    XLFormRowDescriptor *locationRow;
    
    locationSection = [XLFormSectionDescriptor formSectionWithTitle:@"*Do NOT talk to the media at any time"];
    [backgroundForm addFormSection:locationSection];
    
    locationRow = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomRowFloatLabeledTextFieldTag rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"Incident Location"];
    locationRow.value = @"Canucks Autism Network";
    [locationSection addFormRow:locationRow];
    
    locationRow = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomRowFloatLabeledTextFieldTag rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"Provider Phone Number"];
    locationRow.value = @"604-685-4049";
    [locationSection addFormRow:locationRow];
    
    locationRow = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomRowFloatLabeledTextFieldTag rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"Provider Address"];
    locationRow.value = @"101-202 Yukon Street";
    [locationSection addFormRow:locationRow];
    
    locationRow = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomRowFloatLabeledTextFieldTag rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"Provider City, Province"];
    locationRow.value = @"Vancouver, BC";
    [locationSection addFormRow:locationRow];
    
    locationRow = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomRowFloatLabeledTextFieldTag rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"Provider Postal Code"];
    locationRow.value = @"V5Y 3N8";
    [locationSection addFormRow:locationRow];

    
    return [super initWithForm:formDescriptor];
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(savePressed:)];
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