//
//  ZZDESSecureOperation.m
//  ZZDESSecureOperation
//
//  Created by zengqingfu on 15/3/12.
//  Copyright (c) 2015年 zengqingfu. All rights reserved.
//

#import "DESSecureOperation.h"

static const char *HEXES = "0123456789ABCDEF";
#define gIv  @"00000000"
#define kSecrectKeyLength 24
@implementation DESSecureOperation

- (NSData *)GetDUKPTKeyKsn:(NSData *) ksn ipek: (NSData *)ipek
{

    int shift = 0;
    
    Byte *ksnB = (Byte *)[ksn bytes];
    
    Byte  key[16] = {0};
    memcpy(key, [ipek bytes], 16);
    //System.arraycopy(ipek, 0, key, 0, 16);
    
    Byte  cnt[3] = {0};
    Byte temp[8] = {0};
    
    cnt[0] = (Byte)(ksnB[7] & 0x1F);
    cnt[1] = ksnB[8];
    cnt[2] = ksnB[9];
    
    memcpy(temp, &ksnB[2], 6);
    //System.arraycopy(ksn, 2, temp, 0, 6);
    temp[5] &= 0xE0;
    
   // NSData *tempDD = [NSData dataWithBytes:key length:16];
    
    
    shift = 0x10;
    while (shift > 0)
    {
        if ((cnt[0] & shift) > 0)
        {
            temp[5] |= shift;
            NRKGP(key, temp);
        }
        shift >>= 1;
    }
    shift = 0x80;
    while (shift > 0)
    {
        if ((cnt[1] & shift) > 0)
        {
            temp[6] |= shift;
            NRKGP(key, temp);
        }
        shift >>= 1;
    }
    shift = 0x80;
    while (shift > 0)
    {
        if ((cnt[2] & shift) > 0)
        {
    
            temp[7] |= shift;
            NRKGP(key, temp);

            
        }
        shift >>= 1;
    }
    NSData *keyDat = [NSData dataWithBytes:key length:16];

    return keyDat;
    //return key;
}
//对
void NRKGP(Byte *key, Byte *ksn)
{
    NSInteger i = 0;
    
    Byte temp[8] = {0};
    Byte key_temp[8] = {0};
    Byte key_l[8] = {0};
    Byte key_r[8] = {0};
    //key_l = (Byte *)malloc(8);
    //key_r = (Byte *)malloc(8);

    memcpy(key_temp, key, 8);
    //System.arraycopy(key, 0, key_temp, 0, 8);
    for (i = 0; i < 8; i++)
        temp[i] = (Byte)(ksn[i] ^ key[8 + i]);
    //TDes_Decrypt(temp, key_r, key_temp);
    
    
   // key_r = [ZZDESSecureOperation TriDesEncryptionKey:key_temp dec:temp];
    //NSData* decryptedBlock = [self DESOperation:kCCDecrypt algorithm:kCCAlgorithm3DES keySize:kCCKeySize3DES data:[self dataFromString:block] key:key];
    
    NSData *key_tempDat = [NSData dataWithBytes:key_temp length:8];
    NSData *decDat = [NSData dataWithBytes:temp length:8];
    
    NSData *encReult = [DESSecureOperation DESOperation:kCCEncrypt algorithm:kCCAlgorithmDES keySize:kCCKeySizeDES data:decDat key:key_tempDat];
    [encReult getBytes:key_r length:8];
    
    //key_r = TriDesEncryption(key_temp,temp);
    for (i = 0; i < 8; i++)
        key_r[i] ^= key[8 + i];
    
    key_temp[0] ^= 0xC0;
    key_temp[1] ^= 0xC0;
    key_temp[2] ^= 0xC0;
    key_temp[3] ^= 0xC0;
    key[8] ^= 0xC0;
    key[9] ^= 0xC0;
    key[10] ^= 0xC0;
    key[11] ^= 0xC0;
    
    for (i = 0; i < 8; i++)
        temp[i] = (Byte)(ksn[i] ^ key[8 + i]);
    //TDes_Decrypt(temp, key_l, key_temp);
    //key_l = [ZZDESSecureOperation TriDesEncryptionKey:key_temp dec:temp];
    
    NSData *key_tempDat2 = [NSData dataWithBytes:key_temp length:8];
    NSData *decDat2 = [NSData dataWithBytes:temp length:8];
    
    NSData *encReult2 = [DESSecureOperation DESOperation:kCCEncrypt algorithm:kCCAlgorithmDES keySize:kCCKeySizeDES data:decDat2 key:key_tempDat2];
    [encReult2 getBytes:key_l length:8];
    
    NSData *tempDD = [NSData dataWithBytes:key length:16];
    NSData *tempDD2 = [NSData dataWithBytes:key_l length:8];
    
    //key_l = TriDesEncryption(key_temp,temp);
    for (i = 0; i < 8; i++)
        key[i] = (Byte)(key_l[i] ^ key[8 + i]);
    memcpy(&key[8], key_r, 8);
    //System.arraycopy(key_r, 0, key, 8, 8);
    
//    free(temp);
//    free(key_l);
//    free(key_r);
//    free(key_temp);

}


