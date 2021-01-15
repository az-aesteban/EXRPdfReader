//
//  PdfDataSource.m
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/13/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "PdfDataSource.h"
#import "PdfContentViewController.h"

@interface PdfDataSource ()

@property (assign, nonatomic) CGPDFDocumentRef pdf;

@property (assign, nonatomic) NSInteger numberOfPages;

@end

@implementation PdfDataSource

- (instancetype)initWithPdfMetadata:(PdfMetadata *)metadata {
    if (self = [super init]) {
        // Create the data model.
        NSURL *pdfURL = [[NSBundle mainBundle] URLForResource:metadata.filePath
                                                withExtension:nil];
        if (pdfURL) {
            NSLog(@"PdfDataSource: Loaded PDF file with pdf-id %@", metadata.pdfId);
            self.pdf = CGPDFDocumentCreateWithURL((__bridge CFURLRef) pdfURL);
            self.numberOfPages = CGPDFDocumentGetNumberOfPages(self.pdf);
        } else {
            // Missing pdf file, cannot proceed.
            NSLog(@"PdfDataSource: Missing pdf file %@", metadata.filePath);
        }
    }
    return self;
}

#pragma mark - Navigation Methods

- (PdfContentViewController *)viewControllerAtIndex:(NSUInteger)index {
    // Create a new view controller and pass suitable data.
    PdfContentViewController *pdfContentViewController = [[PdfContentViewController alloc] initWithNibName:@"PdfContentViewController"
                                                                                                    bundle:[NSBundle mainBundle]];
    pdfContentViewController.pageNumber = [NSNumber numberWithUnsignedLong:index + 1];
    pdfContentViewController.pdf = self.pdf;
    return pdfContentViewController;
}

#pragma mark - UIPageViewControllerDataSource Methods

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexOfViewController:(PdfContentViewController *)viewController];
    UIViewController *viewControllerBefore = nil;
    if (index != 0 && index != NSNotFound) {
        viewControllerBefore = [self viewControllerAtIndex:index - 1];
    }
    return viewControllerBefore;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexOfViewController:(PdfContentViewController *)viewController];
    UIViewController *viewControllerAfter = nil;
    NSUInteger nextPageIndex = index + 1;
    if (index != NSNotFound && nextPageIndex != self.numberOfPages) {
        viewControllerAfter = [self viewControllerAtIndex:nextPageIndex];
    }
    return viewControllerAfter;
}

#pragma mark - Helper Methods

- (NSUInteger)indexOfViewController:(PdfContentViewController *)viewController {
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object;
    // you can therefore use the model object to identify the index.
    return viewController.pageNumber.unsignedLongValue - 1;
}

@end
