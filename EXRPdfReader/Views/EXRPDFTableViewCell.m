//
//  EXRPDFTableViewCell.m
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/11/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "EXRPDFTableViewCell.h"

@interface EXRPDFTableViewCell ()

@property (strong, nonatomic) IBOutlet UILabel *filenameLabel;

@property (strong, nonatomic) IBOutlet UILabel *fileDescriptionLabel;

@end

@implementation EXRPDFTableViewCell

- (void)setupCellContentsWithName:(NSString *)filename
                  fileDescription:(NSString *)fileDescription {
    self.filenameLabel.text = filename;
    self.fileDescriptionLabel.text = fileDescription;
}

@end
