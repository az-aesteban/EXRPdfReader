//
//  PdfRootViewController.h
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/13/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PdfDataSource.h"
#import "PdfMetadata.h"

NS_ASSUME_NONNULL_BEGIN

@interface PdfRootViewController : UIViewController

@property (strong, nonatomic) PdfMetadata *metadata;

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (strong, nonatomic) PdfDataSource *pdfDataSource;

@end

NS_ASSUME_NONNULL_END
