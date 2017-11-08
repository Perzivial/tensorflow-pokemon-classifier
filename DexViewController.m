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
- (IBAction)goback:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) setEntry{
    
    NSDictionary *types = @{
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
    
       dict = [self SetDict];
    
    NSString *type2 = [[dict objectForKey:@"type"] componentsSeparatedByString:@" "][0];
    
    NSArray *arr2 = [[types objectForKey:type2] componentsSeparatedByString:@" "];
    
    UIColor *typeColor = [UIColor colorWithRed:[arr2[0] floatValue]/255.0f
                                   green:[arr2[1] floatValue]/255.0f
                                    blue:[arr2[2] floatValue]/255.0f
                                   alpha:1.0f];
    
     UIView *bgView = (UIView *) [self.view viewWithTag:20];
    bgView.backgroundColor = typeColor;
    UIView *circleView = (UIView *) [self.view viewWithTag:21];
    circleView.backgroundColor = [self lighterColorForColor:typeColor];
    UIView *entryDescView = (UIView *) [self.view viewWithTag:22];
    entryDescView.backgroundColor = [self lighterColorForColor:typeColor];
    
    
    self.navigationItem.title = [_pokemon capitalizedString];
    

    
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
    
    UIView *speciesView = (UIView *) [self.view viewWithTag:2];
     [[speciesView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UILabel *speciesLabel = [[UILabel alloc]initWithFrame:speciesView.bounds];
    speciesLabel.text = [dict objectForKey:@"species"];
    speciesLabel.textAlignment = NSTextAlignmentCenter;
    speciesLabel.textColor = [self darkerColorForColor:typeColor];
    speciesLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
    [speciesView addSubview:speciesLabel];
    
    UIView *typeView = (UIView *) [self.view viewWithTag:3];
     [[typeView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UILabel *typeLabel = [[UILabel alloc]initWithFrame:typeView.bounds];
    NSString *type = [[dict objectForKey:@"type"] stringByAppendingString:@"Type"];
    typeLabel.text = type;
    typeLabel.textAlignment = NSTextAlignmentCenter;
    typeLabel.textColor = [self darkerColorForColor:typeColor];
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
            evoView.backgroundColor = typeColor;
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
    NSString *path = [[NSBundle mainBundle] pathForResource:_pokemon ofType:@"json"];
    //NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}
- (NSDictionary *)getJson:(NSString *)name{
    @try{
        NSString *path = [[NSBundle mainBundle] pathForResource:[name lowercaseString] ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    }@catch (NSException *exception) {
        NSLog(name);
        return [UIColor whiteColor];
    }
}

- (UIColor *)lighterColorForColor:(UIColor *)c
{
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MIN(r + 0.2, 1.0)
                               green:MIN(g + 0.2, 1.0)
                                blue:MIN(b + 0.2, 1.0)
                               alpha:.3];
    return nil;
}

- (UIColor *)darkerColorForColor:(UIColor *)c
{
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.2, 0.0)
                               green:MAX(g - 0.2, 0.0)
                                blue:MAX(b - 0.2, 0.0)
                               alpha:a];
    return nil;
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PokedexListViewController *dest = (PokedexListViewController *)segue.destinationViewController;
    int index = [[dict objectForKey:@"id"] intValue];
    dest.index = index-1;
}


@end
