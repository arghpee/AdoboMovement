//
//  Validator.h
//  AdoboMovement
//
//  Created by Rizza on 6/8/15.
//  Copyright (c) 2015 Rizza Corella Punsalan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validator : NSObject

+ (BOOL)isFieldNotEmpty:(NSString *)str;
+ (BOOL)isThisAValidAge:(NSString *)str;
+ (BOOL)isThisAValidPhoneNum:(NSString *)str;
+ (BOOL)isThisAValidEmail:(NSString *)str;
+ (BOOL)isThisAValidName:(NSString *)str;

@end
