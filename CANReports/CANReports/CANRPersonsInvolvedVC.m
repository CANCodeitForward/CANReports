//
//  CANRPersonsInvolvedVC.m
//  CANReports
//
//  Created by Abegael Jackson on 2015-07-26.
//  Copyright (c) 2015 Canucks Autism Network. All rights reserved.
//

#import "CANRPersonsInvolvedVC.h"
#import "XLForm.h"
#import "CANRPersonInvolved.h"

@interface CANRPersonsInvolvedVC ()

@end

@implementation CANRPersonsInvolvedVC

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
    XLFormDescriptor *personsForm = [XLFormDescriptor formDescriptorWithTitle:@"Person(s) Involved"];
    
    //    backgroundForm.assignFirstResponderOnShow = YES;
    
    // Person(s) Involved
    XLFormSectionDescriptor *personsSection;
    XLFormRowDescriptor *personRow;
    
    personsSection = [XLFormSectionDescriptor formSectionWithTitle:@"Person"];
    [personsForm addFormSection:personsSection];
    
    
    personRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"personInvolved" rowType:XLFormRowDescriptorTypeText];
    [personRow.cellConfigAtConfigure setObject:@"Name of Person" forKey:@"textField.placeholder"];
    personRow.required = YES;
    [personsSection addFormRow:personRow];
    
    
    personRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"personBirthdate" rowType:XLFormRowDescriptorTypeDateInline title:@"Birthdate"];
    personRow.value = [NSDate new];
    [personsSection addFormRow:personRow];
    
    
    personRow = [XLFormRowDescriptor formRowDescriptorWithTag:@"personGender" rowType:XLFormRowDescriptorTypeSelectorActionSheet title:@"Gender"];
    personRow.selectorOptions = @[[XLFormOptionsObject formOptionsObjectWithValue:@(0) displayText:@"Male"],
                            [XLFormOptionsObject formOptionsObjectWithValue:@(1) displayText:@"Female"],
                            ];
    personRow.value = [XLFormOptionsObject formOptionsObjectWithValue:@(2) displayText:@""];
    [personsSection addFormRow:personRow];
    
    
    
    self.form = personsForm;
    
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.data = [[CANRPersonInvolved alloc]init];
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