//
//  TTTBoard.h
//  TicTacToe
//
//  Created by Fidel Sosa on 9/26/13.
//  Copyright (c) 2013 Fidel Sosa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum TTTBoardMarker : NSUInteger {
    TTTBoardMarkerO = -1,
    TTTBoardMarkerEmpty = 0,
    TTTBoardMarkerX = 1,
} TTTBoardMarker;

@protocol TTTBoardDelegate <NSObject>

- (void) didUpdateGridAtIndex:(NSInteger)index withMarker:(NSString*)marker;

@end


@interface TTTBoard : NSObject

@property (nonatomic, weak, readwrite) id<TTTBoardDelegate> delegate;
@property (nonatomic, assign, readwrite) BOOL searchMode; // Denotes if the board is being searched an algorithm

- (BOOL) moveMarker:(TTTBoardMarker)marker toLocation:(NSInteger)location; // Returns true if move made, false otherwise
- (void) undoMoveAtLocation:(NSInteger)location;

- (NSArray *) legalMoves;
- (BOOL) isGameComplete;
- (TTTBoardMarker) winner;

- (NSString *) stringForMarkerAtLocation:(NSInteger)location;
- (NSString *) stringForMarker:(TTTBoardMarker)marker;
- (TTTBoardMarker) opponentForMarker:(TTTBoardMarker)marker;
- (void) resetGrid;
- (void) printGrid;

@end
