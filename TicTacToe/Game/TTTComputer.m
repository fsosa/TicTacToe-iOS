//
//  TTTComputer.m
//  TicTacToe
//
//  Created by Fidel Sosa on 9/26/13.
//  Copyright (c) 2013 Fidel Sosa. All rights reserved.
//

#import "TTTComputer.h"

@implementation TTTComputer

#pragma mark - Player Actions

//
// Calculates the best move available to the computer using the Negamax algorithm.
// Takes a callback which is dispatched to the main thread with the best move as argument
//
- (void) moveMarker:(TTTBoardMarker)marker onBoard:(TTTBoard *)board withCallBack:(TTTIntegerBlock)callback{
    
    board.searchMode = YES;
    NSInteger move = [self negamaxForMarker:marker withBoard:board depth:1 alpha:-10000 beta:10000];
    board.searchMode = NO;
    
    DispatchMainThread(callback, move);
}

#pragma mark - AI Methods

//
// Calculates the best move using the Negamax algorith enhanced with alpha-beta pruning, recursively.
//
- (NSInteger) negamaxForMarker:(TTTBoardMarker)marker withBoard:(TTTBoard*)board depth:(NSInteger)depth alpha:(NSInteger)alpha beta:(NSInteger)beta {
    NSInteger bestMove = 0;
    NSInteger bestAlpha = -10000;
    TTTBoardMarker opponent = [board opponentForMarker:marker];
    
    if ([board isGameComplete]) {
        return [self scoreBoard:board asMarker:marker];
    }
    
    NSArray *legalMoves = [board legalMoves];
    
    // Loop through the available moves and recursively run negamax to find the move with the best score i.e. alpha
    for (int i = 0; i < [legalMoves count]; i++) {
        NSInteger move = [legalMoves[i] integerValue];
        [board moveMarker:marker toLocation:move];
        
        NSInteger score = -[self negamaxForMarker:opponent withBoard:board depth:depth + 1 alpha:-beta beta:-alpha];
        
        [board undoMoveAtLocation:move];
        
        // Found better score, update alpha
        if (score > alpha) {
            alpha = score;
        }
        
        // Prune the branch since the branch is not favorable to the player
        if (alpha >= beta) {
            break;
        }
        
        // Save the best seen move and alpha if we're at the original root node
        if (depth == 1 && alpha > bestAlpha) {
            bestAlpha = alpha;
            bestMove = move;
        }
    }
    
    // Return the move if we're at the root node, otherwise we want to return the alpha for the recursive call
    if (depth == 1) {
        return bestMove;
    } else {
        return alpha;
    }
}


//
// Scores a given board based on the current marker.
//
- (NSInteger) scoreBoard:(TTTBoard*)board asMarker:(TTTBoardMarker)marker {
    TTTBoardMarker winner = [board winner];
    TTTBoardMarker opponent = [board opponentForMarker:marker];
    
    // Ideal outcome for the player, score highly
    if (winner == marker) {
        return 1;
    }
    
    // Losing outcome for the player, score poorly
    if (winner == opponent) {
        return -1;
    }
    
    // Otherwise, we have a draw
    return 0;
}



@end
