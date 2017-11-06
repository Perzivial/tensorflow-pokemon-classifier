//
//  PokedexListViewController.m
//  dex
//
//  Created by Luke Hoel on 2017-11-06.
//  Copyright © 2017 Google. All rights reserved.
//

#import "PokedexListViewController.h"
#import "DexViewController.h"

@interface PokedexListViewController () <UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *pokemon;
    UIColor *light;
    UIColor *dark;
//    NSString *entryPokemon;
}
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation PokedexListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString* path = [[NSBundle mainBundle] pathForResource:@"entries" ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    NSArray *arr = [content componentsSeparatedByString: @"\n"];

    light = [UIColor colorWithRed:74.0f/255.0f
                                    green:170.0f/255.0f
                                     blue:237.0f/255.0f
                                    alpha:1.0f];
    dark = [UIColor colorWithRed:67.0f/255.0f
                                    green:155.0f/255.0f
                                     blue:218.0f/255.0f
                                    alpha:1.0f];

        pokemon = [NSMutableArray arrayWithArray:arr];
    DexViewController *dex = (DexViewController *)[self backViewController];
    
//    [_table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_index inSection:0]  atScrollPosition:UITableViewScrollPositionMiddle animated:NO];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (UIViewController *)backViewController
{
    NSInteger numberOfViewControllers = self.navigationController.viewControllers.count;
    
    if (numberOfViewControllers < 2)
        return nil;
    else
        return [self.navigationController.viewControllers objectAtIndex:numberOfViewControllers - 2];
}


#pragma mark - TableView Methods
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return pokemon.count;

}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellId = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    NSString *imgname = [[pokemon[indexPath.row] lowercaseString] stringByAppendingString:@"small.png"];
    cell.imageView.image = [UIImage imageNamed:imgname];
    cell.textLabel.text = pokemon[indexPath.row];
    NSString *text = @"#";
    cell.detailTextLabel.text = [text stringByAppendingString:[NSString stringWithFormat:@"%03d", indexPath.row+1]];
    
    if(indexPath.row % 2 == 1)
        [cell setBackgroundColor:light];
    else
        [cell setBackgroundColor:dark];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    DexViewController *dex = (DexViewController *)[self backViewController];
    NSString *name = [pokemon[indexPath.row] lowercaseString];
    dex.pokemon = name;
    [dex setEntry];
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
