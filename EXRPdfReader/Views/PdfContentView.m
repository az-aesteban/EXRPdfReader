//
//  PdfContentView.m
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/7/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "PdfContentView.h"

@implementation PdfContentView 

- (void)drawRect:(CGRect)rect {
    // Code from https://www.cocoanetics.com/2010/06/rendering-pdf-is-easier-than-you-thought
    if (self.pdfMetadata) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        // PDF might be transparent, assume white paper
        [[UIColor whiteColor] set];
        CGContextFillRect(context, rect);

        // Flip coordinates
        CGContextGetCTM(context);
        CGContextScaleCTM(context, 1, -1);
        CGContextTranslateCTM(context, 0, -rect.size.height);
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:self.pdfMetadata.filePath
                                                             ofType:nil];
        NSURL *pdfURL = [NSURL fileURLWithPath:filePath];

        if (pdfURL) {
            NSLog(@"PdfContentView: Pdf File found. Viewing PDF with ID [%@].", self.pdfMetadata.pdfId);
            CGPDFDocumentRef pdfDocument = CGPDFDocumentCreateWithURL((CFURLRef)pdfURL);
            CGPDFPageRef documentFirstPageRef = CGPDFDocumentGetPage(pdfDocument, 1);

#warning To be fixed
            // Fit to page: Get the rectangle of the cropped inside
//            CGRect mediaRect = CGPDFPageGetBoxRect(documentFirstPageRef, kCGPDFCropBox);
//            CGContextScaleCTM(context, rect.size.width / mediaRect.size.width,
//               rect.size.height / mediaRect.size.height);
//            CGContextTranslateCTM(context, -mediaRect.origin.x, -mediaRect.origin.y);

            CGContextDrawPDFPage(context, documentFirstPageRef);
            CGPDFDocumentRelease(pdfDocument);
        } else {
            NSLog(@"PdfContentView: No pdf to view.");
        }
    } else {
        NSLog(@"PdfContentView: No pdf to view.");
    }
}

@end