// 3DES加解密 kCCKeySizeDES
+ (NSData*)DESOperation:(CCOperation)operation algorithm:(CCAlgorithm)algorithm keySize:(size_t)keySize data:(NSData*)data key:(NSData*)key
{
//    NSLog(@"operation = %d", operation);
//    NSLog(@"key = %@", key);
//    NSLog(@"data = %@", data);
    
    //NSLog(@"algorithm = %d", algorithm);
    
    NSMutableData* alterKey = [NSMutableData dataWithData:key];
    [alterKey appendData:[key subdataWithRange:NSMakeRange(0, 8)]];
    
    size_t movedBytes = 0;
    const void* plainText = [data bytes];
    size_t plainTextBufferSize = [data length];
    
    size_t bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    
    uint8_t *bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *ptrKey = [alterKey bytes];
    
    CCCryptorStatus ccStatus = CCCrypt(operation, algorithm, kCCOptionECBMode, (const void *)ptrKey, keySize, NULL, (const void *)plainText, plainTextBufferSize, (void *)bufferPtr, bufferPtrSize, &movedBytes);
    
    if (ccStatus == kCCParamError) NSLog(@"PARAM ERROR");
    else if (ccStatus == kCCBufferTooSmall) NSLog(@"BUFFER TOO SMALL");
    else if (ccStatus == kCCMemoryFailure) NSLog(@"MEMORY FAILURE");
    else if (ccStatus == kCCAlignmentError); //NSLog(@"ALIGNMENT");
    else if (ccStatus == kCCDecodeError) NSLog(@"DECODE ERROR");
    else if (ccStatus == kCCUnimplemented) NSLog(@"UNIMPLEMENTED");
    
    
    NSData* result = [NSData dataWithBytes:bufferPtr length:movedBytes];
    //NSLog(@"result = %@ \n\n\n", result);
    return result;
    
}


