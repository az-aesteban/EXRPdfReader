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
#import "EXRPdfMetadataXMLParserDelegate.h"
#import "PdfTableViewCell.h"
#import "PdfRootViewController.h"

static NSString *const kCellIdentifier = @"pdfTableViewCell";

@interface PdfTableViewController ()

@property (strong, nonatomic) NSArray<PdfMetadata *> *pdfs;

@end

@implementation PdfTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupCellHeight];
    [self setupAvailablePdfs];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.pdfs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PdfTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"PdfTableViewCell"
                                              bundle:[NSBundle mainBundle]]
        forCellReuseIdentifier:kCellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    }
    if (indexPath.item >= self.pdfs.count) {
        NSAssert(NO, @"PdfTableViewController: No pdf for selected index path %li", indexPath.item);
    } else {
        PdfMetadata *pdfMetadata = [self.pdfs objectAtIndex:indexPath.item];
        [cell setupCellContentsWithName:pdfMetadata.fileName
                        fileDescription:pdfMetadata.fileDescription];
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item >= self.pdfs.count) {
        NSAssert(NO, @"PdfTableViewController: No pdf for selected index path %li", indexPath.item);
    } else {
        PdfMetadata *selectedPdf = [self.pdfs objectAtIndex:indexPath.item];
        if (![selectedPdf fileExists]) {
            NSLog(@"PdfTableViewController: Pdf File selected for viewing not found");
            [self promptErrorWithMessage:@"File not found"];
        } else {
            NSLog(@"PdfTableViewController: Selected PDF File %@", selectedPdf.pdfId);
            PdfRootViewController *pdfRootViewController = [[PdfRootViewController alloc] initWithFilePath:selectedPdf.filePath];
            [self.navigationController pushViewController:pdfRootViewController
                                                 animated:YES];
        }
    }
}

#pragma mark - Data initialization Methods

- (void)setupAvailablePdfs {
    NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"PdfList.xml"
                                                        ofType:nil];
    NSData *xmlData = [NSData dataWithContentsOfFile:xmlPath];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
    EXRPdfMetadataXMLParserDelegate *parserDelegate = [[EXRPdfMetadataXMLParserDelegate alloc] init];
    [parser setDelegate:parserDelegate];
    if ([parser parse]) {
        NSMutableArray *availablePdfs = [[NSMutableArray alloc] initWithArray:parserDelegate.pdfMetaData];
        PdfMetadata *dummyPdf = [[PdfMetadata alloc] initFileWithName:@"PDF for Dummies"
                                                      fileDescription:@"Dummy. No PDF."
                                                             filePath:@""
                                                             sequence:availablePdfs.count + 1
                                                                pdfId:@"some-dummy-stuff"];
        [availablePdfs addObject:dummyPdf];
        self.pdfs = [availablePdfs sortedArrayUsingComparator:^NSComparisonResult(PdfMetadata *metaData, PdfMetadata *otherMetaData) {
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
        NSLog(@"PdfTableViewController: Error parsing pdf list xml %@", error);
    }
}

#pragma mark - User Interaction Methods

- (void)promptErrorWithMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert
                       animated:YES
                     completion:nil];
}

#pragma mark - Layout Helper Methods

- (void)setupCellHeight {
    self.tableView.estimatedRowHeight = 44.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

@end
