//
//  PdfViewController.h
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/7/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PdfContentView.h"
#import "PdfMetadata.h"

NS_ASSUME_NONNULL_BEGIN

@interface PdfViewController : UIViewController

@property (nonatomic, strong) PdfMetadata *pdfMetadata;

@end

NS_ASSUME_NONNULL_END
