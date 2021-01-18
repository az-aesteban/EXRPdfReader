//
//  EXRPDFMetadataXMLParserDelegate.m
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/11/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "EXRPDFMetadataXMLParserDelegate.h"

static NSString *const kPDFElementName = @"pdf";
static NSString *const kPDFFileNameElementName = @"name";
static NSString *const kPDFFilePathElementName = @"file-path";
static NSString *const kPDFSequenceElementName = @"seq";
static NSString *const kPDFIDElementName = @"pdf-id";
static NSString *const kPDFDescriptionElementName = @"desc";

@interface EXRPDFMetadataXMLParserDelegate ()

@property (strong, nonatomic) NSString *currentElementName;

@property (strong, nonatomic) EXRPDFMetadata *currentPDFMetadata;

@property (strong, nonatomic) NSMutableString *currentElementValue;

@property (strong, nonatomic) NSMutableArray<EXRPDFMetadata *> *parsedPDFMetadata;

@end

@implementation EXRPDFMetadataXMLParserDelegate

#pragma mark - NSXMLParserDelegate Methods

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.parsedPDFMetadata = [[NSMutableArray alloc] init];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([kPDFElementName isEqualToString:elementName]) {
        self.currentPDFMetadata = [[EXRPDFMetadata alloc] init];
    } else {
        self.currentElementName = elementName;
    }
    self.currentElementValue = [[NSMutableString alloc] init];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:kPDFElementName] && self.currentPDFMetadata) {
        [self.parsedPDFMetadata addObject:self.currentPDFMetadata];
    } else {
        NSString *trimmedString = [self.currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([kPDFFilePathElementName isEqualToString:self.currentElementName]) {
            self.currentPDFMetadata.filePath = trimmedString;
        } else if ([kPDFFileNameElementName isEqualToString:self.currentElementName]) {
            self.currentPDFMetadata.filename = trimmedString;
        } else if ([kPDFSequenceElementName isEqualToString:self.currentElementName]) {
            self.currentPDFMetadata.sequence = [trimmedString intValue];
        } else if ([kPDFIDElementName isEqualToString:self.currentElementName]) {
            self.currentPDFMetadata.pdfID = trimmedString;
        } else if ([kPDFDescriptionElementName isEqualToString:self.currentElementName]) {
            self.currentPDFMetadata.fileDescription = trimmedString;
        } else {
            NSAssert(NO, @"EXRPDFMetadataXMLParserDelegate: XML is malformed. Unexpected element name (%@).", self.currentElementName);
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (!string) {
        NSAssert(NO, @"EXRPDFMetadataXMLParserDelegate: No character found");
        return;
    }
    [self.currentElementValue appendString:string];
}

- (NSArray<EXRPDFMetadata *> *)pdfMetadata {
    return self.parsedPDFMetadata;
}

@end
