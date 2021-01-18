//
//  EXRPDFRootViewController.m
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/13/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "EXRPDFRootViewController.h"
#import "EXRPDFDataSource.h"
#import "EXRPDFContentViewController.h"

@interface EXRPDFRootViewController ()

@property (strong, nonatomic) EXRPDFDataSource *pdfDataSource;

@property (strong, nonatomic) UIPageViewController *pageViewController;

@property (strong, nonatomic) NSString *filePath;

@end

@implementation EXRPDFRootViewController

- (instancetype)initWithFilePath:(NSString *)filePath {
    if (self = [super init]) {
        _filePath = filePath;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pdfDataSource = [[EXRPDFDataSource alloc] initWithFilePath:self.filePath];
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                              navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                            options:nil];
    EXRPDFContentViewController *startingViewController = [self.pdfDataSource viewControllerAtIndex:0];
    [self.pageViewController setViewControllers:@[startingViewController]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:NULL];
    self.pageViewController.dataSource = self.pdfDataSource;
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}

@end
