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

@property(nonatomic, strong) NSString *pdfId;

@property(nonatomic, strong) NSString *pdfDescription;

@property(nonatomic, assign) NSInteger sequence;

@property(nonatomic, strong) NSString *fileName;

@property(nonatomic, strong) NSString *filePath;

+ (instancetype)fileWithName:(NSString *)aFileName
             withDescription:(NSString *)aDescription
                withFilePath:(NSString *)aFilePath
                withSequence:(NSInteger)aSequence
                       andId:(NSString *)pdfId;

- (BOOL)fileExists;

@end

NS_ASSUME_NONNULL_END
