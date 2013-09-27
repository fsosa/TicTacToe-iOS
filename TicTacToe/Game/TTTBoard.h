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

- (void) moveMarker:(TTTBoardMarker)marker toLocation:(NSInteger)location;
- (void) undoMoveAtLocation:(NSInteger)location;

- (NSArray *) legalMoves;
- (BOOL) isGameComplete;
- (TTTBoardMarker) winner;

- (NSString *) markerAtLocation:(NSInteger)location;
- (TTTBoardMarker) opponentForMarker:(TTTBoardMarker)marker;
- (void) resetGrid;
- (void) printGrid;

@end
