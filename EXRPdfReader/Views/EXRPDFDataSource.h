//
//  EXRPDFDataSource.h
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/13/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXRPDFMetadata.h"
#import "EXRPDFContentViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EXRPDFDataSource : NSObject <UIPageViewControllerDataSource>

- (instancetype)initWithFilePath:(NSString *)filePath;

- (EXRPDFContentViewController *)viewControllerAtIndex:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END
