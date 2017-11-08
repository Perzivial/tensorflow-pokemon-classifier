//
//  DexViewController.m
//  
//
//  Created by Luke Hoel on 2017-11-03.
//

#import "DexViewController.h"
#import "PokedexListViewController.h"
@interface DexViewController ()
    
@end

@implementation DexViewController
NSDictionary *dict;
//here i'm adding all the content based upon the current pokemon
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setEntry];
}

-(void) setEntry{
    self.navigationItem.title = [_pokemon capitalizedString];
    
    dict = [self SetDict];
    
    //NSLog([dict objectForKey:_pokemon]);
    UIView *subView = (UIView *) [self.view viewWithTag:8];
    [[subView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSString *concat = [_pokemon stringByAppendingString:@".png"];
    UIImageView *myImage = [[UIImageView alloc] initWithFrame:[subView bounds]];
    myImage.image = [UIImage imageNamed:concat];
    [subView addSubview:myImage];
    
    UIView *nameView = (UIView *) [self.view viewWithTag:1];
     [[nameView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:nameView.bounds];
    NSString *name = [@"#" stringByAppendingString:[[dict objectForKey:@"id"] stringByAppendingString:@" "]];
    name = [name stringByAppendingString:[_pokemon capitalizedString]];
    nameLabel.text = name;
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
    [nameView addSubview:nameLabel];
    
    UIColor *blue = [UIColor colorWithRed:17.0f/255.0f
                                    green:71.0f/255.0f
                                     blue:123.0f/255.0f
                                    alpha:1.0f];
    
    UIView *speciesView = (UIView *) [self.view viewWithTag:2];
     [[speciesView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UILabel *speciesLabel = [[UILabel alloc]initWithFrame:speciesView.bounds];
    speciesLabel.text = [dict objectForKey:@"species"];
    speciesLabel.textAlignment = NSTextAlignmentCenter;
    speciesLabel.textColor = blue;
    speciesLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
    [speciesView addSubview:speciesLabel];
    
    UIView *typeView = (UIView *) [self.view viewWithTag:3];
     [[typeView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UILabel *typeLabel = [[UILabel alloc]initWithFrame:typeView.bounds];
    NSString *type = [[dict objectForKey:@"type"] stringByAppendingString:@"Type"];
    typeLabel.text = type;
    typeLabel.textAlignment = NSTextAlignmentCenter;
    typeLabel.textColor = blue;
    typeLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
    [typeView addSubview:typeLabel];
    
    UIView *entryView = (UIView *) [self.view viewWithTag:4];
    [[entryView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UITextView *entryLabel = [[UITextView alloc]initWithFrame:entryView.bounds];
    entryLabel.text = [dict objectForKey:@"entry"];
    entryLabel.textAlignment = NSTextAlignmentCenter;
    entryLabel.textColor = [UIColor whiteColor];
    entryLabel.backgroundColor = [UIColor clearColor];
    entryLabel.userInteractionEnabled = false;
    entryLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
    [entryView addSubview:entryLabel];
    
    UIColor *evoColor = [UIColor colorWithRed:35.0f/255.0f
                                    green:149.0f/255.0f
                                     blue:210.0f/255.0f
                                    alpha:1.0f];
    
    NSArray *arr = [[dict objectForKey:@"evolutions"] componentsSeparatedByString: @" "];
    for(int i = 0; i < 3; i++){
        NSInteger num = 10 + i;
        UIView *evoView = (UIView *) [self.view viewWithTag:(num)];
        [[evoView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        evoView.backgroundColor = [UIColor clearColor];
    }
    for(int i = 0; i < arr.count; i++){
        NSInteger num = 10 + i;
        UIView *evoView = (UIView *) [self.view viewWithTag:(num)];
        
           //
          [[evoView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
        NSString *imgname = [[arr[i] lowercaseString] stringByAppendingString:@"small.png"];
        CGRect bounds = [evoView bounds];
        bounds.origin.x+=bounds.size.width/12;
        bounds.origin.y+=bounds.size.width/12;
        bounds.size.width-=bounds.size.width/6;
        bounds.size.height-=bounds.size.height/6;
        UIImageView *currentEvo = [[UIImageView alloc] initWithFrame:bounds];

        UIImage *img = [UIImage imageNamed:imgname];
        if(!img){
            
        }else{
            evoView.backgroundColor = evoColor;
            currentEvo.image = img;
        }
        [evoView addSubview:currentEvo];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (NSDictionary *)SetDict{
//    NSArray *keys = [NSArray arrayWithObjects:@"bulbasaur", nil];
//    NSArray *objects = [NSArray arrayWithObjects:@"Seed Pokemon", nil];
//
//
//    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:objects
//                                                           forKeys:keys];
//    NSString *firstString = @"pokemon/";
//    NSString *secondString = _pokemon;
//    NSString *concatinatedString = [firstString stringByAppendingString:secondString];
    NSString *path = [[NSBundle mainBundle] pathForResource:_pokemon ofType:@"json"];
    //NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PokedexListViewController *dest = (PokedexListViewController *)segue.destinationViewController;
    int index = [[dict objectForKey:@"id"] intValue];
    dest.index = index-1;
}


@end
