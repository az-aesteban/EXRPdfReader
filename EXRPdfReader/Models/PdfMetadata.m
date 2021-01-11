//
//  PdfMetadata.m
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/7/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "PdfMetadata.h"

@implementation PdfMetadata

+ (instancetype)fileWithName:(NSString *)aFileName
             withDescription:(NSString *)aDescription
                withFilePath:(NSString *)aFilePath
                withSequence:(NSInteger)aSequence
                       andId:(NSString *)aPdfId {
    return [[self alloc] initFileWithName:aFileName
                          withDescription:(NSString *)aDescription
                             withFilePath:aFilePath
                             withSequence:aSequence
                                    andId:aPdfId];
}

- (instancetype)initFileWithName:(NSString *)aFileName
                 withDescription:(NSString *)aDescription
                    withFilePath:(NSString *)aFilePath
                    withSequence:(NSInteger)aSequence
                           andId:(NSString *)aPdfId {
    self = [[PdfMetadata alloc] init];
    if (self) {
        self.fileName = aFileName;
        self.pdfDescription = aDescription;
        self.filePath = aFilePath;
        self.sequence = aSequence;
        self.pdfId = aPdfId;
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
