//
//  EXRPDFPageScrollView.h
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/12/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXRPDFMetadata.h"
#import "EXRPDFSinglePageView.h"

NS_ASSUME_NONNULL_BEGIN

@interface EXRPDFPageScrollView : UIScrollView <UIScrollViewDelegate>

@property (strong, nonatomic) EXRPDFSinglePageView *pdfSinglePageView;

- (void)setPDFPage:(CGPDFPageRef)PDFPage;

@end

NS_ASSUME_NONNULL_END
