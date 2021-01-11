//
//  MyXmlParserDelegate.m
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/11/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "PdfMetadataXMLParserDelegate.h"

NSString *kPdfElementName = @"pdf";
NSString *kPdfFileNameElementName = @"name";
NSString *kPdfFilePathElementName = @"file-path";
NSString *kPdfSequenceElementName = @"seq";
NSString *kPdfIdElementName = @"pdf-id";
NSString *kPdfDescriptionElementName = @"desc";


@interface PdfMetadataXMLParserDelegate ()

@property (nonatomic, strong) NSString *currentElementName;
@property (nonatomic, strong) PdfMetadata *parsedPdfMetadata;
@property (nonatomic, strong) NSMutableString *currentElementValue;

@end

@implementation PdfMetadataXMLParserDelegate

#pragma mark - NSXMLParserDelegate Methods

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    self.pdfMetaData = [[NSMutableArray alloc] init];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:kPdfElementName]) {
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
        if ([self.currentElementName isEqualToString:kPdfFilePathElementName]) {
            self.parsedPdfMetadata.filePath = trimmedString;
        } else if ([self.currentElementName isEqualToString:kPdfFileNameElementName]) {
            self.parsedPdfMetadata.fileName = trimmedString;
        } else if ([self.currentElementName isEqualToString:kPdfSequenceElementName]) {
            self.parsedPdfMetadata.sequence = [trimmedString intValue];
        } else if ([self.currentElementName isEqualToString:kPdfIdElementName]) {
            self.parsedPdfMetadata.pdfId = trimmedString;
        } else if ([self.currentElementName isEqualToString:kPdfDescriptionElementName]) {
            self.parsedPdfMetadata.pdfDescription = trimmedString;
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
