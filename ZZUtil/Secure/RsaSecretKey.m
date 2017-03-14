//
//  RsaSecretKey.m
//  恒信通
//
//  Created by zz on 15/1/3.
//  Copyright (c) 2015年 zz. All rights reserved.
//

#import "RsaSecretKey.h"
#import "NSString+ZZPercentEscape.h"
#import <Security/Security.h>
#import "GTMBase64.h"

@implementation RsaSecretKey

+ (NSData*)rsaEncryptString:(NSString*)string publicCertificate:(NSString *)cerName{
    
    SecKeyRef key = [self publicKeyWithCertificate:cerName];
    
    size_t cipherBufferSize = SecKeyGetBlockSize(key);
    uint8_t *cipherBuffer = malloc(cipherBufferSize * sizeof(uint8_t));
    
    NSString *urlEncoding = [string percentEscapeAdd];
    NSData *stringBytes = [urlEncoding dataUsingEncoding:NSUTF8StringEncoding];
    size_t blockSize = cipherBufferSize - 11;
    size_t blockCount = (size_t)ceil([stringBytes length] / (double)blockSize);
    NSMutableData *encryptedData = [NSMutableData data];
    NSData *buffer = nil;
    OSStatus status;
    for (int i=0; i<blockCount; i++) {
        NSInteger bufferSize = MIN(blockSize,[stringBytes length] - i * blockSize);
        buffer = [stringBytes subdataWithRange:NSMakeRange(i * blockSize, bufferSize)];
        status = SecKeyEncrypt(key, kSecPaddingPKCS1, (const uint8_t *)[buffer bytes],
                               [buffer length], cipherBuffer, &cipherBufferSize);
        if (status == noErr){
            [encryptedData appendBytes:(const void *)cipherBuffer length:cipherBufferSize];
        }else{
            if (cipherBuffer) free(cipherBuffer);
            return nil;
        }
    }
    if (cipherBuffer) free(cipherBuffer);
    return [GTMBase64 encodeData:encryptedData];
}

+ (SecKeyRef)publicKeyWithCertificate:(NSString *)cerName{
    NSData *certificateData =  [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:cerName ofType:nil]];
    SecCertificateRef myCertificate =  SecCertificateCreateWithData(kCFAllocatorDefault, (__bridge CFDataRef)certificateData);
    SecPolicyRef myPolicy = SecPolicyCreateBasicX509();
    SecTrustRef myTrust;
    OSStatus status = SecTrustCreateWithCertificates(myCertificate,myPolicy,&myTrust);
    SecTrustResultType trustResult;
    if (status == noErr) {
        status = SecTrustEvaluate(myTrust, &trustResult);
    }
    SecKeyRef _public_key = SecTrustCopyPublicKey(myTrust);
    CFRelease(myCertificate);
    CFRelease(myPolicy);
    CFRelease(myTrust);
    certificateData = nil;
    return _public_key;
}

+ (SecKeyRef)privateKeyWithCertificate:(NSString *)cerName{
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:cerName ofType:nil];
    NSData *p12Data = [NSData dataWithContentsOfFile:resourcePath];
    OSStatus securityError = errSecSuccess;
    CFStringRef password = CFSTR("123456");//生成时密码
    const void *keys[] =   { kSecImportExportPassphrase };
    const void *values[] = { password };
    CFDictionaryRef optionsDictionary = CFDictionaryCreate(
                                                           NULL, keys,
                                                           values, 1,
                                                           NULL, NULL);  // 6
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import((__bridge CFDataRef)(p12Data),
                                    optionsDictionary,
                                    &items);
    p12Data = nil;
    
    SecKeyRef _private_key;
    if (securityError == 0) {
        if (CFArrayGetCount(items) > 0){
            CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex (items, 0);
            SecIdentityRef identityApp = NULL;
            identityApp = (SecIdentityRef)CFDictionaryGetValue (myIdentityAndTrust,
                                                                kSecImportItemIdentity);
            SecIdentityCopyPrivateKey(identityApp, &_private_key);
        }
    }
    return _private_key;
}

+ (NSData*)rsaDecryptWithData:(NSData*)encodeData privateCertificate:(NSString *)cerName{
    SecKeyRef key = [self privateKeyWithCertificate:cerName];
    if (key == nil) {
        NSLog(@"privat key null");
        return nil;
    }
    NSData *wrappedSymmetricKey = [GTMBase64 decodeData:encodeData];//[string dataUsingEncoding:NSUTF8StringEncoding];
    size_t cipherBufferSize = SecKeyGetBlockSize(key);
    size_t keyBufferSize = [wrappedSymmetricKey length];
    if (keyBufferSize == 0) {
        return nil;
    }
    NSMutableData *bits = [NSMutableData data];
    // 对数据分段解密
    size_t blockSize = cipherBufferSize;//128
    size_t blockCount = (size_t)ceil(keyBufferSize / (double)blockSize);
    size_t planSize = 0;
    size_t totalSize = 0;
    NSMutableData *subbits = [NSMutableData dataWithCapacity:blockSize];
    for (int i=0; i<blockCount; i++) {
        NSInteger bufferSize = MIN(blockSize,keyBufferSize - i * blockSize);
        NSData *buffer = [wrappedSymmetricKey subdataWithRange:NSMakeRange(i * blockSize, bufferSize)];
        planSize = bufferSize;
        //            NSData *encryptedBytes = [[NSData alloc] initWithBytes:(const void *)cipherBuffer length:cipherBufferSize];
        
        OSStatus status  = SecKeyDecrypt(key,
                                         kSecPaddingPKCS1,
                                         (const uint8_t *) [buffer bytes],
                                         cipherBufferSize,
                                         [subbits mutableBytes],
                                         //                      cipherBuffer,
                                         &planSize);
        if (status == noErr){
            totalSize += planSize;
            [bits appendBytes:(const void *)subbits.bytes length:planSize];
        }else{
            return nil;
        }
    }
    NSLog(@"totals   size %ld",totalSize);
    [bits setLength:totalSize];
    //    subbits = nil;
    NSString *result2 = [[NSString alloc] initWithData:bits  encoding:NSUTF8StringEncoding];
    bits = nil;
    return [[result2 percentEscapesReplace] dataUsingEncoding:NSUTF8StringEncoding] ;

}






@end
