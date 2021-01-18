//
//  EXRPDFSinglePageView.m
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/13/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "EXRPDFSinglePageView.h"

@implementation EXRPDFSinglePageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return self;
}

- (void)setPage:(CGPDFPageRef)newPage {
    if (self.pdfPage) {
        CGPDFPageRelease(self.pdfPage);
    }
    if (newPage) {
        self.pdfPage = CGPDFPageRetain(newPage);
    }
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    // Assume white background
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(context, rect);

    if (self.pdfPage) {
        CGContextSaveGState(context);

        // Flip the context so that the PDF page is rendered right side up.
        CGContextTranslateCTM(context, 0.0, rect.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);

        // Render page at the correct size for the zoom level.
        CGContextScaleCTM(context, self.viewScale, self.viewScale);

        // Draw the page, restore and exit
        CGContextDrawPDFPage(context, self.pdfPage);
        CGContextRestoreGState(context);
    }
}

- (void)dealloc {
    if (!_pdfPage) {
        CGPDFPageRelease(_pdfPage);
    }
}

@end
