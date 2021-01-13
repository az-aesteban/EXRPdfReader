//
//  PdfPageScrollView.m
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/12/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "PdfPageScrollView.h"

@implementation PdfPageScrollView

- (void)initialize {
    self.decelerationRate = UIScrollViewDecelerationRateFast;
    self.delegate = self;
    self.minimumZoomScale = .25;
    self.maximumZoomScale = 5;
    self.layer.backgroundColor = [UIColor grayColor].CGColor;
}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // Center the image as it becomes smaller than the size of the screen.
    CGSize boundsSize = self.bounds.size;
    CGRect pdfSinglePageViewFrame = self.pdfSinglePageView.frame;
    // Center horizontally.
    if (pdfSinglePageViewFrame.size.width < boundsSize.width) {
        pdfSinglePageViewFrame.origin.x = (boundsSize.width - pdfSinglePageViewFrame.size.width) / 2;
    } else {
        pdfSinglePageViewFrame.origin.x = 0;
    }
    // Center vertically.
    if (pdfSinglePageViewFrame.size.height < boundsSize.height) {
        pdfSinglePageViewFrame.origin.y = (boundsSize.height - pdfSinglePageViewFrame.size.height) / 2;
    } else {
        pdfSinglePageViewFrame.origin.y = 0;
    }
    self.pdfSinglePageView.frame = pdfSinglePageViewFrame;
}

#pragma mark - UIScrollView delegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.pdfSinglePageView;
}

#pragma mark - PdfPageScrollView methods

- (void)setPDFPage:(CGPDFPageRef)newPDFPage {
    if (newPDFPage) {
        CGPDFPageRetain(newPDFPage);
    }
    if (self.pdfPageRef) {
        CGPDFPageRelease(self.pdfPageRef);
    }
    self.pdfPageRef = newPDFPage;
    // pdfPageRef is null if we're requested to draw a padded blank page by the parent UIPageViewController
    if (!self.pdfPageRef) {
        self.pageRect = self.bounds;
    } else {
        self.pageRect = CGPDFPageGetBoxRect(self.pdfPageRef, kCGPDFMediaBox);
        self.pdfZoomScale = self.frame.size.width / self.pageRect.size.width;
        self.pageRect = CGRectMake(self.pageRect.origin.x, self.pageRect.origin.y, self.pageRect.size.width * self.pdfZoomScale, self.pageRect.size.height * self.pdfZoomScale);
    }
    // Create the page view based on the size of the PDF page and scale it to fit the view.
    [self replacePdfPageViewWithFrame:self.pageRect];
}

- (void)replacePdfPageViewWithFrame:(CGRect)frame {
    PdfSinglePageView *newPdfSinglePageView = [[PdfSinglePageView alloc] initWithFrame:frame];
    [newPdfSinglePageView setPage:self.pdfPageRef];
    [self addSubview: newPdfSinglePageView];
    self.pdfSinglePageView = newPdfSinglePageView;
}

@end
