//
//  PdfTableViewController.m
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 12/11/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "PdfTableViewController.h"
#import "PdfContentViewController.h"
#import "PdfMetadata.h"
#import "PdfMetadataXMLParserDelegate.h"
#import "PdfTableViewCell.h"
#import "PdfRootViewController.h"

static NSString *kCellIdentifier = @"pdfTableViewCell";

@implementation PdfTableViewController {
    NSArray<PdfMetadata *> *_pdfs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCellHeight];
    [self setupAvailablePdfs];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _pdfs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PdfTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"PdfTableViewCell"
                                              bundle:[NSBundle mainBundle]]
        forCellReuseIdentifier:kCellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    }
    PdfMetadata *pdfMeta = [_pdfs objectAtIndex:indexPath.item];
    [cell setupCellContentsWithPdf:pdfMeta];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    PdfMetadata *selectedPdf = [_pdfs objectAtIndex:indexPath.item];

    if (![selectedPdf fileExists]) {
        NSLog(@"PdfTableViewController: Pdf File selected for viewing not found");
        [self promptErrorWithMessage:@"File not found"];
    } else {
        PdfRootViewController *pdfRootViewController = [[PdfRootViewController alloc] init];
        pdfRootViewController.metadata = selectedPdf;
        [self.navigationController pushViewController:pdfRootViewController
                                             animated:YES];
    }
}

#pragma mark - Data initialization Methods

- (void)setupAvailablePdfs {
    NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"PdfList.xml"
                                                        ofType:nil];

    NSData *xmlData = [NSData dataWithContentsOfFile:xmlPath];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];

    PdfMetadataXMLParserDelegate *parserDelegate = [[PdfMetadataXMLParserDelegate alloc] init];
    [parser setDelegate:parserDelegate];

    if ([parser parse]) {
        NSMutableArray *availablePdfs = [[NSMutableArray alloc] initWithArray:parserDelegate.pdfMetaData];

        PdfMetadata *dummyPdf = [PdfMetadata fileWithName:@"PDF for Dummies"
                                          withDescription:@"Dummy. No PDF."
                                             withFilePath:@""
                                             withSequence:availablePdfs.count + 1
                                                    andId:@"some-dummy-stuff"];
        [availablePdfs addObject:dummyPdf];

        _pdfs = [availablePdfs sortedArrayUsingComparator:^NSComparisonResult(PdfMetadata *metaData, PdfMetadata *otherMetaData) {
            NSComparisonResult comparisonResult = NSOrderedSame;
            if (metaData.sequence < otherMetaData.sequence) {
                comparisonResult = NSOrderedAscending;
            } else if (metaData.sequence > otherMetaData.sequence) {
                comparisonResult = NSOrderedDescending;
            }
            return comparisonResult;
        }];
    } else {
        NSError *error = [parser parserError];
        if (error) {
            NSLog(@"PdfTableViewController: Error %@", error);
        }
    }
}

#pragma mark - User Interaction Methods

- (void)promptErrorWithMessage:(NSString *)aMessage {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:aMessage
                                                            preferredStyle:UIAlertControllerStyleAlert];
 
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert
                       animated:YES
                     completion:nil];
}

#pragma mark - Layout Helper Methods

- (void)setupCellHeight {
    self.tableView.estimatedRowHeight = 44.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

@end
