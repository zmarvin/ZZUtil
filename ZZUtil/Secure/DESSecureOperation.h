//
//  ZZDESSecureOperation.h
//  ZZDESSecureOperation_OC
//
//  Created by zengqingfu on 15/3/12.
//  Copyright (c) 2015年 zengqingfu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@interface DESSecureOperation : NSObject

// 3DES加解密
+ (NSData*)DESOperation:(CCOperation)operation algorithm:(CCAlgorithm)algorithm keySize:(size_t)keySize data:(NSData*)data key:(NSData*)key;
// 3DES解密 CBC
+ (NSData*)DESOperationCBCdata:(NSData*)data key:(NSData*)key;

// 十六进制字符串转字节数组
-(NSData *)parseHexStr2Byte: (NSString*)hexString;
// 字节数组转十六进制字符串
- (NSString*)parseByte2HexStr: (NSData *)data;

@end
