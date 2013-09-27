//
//  TTTViewController.m
//  TicTacToe
//
//  Created by Fidel Sosa on 9/26/13.
//  Copyright (c) 2013 Fidel Sosa. All rights reserved.
//

#import "TTTViewController.h"
#import "TTTBoard.h"

@interface TTTViewController ()

@property (nonatomic, retain, readwrite) TTTBoard *board;
@property (nonatomic, weak, readwrite) NSMutableArray *buttons;

@end

@implementation TTTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.board = [[TTTBoard alloc] init];
    self.buttons = [NSMutableArray arrayWithObjects:self.button0, self.button1, self.button2,
                    self.button3, self.button4, self.button5, self.button6, self.button7, self.button8, nil];
}

- (IBAction)gridButtonPressed:(id)sender {
    // Find index of sender in button array
    NSInteger index =    [self.buttons indexOfObjectIdenticalTo:sender];
    NSLog(@"%i", index);
    
    UIButton *button = (UIButton*)sender;

    
    [self.board moveMarker:-1 toLocation:index];
    [self.board printGrid];
    
    NSString *marker = [self.board markerAtLocation:index];
    [((UIButton*)sender) setTitle:marker forState:UIControlStateNormal];
}

@end
