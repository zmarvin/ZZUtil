//
//  RsaSecretKey.h
//  恒信通
//
//  Created by zz on 15/1/3.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RsaSecretKey : NSObject

+ (NSData*)rsaEncryptString:(NSString*)string publicCertificate:(NSString *)cerName;

+ (NSData*)rsaDecryptWithData:(NSData*)encodeData privateCertificate:(NSString *)cerName;

@end
