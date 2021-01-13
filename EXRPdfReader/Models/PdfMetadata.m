//
//  PdfMetadata.m
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/7/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "PdfMetadata.h"

@implementation PdfMetadata

+ (instancetype)fileWithName:(NSString *)fileName
             fileDescription:(NSString *)fileDescription
                    filePath:(NSString *)filePath
                    sequence:(NSInteger)sequence
                       pdfId:(NSString *)pdfId {
    return [[self alloc] initFileWithName:fileName
                          fileDescription:(NSString *)fileDescription
                                 filePath:filePath
                                 sequence:sequence
                                    pdfId:pdfId];
}

- (instancetype)initFileWithName:(NSString *)fileName
                 fileDescription:(NSString *)fileDescription
                        filePath:(NSString *)filePath
                        sequence:(NSInteger)sequence
                           pdfId:(NSString *)pdfId {
    if (self = [[PdfMetadata alloc] init]) {
        self.fileName = fileName;
        self.fileDescription = fileDescription;
        self.filePath = filePath;
        self.sequence = sequence;
        self.pdfId = pdfId;
    }
    return self;
}

- (BOOL)fileExists {
    BOOL exists = NO;
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:self.filePath
                                                             ofType:nil];
    if (resourcePath) {
        NSURL *pdfURL = [NSURL fileURLWithPath:resourcePath];
        NSError *err;
        exists = [pdfURL checkResourceIsReachableAndReturnError:&err];
    }
    return exists;
}

@end
