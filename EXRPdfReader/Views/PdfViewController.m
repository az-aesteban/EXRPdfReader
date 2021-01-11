//
//  PdfViewController.m
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 1/7/21.
//  Copyright © 2021 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "PdfViewController.h"
#import "PdfContentView.h"

@interface PdfViewController ()

@property (strong, nonatomic) IBOutlet PdfContentView *pdfContentView;

@end

@implementation PdfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.pdfMetadata.fileName;
    self.pdfContentView.pdfMetadata = self.pdfMetadata;
}

@end
