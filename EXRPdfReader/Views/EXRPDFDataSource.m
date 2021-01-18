//
//  EXRPDFDataSource.m
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/13/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "EXRPDFDataSource.h"
#import "EXRPDFContentViewController.h"

@interface EXRPDFDataSource ()

@property (assign, nonatomic) CGPDFDocumentRef pdf;

@property (assign, nonatomic) NSInteger pageCount;

@end

@implementation EXRPDFDataSource

- (instancetype)initWithFilePath:(NSString *)filePath {
    if (self = [super init]) {
        NSURL *pdfURL = [[NSBundle mainBundle] URLForResource:filePath
                                                withExtension:nil];
        if (!pdfURL) {
            NSAssert(NO, @"EXRPDFDataSource: Missing pdf file %@", filePath);
            return nil;
        }
        NSLog(@"EXRPDFDataSource: Successfully loaded PDF file");
        self.pdf = CGPDFDocumentCreateWithURL((__bridge CFURLRef) pdfURL);
        self.pageCount = CGPDFDocumentGetNumberOfPages(self.pdf);
    }
    return self;
}

- (void)dealloc {
    if (_pdf) {
        CGPDFDocumentRelease(_pdf);
    }
}

#pragma mark - Navigation Methods

/**
* @brief Creates a new view controller with suitable data.
*/
- (EXRPDFContentViewController *)viewControllerAtIndex:(NSUInteger)index {
    EXRPDFContentViewController *pdfContentViewController = [[EXRPDFContentViewController alloc] initWithNibName:@"EXRPDFContentViewController"
                                                                                                    bundle:[NSBundle mainBundle]];
    // pageNumber starts with 1, index starts with 0. Add +1 to retrieve page number.
    pdfContentViewController.pageNumber = [NSNumber numberWithUnsignedLong:index + 1];
    pdfContentViewController.pdf = self.pdf;
    return pdfContentViewController;
}

#pragma mark - UIPageViewControllerDataSource Methods

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if (![viewController isKindOfClass:[EXRPDFContentViewController class]]) {
        NSAssert(NO, @"EXRPDFDataSource: viewController is not an EXRPDFContentViewController type %@", viewController);
        return nil;
    }
    NSUInteger index = [self indexOfViewController:(EXRPDFContentViewController *)viewController];
    UIViewController *viewControllerBefore = nil;
    // Only shift to previous page if index points is not out of bounds
    if (index != 0 && index != NSNotFound) {
        viewControllerBefore = [self viewControllerAtIndex:index - 1];
    }
    return viewControllerBefore;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if (![viewController isKindOfClass:[EXRPDFContentViewController class]]) {
        NSAssert(NO, @"EXRPDFDataSource: viewController is not an EXRPDFContentViewController type %@", viewController);
        return nil;
    }
    NSUInteger index = [self indexOfViewController:(EXRPDFContentViewController *)viewController];
    UIViewController *viewControllerAfter = nil;
    NSUInteger nextPageIndex = index + 1;
    // Only shift to next page if index points is not out of bounds
    if (index != NSNotFound && nextPageIndex != self.pageCount) {
        viewControllerAfter = [self viewControllerAtIndex:nextPageIndex];
    }
    return viewControllerAfter;
}

#pragma mark - Helper Methods

- (NSUInteger)indexOfViewController:(EXRPDFContentViewController *)viewController {
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object;
    // you can therefore use the model object to identify the index.
    return viewController.pageNumber.unsignedLongValue - 1;
}

@end
