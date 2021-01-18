//
//  EXRPDFMetadataXMLParserDelegate.h
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/11/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EXRPDFMetadata.h"

NS_ASSUME_NONNULL_BEGIN

@interface EXRPDFMetadataXMLParserDelegate : NSObject <NSXMLParserDelegate>

@property (strong, nonatomic) NSArray<EXRPDFMetadata *> *pdfMetadata;

@end

NS_ASSUME_NONNULL_END
