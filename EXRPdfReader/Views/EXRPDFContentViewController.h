//
//  EXRPDFContentViewController.h
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/7/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "EXRPDFMetadata.h"
#import "EXRPDFPageScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface EXRPDFContentViewController: UIViewController

@property (assign, nonatomic) CGPDFDocumentRef pdf;

// Page number (accessed using unsignedLongValue). Dictates what page content to view
@property (strong, nonatomic) NSNumber *pageNumber;

@end

NS_ASSUME_NONNULL_END
