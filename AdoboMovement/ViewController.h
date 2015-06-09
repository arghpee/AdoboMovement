//
//  ViewController.h
//  AdoboMovement
//
//  Created by Rizza on 6/5/15.
//  Copyright (c) 2015 Rizza Corella Punsalan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PJRSignatureView.h"
#import "MyHTTPClient.h"

@interface ViewController : UIViewController <MyHTTPClientDelegate> {
    PJRSignatureView *signatureView;
}

- (IBAction)clrBtnPressed:(id)sender;
- (IBAction)pledgeBtnPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;
@property (weak, nonatomic) NSData *imageData;
@property (strong, nonatomic) NSString *errors;

@end

