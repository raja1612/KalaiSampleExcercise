//
//  DetailViewController.h
//  KalaiSampleExcercise
//
//  Created by Thirumalai.Rajan on 10/11/2014.
//  Copyright (c) 2014 Kalai Raja. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

