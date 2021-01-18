//
//  EXRPDFMetadata.h
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/7/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EXRPDFMetadata : NSObject

@property (strong, nonatomic) NSString *pdfID;

@property (strong, nonatomic) NSString *fileDescription;

@property (assign, nonatomic) NSInteger sequence;

@property (strong, nonatomic) NSString *filename;

@property (strong, nonatomic) NSString *filePath;

- (instancetype)initFileWithName:(NSString *)filename
                 fileDescription:(NSString *)fileDescription
                        filePath:(NSString *)filePath
                        sequence:(NSInteger)sequence
                           pdfID:(NSString *)pdfID;

- (BOOL)fileExists;

@end

NS_ASSUME_NONNULL_END
