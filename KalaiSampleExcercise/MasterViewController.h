//
//  MasterViewController.h
//  iOSSampleExcercise
//
//  Created by Kalai Raja on 08/11/2014.
//  Copyright (c) 2014 Kalai Raja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableCellDisplay.h"

@interface MasterViewController : UITableViewController

@property (assign,nonatomic) UIImage *thumnailImage;
@property (assign,nonatomic) NSString *headerText;
@property (assign,nonatomic) NSString *bodyText;
@property (strong,atomic) NSString *imageURLString;
@property (strong,atomic) NSDictionary *jsonParsedObject;



@end

