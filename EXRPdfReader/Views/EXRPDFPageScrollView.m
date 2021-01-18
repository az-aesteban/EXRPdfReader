//
//  EXRPDFPageScrollView.m
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/12/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "EXRPDFPageScrollView.h"

static CGFloat kMinimumZoomScale = 0.25;
static CGFloat kMaximumZoomScale = 5.0;

@interface EXRPDFPageScrollView ()

@property (assign, nonatomic) CGRect pageRect;

@property (assign, nonatomic) CGPDFPageRef pdfPage;

@end

@implementation EXRPDFPageScrollView

- (void)initialize {
    self.decelerationRate = UIScrollViewDecelerationRateFast;
    self.delegate = self;
    self.minimumZoomScale = kMinimumZoomScale;
    self.maximumZoomScale = kMaximumZoomScale;
    self.layer.backgroundColor = [UIColor grayColor].CGColor;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
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

- (void)dealloc {
    if (_pdfPage) {
        CGPDFPageRelease(_pdfPage);
    }
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
    if (self.pdfPage) {
        CGPDFPageRelease(self.pdfPage);
    }
    self.pdfPage = newPDFPage;
    // pdfPage is null if we're requested to draw a padded blank page by the parent UIPageViewController
    if (!self.pdfPage) {
        self.pageRect = self.bounds;
    }
    self.pdfSinglePageView = [self pdfPageViewWithFrame:self.pageRect];
}

- (EXRPDFSinglePageView *)pdfPageViewWithFrame:(CGRect)frame {
    EXRPDFSinglePageView *newPdfSinglePageView = [[EXRPDFSinglePageView alloc] initWithFrame:frame];
    [newPdfSinglePageView setPage:self.pdfPage];
    [self addSubview:newPdfSinglePageView];
    return newPdfSinglePageView;
}

@end
