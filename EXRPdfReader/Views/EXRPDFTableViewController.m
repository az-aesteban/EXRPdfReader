//
//  EXRPDFTableViewController.m
//  EXRPdfReader
//
//  Created by Arnold Joseph Caesar Esteban on 12/11/20.
//  Copyright © 2020 Arnold Joseph Caesar Esteban. All rights reserved.
//

#import "EXRPDFTableViewController.h"
#import "EXRPDFContentViewController.h"
#import "EXRPDFMetadata.h"
#import "EXRPDFMetadataXMLParserDelegate.h"
#import "EXRPDFTableViewCell.h"
#import "EXRPDFRootViewController.h"

static NSString *const kCellIdentifier = @"pdfTableViewCell";

@interface EXRPDFTableViewController ()

@property (strong, nonatomic) NSArray<EXRPDFMetadata *> *pdfs;

@end

@implementation EXRPDFTableViewController

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
    if (indexPath.item >= self.pdfs.count) {
        NSAssert(NO, @"EXRPDFTableViewController: No pdf for selected index path %li", indexPath.item);
    }
    EXRPDFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"EXRPDFTableViewCell"
                                              bundle:[NSBundle mainBundle]]
        forCellReuseIdentifier:kCellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    }
    EXRPDFMetadata *pdfMetadata = [self.pdfs objectAtIndex:indexPath.item];
    [cell setupCellContentsWithName:pdfMetadata.filename
                    fileDescription:pdfMetadata.fileDescription];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item >= self.pdfs.count) {
        NSAssert(NO, @"EXRPDFTableViewController: No pdf for selected index path %li", indexPath.item);
    }
    EXRPDFMetadata *selectedPDF = [self.pdfs objectAtIndex:indexPath.item];
    if (![selectedPDF fileExists]) {
        NSLog(@"EXRPDFTableViewController: Pdf File selected for viewing not found");
        [self promptErrorWithMessage:@"File not found"];
        return;
    }
    NSLog(@"EXRPDFTableViewController: Selected PDF File %@", selectedPDF.pdfID);
    EXRPDFRootViewController *pdfRootViewController = [[EXRPDFRootViewController alloc] initWithFilePath:selectedPDF.filePath];
    pdfRootViewController.title = selectedPDF.filename;
    [self.navigationController pushViewController:pdfRootViewController
                                         animated:YES];
}

#pragma mark - Data initialization Methods

- (void)setupAvailablePdfs {
    NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"PdfList.xml"
                                                        ofType:nil];
    NSData *xmlData = [NSData dataWithContentsOfFile:xmlPath];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
    EXRPDFMetadataXMLParserDelegate *parserDelegate = [[EXRPDFMetadataXMLParserDelegate alloc] init];
    [parser setDelegate:parserDelegate];
    if (![parser parse]) {
        NSError *error = [parser parserError];
        NSAssert(NO, @"EXRPDFTableViewController: Error parsing pdf list xml %@", error);
        return;
    }
    NSMutableArray *availablePdfs = [[NSMutableArray alloc] initWithArray:parserDelegate.pdfMetadata];
    EXRPDFMetadata *dummyPdf = [[EXRPDFMetadata alloc] initFileWithName:@"PDF for Dummies"
                                                  fileDescription:@"Dummy. No PDF."
                                                         filePath:@""
                                                         sequence:availablePdfs.count + 1
                                                            pdfID:@"some-dummy-stuff"];
    [availablePdfs addObject:dummyPdf];
    self.pdfs = [availablePdfs sortedArrayUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"sequence"
                                                                                                                  ascending:YES]]];
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
