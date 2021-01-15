//
//  PdfPageScrollView.m
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/12/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "PdfPageScrollView.h"

@interface PdfPageScrollView ()

@property (assign, nonatomic) CGRect pageRect;

@property (assign, nonatomic) CGPDFPageRef pdfPageRef;

@end

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
    if (pdfSinglePageViewFrame.size.width < boundsSize.width) {
        pdfSinglePageViewFrame.origin.x = (boundsSize.width - pdfSinglePageViewFrame.size.width) / 2;
    } else {
        pdfSinglePageViewFrame.origin.x = 0;
    }
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
        self.pageRect = CGPDFPageGetBoxRect(self.pdfPageRef,
                                            kCGPDFMediaBox);
        self.pageRect = CGRectMake(self.pageRect.origin.x,
                                   self.pageRect.origin.y,
                                   self.pageRect.size.width,
                                   self.pageRect.size.height);
    }
    self.pdfSinglePageView = [self pdfPageViewWithFrame:self.pageRect];
}

- (PdfSinglePageView *)pdfPageViewWithFrame:(CGRect)frame {
    PdfSinglePageView *newPdfSinglePageView = [[PdfSinglePageView alloc] initWithFrame:frame];
    [newPdfSinglePageView setPage:self.pdfPageRef];
    [self addSubview: newPdfSinglePageView];
    return newPdfSinglePageView;
}

@end
