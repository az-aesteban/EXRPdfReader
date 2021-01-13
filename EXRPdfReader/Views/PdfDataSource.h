//
//  PdfDataSource.h
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/13/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PdfMetadata.h"
#import "PdfContentViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PdfDataSource : NSObject <UIPageViewControllerDataSource>

@property (assign, nonatomic) CGPDFDocumentRef pdf;

@property (assign, nonatomic) NSInteger numberOfPages;

- (instancetype)initWithPdfMetadata:(PdfMetadata *)metadata;

- (PdfContentViewController *)viewControllerAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