// 3DES解密 CBC
+ (NSData*)DESOperationCBCdata:(NSData*)data key:(NSData*)key
{
    
    //NSLog(@"data = %@", data);
   // NSLog(@"key = %@", key);
    
    NSMutableData* alterKey = [NSMutableData dataWithData:key];
    [alterKey appendData:[key subdataWithRange:NSMakeRange(0, 8)]];
    
    size_t movedBytes = 0;
    const void* plainText = [data bytes];
    size_t plainTextBufferSize = [data length];
    
    size_t bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    
    uint8_t *bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *ptrKey = [alterKey bytes];
    const void *vinitVec = (const void *) [gIv UTF8String];
    CCCryptorStatus ccStatus = CCCrypt(kCCDecrypt, kCCAlgorithm3DES, kCCOptionECBMode, (const void *)ptrKey, kCCKeySize3DES, vinitVec, (const void *)plainText, plainTextBufferSize, (void *)bufferPtr, bufferPtrSize, &movedBytes);
    
    
    if (ccStatus == kCCParamError) NSLog(@"PARAM ERROR");
    else if (ccStatus == kCCBufferTooSmall) NSLog(@"BUFFER TOO SMALL");
    else if (ccStatus == kCCMemoryFailure) NSLog(@"MEMORY FAILURE");
    else if (ccStatus == kCCAlignmentError) NSLog(@"ALIGNMENT");
    else if (ccStatus == kCCDecodeError) NSLog(@"DECODE ERROR");
    else if (ccStatus == kCCUnimplemented) NSLog(@"UNIMPLEMENTED");
    
    //NSData* result1 = [NSData dataWithBytes:bufferPtr length:movedBytes];
    NSMutableData *result = [NSMutableData dataWithBytes:bufferPtr length:8];
    
    
    CCCryptorStatus ccStatus2 = CCCrypt(kCCDecrypt, kCCAlgorithm3DES, kCCOptionPKCS7Padding, (const void *)ptrKey, kCCKeySize3DES, vinitVec, (const void *)plainText, plainTextBufferSize, (void *)bufferPtr, bufferPtrSize, &movedBytes);
    
    
    if (ccStatus2 == kCCParamError) NSLog(@"PARAM ERROR");
    else if (ccStatus2 == kCCBufferTooSmall) NSLog(@"BUFFER TOO SMALL");
    else if (ccStatus2 == kCCMemoryFailure) NSLog(@"MEMORY FAILURE");
    else if (ccStatus2 == kCCAlignmentError) NSLog(@"ALIGNMENT");
    else if (ccStatus2 == kCCDecodeError) NSLog(@"DECODE ERROR");
    else if (ccStatus2 == kCCUnimplemented) NSLog(@"UNIMPLEMENTED");
    
    [result appendBytes:&bufferPtr[8] length:(movedBytes - 8)];
    
    //NSLog(@"result = %@ \n", result);
    return result;
    
}


// 十六进制字符串转字节数组 对
-(NSData *)parseHexStr2Byte: (NSString*)hexString
{
    if (hexString == nil) {
        return ([NSData new]);
    }
    const char * bytes = [hexString UTF8String];
    NSUInteger length = strlen(bytes);
    unsigned char * r = (unsigned char *) malloc(length / 2 + 1);
    unsigned char * index = r;
    
    while ((*bytes) && (*(bytes +1))) {
        char a=(*bytes);
        char b=(*(bytes +1));
        //*index = strToChar(a, b);
        
        char encoder[3] = {'\0','\0','\0'};
        encoder[0] = a;
        encoder[1] = b;
        *index = ((char) strtol(encoder,NULL,16));
        
        index++;
        bytes+=2;
    }
    *index = '\0';
    
    NSData * result = [NSData dataWithBytes: r length: length / 2];
    free(r);
    
    return (result);
}
//字节数组转十六进制字符串 对
- (NSString*)parseByte2HexStr: (NSData *)data
{
    
    if (data == nil) {
        return ([NSString new]);
    }
    NSUInteger numBytes = [data length];
    const unsigned char* bytes = [data bytes];
    char *strbuf = (char *)malloc(numBytes * 2 + 1);
    char *hex = strbuf;
    NSString *hexBytes = nil;
    
    for (int i = 0; i<numBytes; ++i){
        const unsigned char c = *bytes++;
        *hex++ = HEXES[(c >> 4) & 0xF];
        *hex++ = HEXES[(c ) & 0xF];
    }
    *hex = 0;
    hexBytes = [NSString stringWithUTF8String:strbuf];
    free(strbuf);
    return (hexBytes);
}


//数据补位 对
- (NSString *)dataFill:(NSString *)dataStr
{
    NSInteger len = dataStr.length;
    if (len % 16 != 0) {
        dataStr = [dataStr stringByAppendingString:@"80"];
        len = dataStr.length;
    }
    while (len % 16 != 0) {
        dataStr = [dataStr stringByAppendingString:@"0"];
        len ++;
        NSLog(@"%@", dataStr);
    }
    return dataStr;
}


@end
