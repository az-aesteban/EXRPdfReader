//
//  EXRPdfMetadataXMLParserDelegate.m
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/11/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "EXRPdfMetadataXMLParserDelegate.h"

static NSString *const kPdfElementName = @"pdf";
static NSString *const kPdfFileNameElementName = @"name";
static NSString *const kPdfFilePathElementName = @"file-path";
static NSString *const kPdfSequenceElementName = @"seq";
static NSString *const kPdfIdElementName = @"pdf-id";
static NSString *const kPdfDescriptionElementName = @"desc";

@interface EXRPdfMetadataXMLParserDelegate ()

@property (strong, nonatomic) NSString *currentElementName;

@property (strong, nonatomic) PdfMetadata *parsedPdfMetadata;

@property (strong, nonatomic) NSMutableString *currentElementValue;

@end

@implementation EXRPdfMetadataXMLParserDelegate

#pragma mark - NSXMLParserDelegate Methods

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.pdfMetaData = [[NSMutableArray alloc] init];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([kPdfElementName isEqualToString:elementName]) {
        self.parsedPdfMetadata = [[PdfMetadata alloc] init];
    } else {
        self.currentElementName = elementName;
    }
    self.currentElementValue = [[NSMutableString alloc] init];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:kPdfElementName] && self.parsedPdfMetadata) {
        [self.pdfMetaData addObject:self.parsedPdfMetadata];
    } else {
        NSString *trimmedString = [self.currentElementValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([kPdfFilePathElementName isEqualToString:self.currentElementName]) {
            self.parsedPdfMetadata.filePath = trimmedString;
        } else if ([kPdfFileNameElementName isEqualToString:self.currentElementName]) {
            self.parsedPdfMetadata.fileName = trimmedString;
        } else if ([kPdfSequenceElementName isEqualToString:self.currentElementName]) {
            self.parsedPdfMetadata.sequence = [trimmedString intValue];
        } else if ([kPdfIdElementName isEqualToString:self.currentElementName]) {
            self.parsedPdfMetadata.pdfId = trimmedString;
        } else if ([kPdfDescriptionElementName isEqualToString:self.currentElementName]) {
            self.parsedPdfMetadata.fileDescription = trimmedString;
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (string) {
        if (!self.currentElementValue) {
            self.currentElementValue = [[NSMutableString alloc] init];
        }
        [self.currentElementValue appendString:string];
    }
}

@end
