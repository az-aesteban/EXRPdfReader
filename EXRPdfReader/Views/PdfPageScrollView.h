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

@property (strong, nonatomic) PdfSinglePageView *pdfSinglePageView;

- (void)setPDFPage:(CGPDFPageRef)PDFPage;

@end

NS_ASSUME_NONNULL_END
