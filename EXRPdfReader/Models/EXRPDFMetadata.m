//
//  EXRPDFMetadata.m
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/7/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "EXRPDFMetadata.h"

@implementation EXRPDFMetadata

- (instancetype)initFileWithName:(NSString *)filename
                 fileDescription:(NSString *)fileDescription
                        filePath:(NSString *)filePath
                        sequence:(NSInteger)sequence
                           pdfID:(NSString *)pdfID {
    if (self = [[EXRPDFMetadata alloc] init]) {
        _filename = filename;
        _fileDescription = fileDescription;
        _filePath = filePath;
        _sequence = sequence;
        _pdfID = pdfID;
    }
    return self;
}

- (BOOL)fileExists {
    BOOL exists = NO;
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:self.filePath
                                                             ofType:nil];
    if (resourcePath) {
        NSURL *pdfURL = [NSURL fileURLWithPath:resourcePath];
        NSError *err = nil;
        exists = [pdfURL checkResourceIsReachableAndReturnError:&err];
        if (err) {
            NSAssert(NO, @"EXRPDFMetadata: Error encountered on checking file existence %@", err);
            return NO;
        }
    }
    return exists;
}

@end
