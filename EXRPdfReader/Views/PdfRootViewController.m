//
//  PdfRootViewController.m
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/13/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "PdfRootViewController.h"
#import "PdfDataSource.h"
#import "PdfContentViewController.h"

@interface PdfRootViewController ()

@property (strong, nonatomic) PdfDataSource *pdfDataSource;

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end

@implementation PdfRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pdfDataSource = [[PdfDataSource alloc] initWithPdfMetadata:self.pdfMetadata];
    // Configure the page view controller and add it as a child view controller.
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
    PdfContentViewController *startingViewController = [self.pdfDataSource viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:NULL];
    self.pageViewController.dataSource = self.pdfDataSource;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    CGRect pageViewRect = self.view.bounds;
    self.pageViewController.view.frame = pageViewRect;
    [self.pageViewController didMoveToParentViewController:self];
}

@end
