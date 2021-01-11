//
//  PdfTableViewCell.h
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/11/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PdfMetadata.h"

NS_ASSUME_NONNULL_BEGIN

@interface PdfTableViewCell : UITableViewCell

- (void)setupCellContentsWithPdf:(PdfMetadata *) pdfMetadata;

@end

NS_ASSUME_NONNULL_END
