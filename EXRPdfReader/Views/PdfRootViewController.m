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

@property (strong, nonatomic) NSString *filePath;

@end

@implementation PdfRootViewController

- (instancetype)initWithFilePath:(NSString *)filePath {
    if (self = [super init]) {
        self.filePath = filePath;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pdfDataSource = [[PdfDataSource alloc] initWithFilePath:self.filePath];
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
    PdfContentViewController *startingViewController = [self.pdfDataSource viewControllerAtIndex:0];
    [self.pageViewController setViewControllers:@[startingViewController]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:NULL];
    self.pageViewController.dataSource = self.pdfDataSource;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    CGRect pageViewRect = self.view.bounds;
    self.pageViewController.view.frame = pageViewRect;
    [self.pageViewController didMoveToParentViewController:self];
}

@end
