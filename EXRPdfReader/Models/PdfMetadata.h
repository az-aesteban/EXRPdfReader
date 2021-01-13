//
//  PdfMetadata.h
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/7/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PdfMetadata : NSObject

@property (strong, nonatomic) NSString *pdfId;

@property (strong, nonatomic) NSString *fileDescription;

@property (assign, nonatomic) NSInteger sequence;

@property (strong, nonatomic) NSString *fileName;

@property (strong, nonatomic) NSString *filePath;

+ (instancetype)fileWithName:(NSString *)fileName
             fileDescription:(NSString *)fileDescription
                    filePath:(NSString *)filePath
                    sequence:(NSInteger)sequence
                       pdfId:(NSString *)pdfId;

- (BOOL)fileExists;

@end

NS_ASSUME_NONNULL_END
