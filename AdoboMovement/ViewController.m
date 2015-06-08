//
//  ViewController.m
//  AdoboMovement
//
//  Created by Rizza on 6/5/15.
//  Copyright (c) 2015 Rizza Corella Punsalan. All rights reserved.
//

#import "ViewController.h"

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
    [signatureView setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:signatureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pledgeBtnPressed:(id)sender {
    [self startPostingToAPI];
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
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success!"
                                                        message:@"The response was successfully posted."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (void)myHTTPClient:(MyHTTPClient *)client didFailWithError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Posting to API"
                                                        message:[NSString stringWithFormat:@"%@",error]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (void) startPostingToAPI {
    UIImage *image = [signatureView getSignatureImage]; // get UIImage of signature
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary]; // make NSMutableDictionary with required parameters
    parameters[@"name"] = nameTextField.text;
    parameters[@"age"] = ageTextField.text;
    parameters[@"email"] = emailTextField.text;
    parameters[@"contact_number"] = numberTextField.text;
    parameters[@"format"] = @"json";
    MyHTTPClient *client = [MyHTTPClient mySharedHTTPClient]; // instantiate an object of class MyHTTPClient
    client.delegate = self;
    [client postToAPIWithParams:parameters andWithImageData:imageData]; // call instance method to POST
}

@end
