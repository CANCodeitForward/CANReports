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
    
    providerRow = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomRowFloatLabeledTextFieldTag rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"Provider Name"];
    providerRow.value = @"Canucks Autism Network";
    [providerSection addFormRow:providerRow];
    
    providerRow = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomRowFloatLabeledTextFieldTag rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"Provider Phone Number"];
    providerRow.value = @"604-685-4049";
    [providerSection addFormRow:providerRow];
    
    providerRow = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomRowFloatLabeledTextFieldTag rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"Provider Address"];
    providerRow.value = @"101-202 Yukon Street";
    [providerSection addFormRow:providerRow];
    
    providerRow = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomRowFloatLabeledTextFieldTag rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"Provider City, Province"];
    providerRow.value = @"Vancouver, BC";
    [providerSection addFormRow:providerRow];
    
    providerRow = [XLFormRowDescriptor formRowDescriptorWithTag:kCustomRowFloatLabeledTextFieldTag rowType:XLFormRowDescriptorTypeFloatLabeledTextField title:@"Provider Postal Code"];
    providerRow.value = @"V5Y 3N8";
    [providerSection addFormRow:providerRow];
    


    
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