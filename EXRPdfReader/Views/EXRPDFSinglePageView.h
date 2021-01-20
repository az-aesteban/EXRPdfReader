//
//  EXRPDFSinglePageView.h
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/13/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EXRPDFSinglePageView : UIView

@property (assign, nonatomic) CGPDFPageRef pdfPage;

@property (assign, nonatomic) CGFloat viewScale;

@property (assign, nonatomic) BOOL editModeEnabled;

- (void)setPage:(CGPDFPageRef)newPage;

@end

NS_ASSUME_NONNULL_END
