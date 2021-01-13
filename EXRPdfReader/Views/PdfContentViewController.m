//
//  PdfContentViewController.m
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/7/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "PdfContentViewController.h"

@implementation PdfContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.pdfMetadata.fileName;

    // Do any additional setup after loading the view, typically from a nib.
    self.page = CGPDFDocumentGetPage( self.pdf, self.pageNumber );
    if ( self.page != NULL ) CGPDFPageRetain( self.page );
    [self.scrollView setPDFPage:self.page];
}


- (void)viewDidLayoutSubviews {
    [self restoreScale];
}

#pragma mark - Layout Methods

- (void)restoreScale {
    // Called on orientation change.
    // We need to zoom out and basically reset the scrollview to look right in two-page spline view.
    CGRect pageRect = CGPDFPageGetBoxRect( self.page, kCGPDFMediaBox );
    CGFloat yScale = self.view.frame.size.height / pageRect.size.height;
    CGFloat xScale = self.view.frame.size.width / pageRect.size.width;
    self.viewScale = MIN( xScale, yScale );
    self.scrollView.bounds = self.view.bounds;
    self.scrollView.zoomScale = 1.0;
    self.scrollView.pdfZoomScale = self.viewScale;

    self.scrollView.pdfSinglePageView.bounds = self.view.bounds;
    self.scrollView.pdfSinglePageView.viewScale = self.viewScale;
    [self.scrollView.pdfSinglePageView.layer setNeedsDisplay];
}

@end
