//
//  EXRPDFContentViewController.m
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/7/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "EXRPDFContentViewController.h"

@interface EXRPDFContentViewController ()

@property (assign, nonatomic) CGPDFPageRef page;

@property (assign, nonatomic) CGFloat viewScale;

@end

@implementation EXRPDFContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
    self.page = CGPDFDocumentGetPage(self.pdf, (size_t) self.pageNumber.unsignedLongValue);
    if (self.page) {
        CGPDFPageRetain(self.page);
    }
    [self.scrollView setPDFPage:self.page];
}

- (void)viewDidLayoutSubviews {
    [self restoreScale];
}

- (void)dealloc {
    if (!_page) {
        CGPDFPageRelease(_page);
    }
}

#pragma mark - Layout Methods

- (void)restoreScale {
    // Called on orientation change.
    // Zoom out and basically reset the scrollview to look right.
    CGRect pageRect = CGPDFPageGetBoxRect(self.page, kCGPDFMediaBox);
    CGFloat heightScale = self.view.frame.size.height / pageRect.size.height;
    CGFloat widthScale = self.view.frame.size.width / pageRect.size.width;
    self.viewScale = MIN(widthScale, heightScale);
    self.scrollView.bounds = self.view.bounds;
    self.scrollView.zoomScale = self.viewScale;
    self.scrollView.pdfSinglePageView.bounds = CGRectMake(self.view.bounds.origin.x,
                                                          self.view.bounds.origin.y,
                                                          pageRect.size.width,
                                                          pageRect.size.height);
    self.scrollView.pdfSinglePageView.viewScale = 1.0;
    [self.scrollView.pdfSinglePageView.layer setNeedsDisplay];
}

@end
