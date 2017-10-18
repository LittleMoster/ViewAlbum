//
//  NSString+Extension.h
//  Artisan
//
//  Created by cguo on 2017/7/14.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

+ (BOOL)isEmpty:(NSString *)value;

- (BOOL)isPhoneNumber;
@end
