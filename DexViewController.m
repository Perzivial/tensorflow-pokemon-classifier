//
//  DexViewController.m
//  
//
//  Created by Luke Hoel on 2017-11-03.
//

#import "DexViewController.h"

@interface DexViewController ()

@end

@implementation DexViewController
NSDictionary *dict;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [_pokemon capitalizedString];
    if(dict == NULL){
        dict = [self SetDict];
//        NSLog([dict objectForKey:@"entry"]);
    }
    //NSLog([dict objectForKey:_pokemon]);
    UIView *subView = (UIView *) [self.view viewWithTag:6];
    NSString *concat = [_pokemon stringByAppendingString:@".png"];
    UIImageView *myImage = [[UIImageView alloc] initWithFrame:[subView bounds]];
    myImage.image = [UIImage imageNamed:concat];
    [subView addSubview:myImage];
   //adding in label
    //UIView *subView2 = (UIView *) [self.view viewWithTag:7];
    //UILabel *myLabel = [[UILabel alloc] initWithFrame:[subView2 bounds]];
    //myLabel.text = [dict objectForKey:_pokemon];
    //myLabel.textColor = [UIColor whiteColor];
    //[myLabel setFont:[UIFont fontWithName:@"Helvetica neue" size:20]];
    //[myLabel setTextAlignment:UITextAlignmentCenter];
    //[subView2 addSubview:myLabel];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
