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
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 5;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
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

#pragma mark - Override layoutSubviews to center content

- (void)layoutSubviews {
    [super layoutSubviews];
    // Center the image as it becomes smaller than the size of the screen.
    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = self.pdfSinglePageView.frame;
    
    // Center horizontally.
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    } else {
        frameToCenter.origin.x = 0;
    }

    // Center vertically.
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    } else {
        frameToCenter.origin.y = 0;
    }

    self.pdfSinglePageView.frame = frameToCenter;
    
    
    // To handle the interaction between CATiledLayer and high resolution screens,
    // set the tiling view's contentScaleFactor to 1.0.
    // If this step were omitted, the content scale factor would be 2.0 on high resolution screens
    // which would cause the CATiledLayer to ask for tiles of the wrong scale.
    self.pdfSinglePageView.contentScaleFactor = 1.0;
}

#pragma mark - UIScrollView delegate methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.pdfSinglePageView;
}

// A UIScrollView delegate callback, called when the user stops zooming.
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    // Set the new scale factor.
    self.pdfZoomScale *= scale;
}

- (void)replacePdfPageViewWithFrame:(CGRect)frame {
    // Create a new PDF Single Page View at the new scale
    PdfSinglePageView *newPdfSinglePageView = [[PdfSinglePageView alloc] initWithFrame:frame
                                                                                 scale:self.pdfZoomScale];
    [newPdfSinglePageView setPage:self.pdfPageRef];
    
    // Add the new PdfSinglePageView to the PDFPageScrollView.
    [self addSubview: newPdfSinglePageView];
    self.pdfSinglePageView = newPdfSinglePageView;
}


@end
