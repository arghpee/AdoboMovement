//
//  Validator.m
//  AdoboMovement
//
//  Created by Rizza on 6/8/15.
//  Copyright (c) 2015 Rizza Corella Punsalan. All rights reserved.
//

#import "Validator.h"
#define NUM_OF_PHONE_DIGITS 11

@implementation Validator

+ (BOOL)isFieldNotEmpty:(NSString *)str {
    if ([str isEqual:@""]) {
        return NO;
    }
    else {
        return YES; // valid
    }
}

+ (BOOL)isThisAValidAge:(NSString *)str {
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    if ([f numberFromString:str] == nil) {
        return NO;
    }
    else {
        return YES;
    }
}

+ (BOOL)isThisAValidEmail:(NSString *)str {
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:str];
}

+ (BOOL)isThisAValidName:(NSString *)str {
    NSCharacterSet *validChars = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "];
    validChars = [validChars invertedSet];
    NSRange  range = [str rangeOfCharacterFromSet:validChars];
    if (NSNotFound != range.location) {
        return NO;
    }
    else {
        return YES;
    }
}

+ (BOOL)isThisAValidPhoneNum:(NSString *)str {
    NSCharacterSet *validChars = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    validChars = [validChars invertedSet];
    NSRange  range = [str rangeOfCharacterFromSet:validChars];
    if (NSNotFound != range.location) {
        return NO;
    }
    else {
        if (str.length == NUM_OF_PHONE_DIGITS) { // check if length of number is
            return YES;
        }
        else {
            return NO;
        }
    }
}

@end
