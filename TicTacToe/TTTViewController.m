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
@property (nonatomic, retain, readwrite) NSMutableArray* buttons;

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
    NSInteger index = [sender tag];

    [self.board moveMarker:-1 toLocation:index];
    [self.board printGrid];
    
    NSString *marker = [self.board markerAtLocation:index];
    [((UIButton*)sender) setTitle:marker forState:UIControlStateNormal];
    
    if ([self.board isGameComplete]) {
        NSLog(@"Game done");
    }
}

- (IBAction)resetButtonPressed:(id)sender {
    [self.board resetGrid];
    
    for (UIButton *button in self.buttons) {
        [button setTitle:@"" forState:UIControlStateNormal];
    }
}

@end
