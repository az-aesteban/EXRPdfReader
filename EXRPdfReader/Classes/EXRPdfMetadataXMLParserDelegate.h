//
//  EXRPdfMetadataXMLParserDelegate.h
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/11/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PdfMetadata.h"

NS_ASSUME_NONNULL_BEGIN

@interface EXRPdfMetadataXMLParserDelegate : NSObject <NSXMLParserDelegate>

@property (strong, nonatomic) NSMutableArray<PdfMetadata *> *pdfMetaData;

@end

NS_ASSUME_NONNULL_END
