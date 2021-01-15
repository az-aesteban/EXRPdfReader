//
//  PdfSinglePageView.m
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/13/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "PdfSinglePageView.h"

static NSInteger const kTileLayerLOD = 3;
static NSInteger const kTileLayerLODBias = 4;
static NSInteger const kTileLayerHeight = 512.0;
static NSInteger const kTileLayerWidth = 512.0;

@implementation PdfSinglePageView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CATiledLayer *tiledLayer = (CATiledLayer *)[self layer];
        tiledLayer.levelsOfDetail = kTileLayerLOD;
        tiledLayer.levelsOfDetailBias = kTileLayerLODBias;
        tiledLayer.tileSize = CGSizeMake(kTileLayerWidth, kTileLayerHeight);
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 5;
    }
    return self;
}

+ (Class)layerClass {
    return [CATiledLayer class];
}

- (void)setPage:(CGPDFPageRef)newPage {
    if (self.pdfPageRef) {
        CGPDFPageRelease(self.pdfPageRef);
    }
    if (newPage) {
        self.pdfPageRef = CGPDFPageRetain(newPage);
    }
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context {

    // Assume white background
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextFillRect(context, self.bounds);
 
    if (self.pdfPageRef) {
        CGContextSaveGState(context);

        // Flip the context so that the PDF page is rendered right side up.
        CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);

        // Render page at the correct size for the zoom level.
        CGContextScaleCTM(context, self.viewScale, self.viewScale);

        // Draw the page, restore and exit
        CGContextDrawPDFPage(context, self.pdfPageRef);
        CGContextRestoreGState(context);
    }
}

@end
