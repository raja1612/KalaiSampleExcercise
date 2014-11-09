//
//  TableCellDisplay.m
//
//  Created by Kalai Raja on 8/10/2014.
//  Copyright (c) 2014 Kalai Raja. All rights reserved.
//
//  TableCellDisplay.m
//  iOSSampleExcercise
//
//  Created by Kalai Raja on 08/11/2014.
//  Copyright (c) 2014 Kalai Raja. All rights reserved.
//



#import "TableCellDisplay.h"

@implementation TableCellDisplay

@synthesize headerTextLabel,bodyTextLabel,cellImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier 
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) 
    {
        // Defining the font and UI for every element in the table cell
        
		headerTextLabel = [[UILabel alloc] init];
        [headerTextLabel setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
        headerTextLabel.textColor = [UIColor blueColor];
        
        bodyTextLabel = [[UILabel alloc] init];
        [bodyTextLabel setFont:[UIFont fontWithName:@"Helvetica" size:10.0]];
        bodyTextLabel.textColor = [UIColor blackColor];
        bodyTextLabel.numberOfLines=0;
        bodyTextLabel.lineBreakMode=NSLineBreakByWordWrapping;
        
        cellImage=[[UIImageView alloc] init];
       
		[self.contentView addSubview:headerTextLabel];
		[self.contentView addSubview:bodyTextLabel];
        [self.contentView addSubview:cellImage];
		
	}
    
    return self;
}

-(void)layoutSubviews 
{
	[super layoutSubviews];
    
    // Defining the layout for the elements in the cell
    
    headerTextLabel.frame = CGRectMake(self.contentView.bounds.origin.x + 10, self.contentView.bounds.origin.y -10, 200,40);
	
    bodyTextLabel.frame = CGRectMake(self.contentView.bounds.origin.x + 10, self.contentView.bounds.origin.y, 220, 80);

	cellImage.frame = CGRectMake(260, self.contentView.bounds.origin.y+20, 50, 50);

}

- (void)dealloc 
{    
    [headerTextLabel release];
    headerTextLabel = nil;
    [bodyTextLabel release];
    bodyTextLabel = nil;
    [cellImage release];
    cellImage=nil;
    
    [super dealloc];
}

@end
