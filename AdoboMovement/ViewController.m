//
//  ViewController.m
//  AdoboMovement
//
//  Created by Rizza on 6/5/15.
//  Copyright (c) 2015 Rizza Corella Punsalan. All rights reserved.
//

#import "ViewController.h"
#import "Validator.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize nameTextField;
@synthesize ageTextField;
@synthesize emailTextField;
@synthesize numberTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    // Do any additional setup after loading the view, typically from a nib.
    signatureView= [[PJRSignatureView alloc] initWithFrame:CGRectMake(7, 457, 487, 225)];
    //signatureView= [[PJRSignatureView alloc] initWithFrame:CGRectMake(7, 482, 487, 200)];
    [signatureView setBackgroundColor:[UIColor clearColor]];
    [signatureView setOpaque:NO];
    [self.view addSubview:signatureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pledgeBtnPressed:(id)sender {
    UIImage *signature = [signatureView getSignatureImage]; // Get signature image
    self.imageData = UIImageJPEGRepresentation(signature, 0.5);
    NSLog(@"Pledge button pressed");
    if ([self areAllInputsValid]) {
        [self startPostingToAPI];
        NSLog(@"Start Posting to API");
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid Input."
                                                            message:self.errors
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (IBAction)clrBtnPressed:(id)sender {
    [nameTextField setText:@""];
    [ageTextField setText:@""];
    [emailTextField setText:@""];
    [numberTextField setText:@""];
    [signatureView clearSignature];
}

- (void)myHTTPClient:(MyHTTPClient *)client didPostToAPI:(id)response
{
    NSLog(@"%@", response);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success!"
                                                        message:@"The response was successfully posted."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (void)myHTTPClient:(MyHTTPClient *)client didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Posting to API"
                                                        message:[NSString stringWithFormat:@"%@",error]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (BOOL) areAllInputsValid {
    self.errors = @"";
    
    if (![Validator isFieldNotEmpty:nameTextField.text]) {
        NSLog(@"Some fields are empty.");
        self.errors = [self.errors stringByAppendingString:@"The name field must not be empty.\n"];
    }
    else if (![Validator isThisAValidName:nameTextField.text]) {
        self.errors = [self.errors stringByAppendingString:@"The name must contain only letters and spaces.\n"];
    }
    
    if (![Validator isFieldNotEmpty:ageTextField.text]) {
        self.errors = [self.errors stringByAppendingString:@"The age field must not be empty.\n"];
    }
    else if (![Validator isThisAValidAge:ageTextField.text]) {
        self.errors = [self.errors stringByAppendingString:@"The age must be a number.\n"];
    }
    
    if (![Validator isFieldNotEmpty:emailTextField.text]) {
        self.errors = [self.errors stringByAppendingString:@"The email field must not be empty.\n"];
    }
    else if (![Validator isThisAValidEmail:emailTextField.text]) {
        self.errors = [self.errors stringByAppendingString:@"The email must follow the valid email format.\n"];
    }
    
    if (![Validator isFieldNotEmpty:numberTextField.text]) {
        self.errors = [self.errors stringByAppendingString:@"The contact number field must not be empty.\n"];
    }
    else if (![Validator isThisAValidPhoneNum:numberTextField.text]) {
        self.errors = [self.errors stringByAppendingString:@"The contact number must be purely numerical and must be composed of 11 digits.\n"];
    }
    
    if (self.imageData.length == 0) {
        self.errors = [self.errors stringByAppendingString:@"The signature field must not be empty.\n"];
    }
    
    if ([self.errors isEqual:@""]) {
        return YES;
    }
    else {
        NSLog(@"Some errors were found.");
        return NO;
    }
}

- (void) startPostingToAPI {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary]; // make NSMutableDictionary with required parameters
    parameters[@"name"] = nameTextField.text;
    parameters[@"age"] = ageTextField.text;
    parameters[@"email"] = emailTextField.text;
    parameters[@"contact_number"] = numberTextField.text;
    parameters[@"format"] = @"json";
    MyHTTPClient *client = [MyHTTPClient mySharedHTTPClient]; // instantiate an object of class MyHTTPClient
    client.delegate = self;
    [client postToAPIWithParams:parameters andWithImageData:self.imageData]; // call instance method to POST
}

@end
