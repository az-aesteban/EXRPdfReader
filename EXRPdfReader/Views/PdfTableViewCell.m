//
//  PdfTableViewCell.m
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/11/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "PdfTableViewCell.h"

@interface PdfTableViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *fileNameLabel;

@property (strong, nonatomic) IBOutlet UILabel *fileDescriptionLabel;

@end

@implementation PdfTableViewCell

- (void)setupCellContentsWithName:(NSString *)fileName
                  fileDescription:(NSString *)fileDescription {
    self.fileNameLabel.text = fileName;
    self.fileDescriptionLabel.text = fileDescription;
}

@end
