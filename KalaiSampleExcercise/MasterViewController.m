//
//  MasterViewController.m
//  iOSSampleExcercise
//
//  Created by Kalai Raja on 08/11/2014.
//  Copyright (c) 2014 Kalai Raja. All rights reserved.
//

#import "MasterViewController.h"

#define JsonURL @"https://dl.dropboxusercontent.com/u/746330/facts.json"
#define Jtitle @"title"
#define Jdescription @"description"
#define JimageRef @"imageHref"
#define Jnull @""
#define Jrow @"rows"
#define CellIdentifier @"SampleCellIdentifier"
#define PlaceholderImage @"Placeholder.png"


@interface MasterViewController ()


@property NSMutableArray *objects;
@end

@implementation MasterViewController

@synthesize headerText,bodyText,thumnailImage,imageURLString,jsonParsedObject;


- (void)viewDidLoad {
    [super viewDidLoad];
    //Creating the refresh button to render the cell for every refresh
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = refreshButton;
    
    // Json parser to connect to the URL and retrieve the data
    NSError *jsonParsingError = nil;
    NSString *jsonParsedString = [NSString stringWithContentsOfURL:[NSURL URLWithString:JsonURL] encoding:NSISOLatin1StringEncoding error:&jsonParsingError];
    
    NSData *jsonParsedData = [jsonParsedString dataUsingEncoding:NSUTF8StringEncoding];
    
    self.jsonParsedObject = [NSJSONSerialization JSONObjectWithData:jsonParsedData options:kNilOptions error:&jsonParsingError];
    // Adding the title to the screen navigator from the Json
    NSString *titleElements=[self.jsonParsedObject objectForKey:Jtitle];
    self.navigationItem.title=titleElements;
    // Adding the first row in the table during the first load
    [self insertNewObject:nil];
    
}

-(void) viewWillAppear {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    
    // Initialising the Objects fpr the Json data
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    
    // Extrating the data from the json based on the key value pair
    NSArray *rowElements=[self.jsonParsedObject objectForKey:Jrow];
    long rowCount=[self tableView:self.tableView numberOfRowsInSection:0];
    NSDictionary *rowElementsDescription=[rowElements objectAtIndex:rowCount];
    
    self.headerText=[rowElementsDescription objectForKey:Jtitle];
    if([self.headerText isEqual:[NSNull null]])self.headerText=Jnull;
    self.bodyText=[rowElementsDescription objectForKey:Jdescription];
    if([self.bodyText isEqual:[NSNull null]])self.bodyText=@" ";
    self.imageURLString=[rowElementsDescription objectForKey:JimageRef];
    if([self.imageURLString isEqual:[NSNull null]])self.imageURLString=Jnull;
    
    // Adding the image url to the objects
    [self.objects insertObject:imageURLString atIndex:0];
    
    //Adding the new row to the table with the new Json data
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

    // Disabling the Refresh buttin after the last Json data parsed
    if (rowCount > 13){
        self.navigationItem.rightBarButtonItem.enabled=false;
    }
    
    
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
 // Creating the cell for every row and rendering the content
    
    static NSString *simpleTableIdentifier=CellIdentifier;
    TableCellDisplay *cell=[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[[TableCellDisplay alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier] autorelease];
       
    }
    // Calculating the individual row height based on the content
    self.tableView.rowHeight=[self rowHeightCalculation];
    cell.headerTextLabel.text=self.headerText;
    cell.bodyTextLabel.text=self.bodyText;
    NSDate *object = self.objects[indexPath.row];
    self.navigationItem.rightBarButtonItem.enabled=false;
    // Add a place holder image untill the original image is downloaded from the image URL
    self.thumnailImage=[UIImage imageNamed:PlaceholderImage];
    [cell.cellImage setImage:self.thumnailImage];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if( [[object description] length] >0)
        {
            // Download the image from the URL and add the same in the cell
            NSURL *imageURL = [NSURL URLWithString:[object description]];
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            if(imageData){
                self.thumnailImage = [UIImage imageWithData:imageData];
                [cell.cellImage setImage:self.thumnailImage];
                self.navigationItem.rightBarButtonItem.enabled=true;
            }
            else{
                self.thumnailImage=[UIImage imageNamed:PlaceholderImage];
                [cell.cellImage setImage:self.thumnailImage];
                self.navigationItem.rightBarButtonItem.enabled=true;
            }
        }
        else{
            self.thumnailImage=nil;
            [cell.cellImage setImage:self.thumnailImage];
            self.navigationItem.rightBarButtonItem.enabled=true;
        }
        
    });
   
    return cell;
    
}

// Calculate the height of every individual row based on the text available for the and the availability of the image


-(CGFloat)rowHeightCalculation
{
    NSStringDrawingContext *ctx = [NSStringDrawingContext new];
    
    NSAttributedString *aString = [[NSAttributedString alloc] initWithString:bodyText];
    UITextView *calculationView = [[UITextView alloc] init];
    [calculationView setAttributedText:aString];
    CGRect textRect = [calculationView.text boundingRectWithSize:self.view.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:calculationView.font} context:ctx];
    
    if(textRect.size.height+30 <80 && ![self.imageURLString isEqualToString:Jnull])textRect.size.height=50;
    return textRect.size.height+30;
    
}


-(void)dealloc
{
    [thumnailImage release];
    thumnailImage=nil;
    [headerText release];
    headerText=nil;
    [bodyText release];
    bodyText=nil;
    [super dealloc];
}

@end
