//
//  TTTViewController.m
//  TicTacToe
//
//  Created by Fidel Sosa on 9/26/13.
//  Copyright (c) 2013 Fidel Sosa. All rights reserved.
//

#import "TTTViewController.h"
#import "TTTBoard.h"
#import "TTTComputer.h"

@interface TTTViewController ()

@property (nonatomic, retain, readwrite) TTTBoard *board;
@property (nonatomic, retain, readwrite) NSMutableArray* buttons;
@property (nonatomic, assign, readwrite) BOOL gameInProgress;
@property (nonatomic, retain, readwrite) TTTComputer *computer;

@end

@implementation TTTViewController


#pragma mark - View Lifecycle
- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.board = [[TTTBoard alloc] init];
    self.board.delegate = self;
    
    self.buttons = [NSMutableArray arrayWithObjects:self.button0, self.button1, self.button2,
                    self.button3, self.button4, self.button5, self.button6, self.button7, self.button8, nil];
    
    self.computer = [[TTTComputer alloc] init];
    
}

#pragma mark - User Actions

- (IBAction) gridButtonPressed:(id)sender {
    NSInteger index = [sender tag];

    [self.board moveMarker:TTTBoardMarkerO toLocation:index];
    [self.board printGrid];
    
    [self.computer moveMarker:TTTBoardMarkerX onBoard:self.board];
    
    if ([self.board isGameComplete]) {
        NSLog(@"Game done");
    }
}

- (IBAction) resetButtonPressed:(id)sender {
    self.gameInProgress = !self.gameInProgress;
    
    if (self.gameInProgress) {
        [self.resetButton setTitle:@"Reset Game" forState:UIControlStateNormal];
        [self.computer moveMarker:TTTBoardMarkerX onBoard:self.board];
    } else {
        [self.resetButton setTitle:@"Start Game" forState:UIControlStateNormal];
        [self.board resetGrid];
    }
}

#pragma mark - TTTBoardDelegate Methods

- (void) didUpdateGridAtIndex:(NSInteger)index withMarker:(NSString*)marker {
    for (UIButton *button in self.buttons) {
        if ([button tag] == index) {
            [button setTitle:marker forState:UIControlStateNormal];
        }
    }
}

@end
