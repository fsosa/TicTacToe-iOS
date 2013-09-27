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

- (void) moveMarker:(TTTBoardMarker)marker onBoard:(TTTBoard *)board withCallBack:(TTTIntegerBlock)callback{
    
    board.searchMode = YES;
    NSInteger move = [self negamaxForMarker:marker withBoard:board depth:1 alpha:-10000 beta:10000];
    board.searchMode = NO;
    
    DispatchMainThread(callback, move);
}

#pragma mark - AI Methods

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



- (NSInteger) scoreBoard:(TTTBoard*)board asMarker:(TTTBoardMarker)marker {
    TTTBoardMarker winner = [board winner];
    TTTBoardMarker opponent = [board opponentForMarker:marker];
    
    if (winner == marker) {
        return 1;
    }
    
    if (winner == opponent) {
        return -1;
    }
    
    return 0;
}



@end
