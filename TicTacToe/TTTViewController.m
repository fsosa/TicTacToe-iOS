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

@property (nonatomic, strong, readwrite) TTTBoard *board;
@property (nonatomic, strong, readwrite) NSMutableArray* buttons;
@property (nonatomic, strong, readwrite) TTTComputer *computer;
@property (nonatomic, assign, readwrite) BOOL gameStarted;

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
    
    BOOL playerDidMove = [self.board moveMarker:TTTBoardMarkerO toLocation:index];
    
    if (!playerDidMove) {
        return;
    }
    
    [self.computer moveMarker:TTTBoardMarkerX onBoard:self.board];
    
    if ([self.board isGameComplete]) {
        TTTBoardMarker winningMarker = self.board.winner;
        NSString *winner = [self.board stringForMarker:winningMarker];
        
        NSString *titleText;
        if ([winner isEqualToString:@""]) {
            titleText = @"Draw";
        } else {
            titleText = [NSString stringWithFormat:@"%@ wins", winner];
        }
        
        [self.titleLabel setText:titleText];
        [self setButtonsEnabled:NO];
    }
}

- (IBAction) resetButtonPressed:(id)sender {
    
    if (!self.gameStarted) {
        self.gameStarted = YES;
        [self.resetButton setTitle:@"Reset Game" forState:UIControlStateNormal];
    }
    
    
    [self.titleLabel setText:@"Tic Tac Toe"];
    [self.board resetGrid];
    [self setButtonsEnabled:YES];
    [self.computer moveMarker:TTTBoardMarkerX onBoard:self.board];
}

#pragma mark - TTTBoardDelegate Methods

- (void) didUpdateGridAtIndex:(NSInteger)index withMarker:(NSString*)marker {
    for (UIButton *button in self.buttons) {
        if ([button tag] == index) {
            [button setTitle:marker forState:UIControlStateNormal];
        }
    }
}

#pragma mark - Helper Methods

- (void) setButtonsEnabled:(BOOL)enabled {
    for (UIButton *button in self.buttons) {
        [button setEnabled:enabled];
    }
}

@end
