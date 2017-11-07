//
//  PokedexListViewController.h
//  dex
//
//  Created by Luke Hoel on 2017-11-06.
//  Copyright © 2017 Google. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PokedexListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *table;
@property int index;
@end
