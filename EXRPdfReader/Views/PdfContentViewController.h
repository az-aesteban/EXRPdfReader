//
//  PdfContentViewController.h
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/7/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "PdfMetadata.h"
#import "PdfPageScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PdfContentViewController: UIViewController

@property (strong, nonatomic) IBOutlet PdfPageScrollView *scrollView;

@property (strong, nonatomic) PdfMetadata *pdfMetadata;

@property (assign, nonatomic) CGPDFDocumentRef pdf;

@property (assign, nonatomic) CGPDFPageRef page;

@property (strong, nonatomic) NSNumber *pageNumber;

@property (assign, nonatomic) CGFloat viewScale;

@end

NS_ASSUME_NONNULL_END
