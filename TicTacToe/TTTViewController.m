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
    
    [self performComputerMoveWithFeedback:NO];
}

- (IBAction) resetButtonPressed:(id)sender {
    
    if (!self.gameStarted) {
        self.gameStarted = YES;
        [self.resetButton setTitle:@"Reset Game" forState:UIControlStateNormal];
    }
    
    
    [self.titleLabel setText:@"Tic Tac Toe"];
    [self.board resetGrid];
    
    // Calculating the first move is the most expensive so the feedback option displays "Computer Thinking" text to the user
    [self performComputerMoveWithFeedback:YES];
}

#pragma mark - AI / Game Completion

- (void) performComputerMoveWithFeedback:(BOOL)feedback {
    
    if (feedback) {
        [self.titleLabel setText:@"Computer Thinking..."];
    }

    TTTVoidBlock calculateComputerMove = ^{
        
        // This callback update UI elements on the main thread and checks the game board after the computer's move
        TTTIntegerBlock performMove = ^(NSInteger move){
            [self.board moveMarker:TTTBoardMarkerX toLocation:move];
            [self.titleLabel setText:@"Tic Tac Toe"];
            [self setButtonsEnabled:YES];
            [self isGameComplete];
        };
        
        [self.computer moveMarker:TTTBoardMarkerX onBoard:self.board withCallBack:performMove];
    };
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, calculateComputerMove);
}

- (void) isGameComplete {
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

#pragma mark - TTTBoardDelegate Methods

- (void) didUpdateGridAtIndex:(NSInteger)index withMarker:(NSString*)marker {
    UIButton *button = [self.buttons objectAtIndex:index];
    [button setTitle:marker forState:UIControlStateNormal];
}

#pragma mark - Helper Methods

- (void) setButtonsEnabled:(BOOL)enabled {
    for (UIButton *button in self.buttons) {
        [button setEnabled:enabled];
    }
}

@end
