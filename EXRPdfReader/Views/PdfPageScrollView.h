//
//  PdfPageScrollView.h
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/12/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PdfMetadata.h"
#import "PdfSinglePageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PdfPageScrollView : UIScrollView <UIScrollViewDelegate>

// Frame of the PDF
@property (nonatomic) CGRect pageRect;

// The PdfSinglePageView that is currently front most.
@property (nonatomic, weak) PdfSinglePageView *pdfSinglePageView;

// Current PDF zoom scale.
@property (nonatomic) CGFloat pdfZoomScale;

// A reference to the page being drawn, we manage the storage ourselves for the cf type
@property (nonatomic, assign) CGPDFPageRef pdfPageRef;

- (void)setPDFPage:(CGPDFPageRef)PDFPage;

@end

NS_ASSUME_NONNULL_END
