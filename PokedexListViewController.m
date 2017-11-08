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
    NSDictionary *types;
//    NSString *entryPokemon;
}


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
    
    if(_index < 147){
    [_table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_index inSection:0]  atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }else{
        [_table setContentOffset:CGPointMake(0, 1000000)];
    }
   types = @{
        @"Bug": @"152 172 26",
        @"Dragon": @"91 16 246",
        @"Ice": @"136 209 206",
        @"Fighting": @"176 29 31",
        @"Fire": @"234 107 38",
        @"Flying": @"151 119 236",
        @"Grass": @"103 192 63",
        @"Ghost": @"92 67 134",
        @"Ground": @"216 180 86",
        @"Electric": @"245 199 39",
        @"Normal": @"152 153 101",
        @"Poison": @"140 40 142",
        @"Psychic": @"244 61 117",
        @"Rock": @"169 145 44",
        @"Water": @"86 121 236",
        };
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

- (NSDictionary *)getJson:(NSString *)name{
    NSString *path = [[NSBundle mainBundle] pathForResource:[name lowercaseString] ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (UIColor *)darkerColorForColor:(UIColor *)c
{
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.05, 0.0)
                               green:MAX(g - 0.05, 0.0)
                                blue:MAX(b - 0.05, 0.0)
                               alpha:a];
    return nil;
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
    
//    if(indexPath.row % 2 == 1)
//        [cell setBackgroundColor:light];
//    else
//        [cell setBackgroundColor:dark];
    
    NSDictionary *dict = [self getJson:pokemon[indexPath.row]];
    
    NSString *type = [[dict objectForKey:@"type"] componentsSeparatedByString:@" "][0];
    
    NSArray *arr = [[types objectForKey:type] componentsSeparatedByString:@" "];
    
    UIColor *clr = [UIColor colorWithRed:[arr[0] floatValue]/255.0f
                                   green:[arr[1] floatValue]/255.0f
                                    blue:[arr[2] floatValue]/255.0f
                                   alpha:1.0f];
    if(indexPath.row % 2 == 0){
        [cell setBackgroundColor:clr];
    }
    else{
        [cell setBackgroundColor:[self darkerColorForColor:clr]];
    }
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
