//
//  PdfSinglePageView.h
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/13/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PdfSinglePageView : UIView

@property CGPDFPageRef pdfPage;

@property CGFloat viewScale;

- (id)initWithFrame:(CGRect)frame scale:(CGFloat)scale;

- (void)setPage:(CGPDFPageRef)newPage;

@end

NS_ASSUME_NONNULL_END
