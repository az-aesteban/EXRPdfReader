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

@property (assign, nonatomic) CGPDFDocumentRef pdf;

@property (strong, nonatomic) NSNumber *pageNumber;

@end

NS_ASSUME_NONNULL_END
