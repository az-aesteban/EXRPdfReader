//
//  EXRPDFRootViewController.h
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/13/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EXRPDFDataSource.h"
#import "EXRPDFMetadata.h"

NS_ASSUME_NONNULL_BEGIN

@interface EXRPDFRootViewController : UIViewController

- (instancetype)initWithFilePath:(NSString *)filePath;

@end

NS_ASSUME_NONNULL_END
