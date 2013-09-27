//
//  TTTBoard.h
//  TicTacToe
//
//  Created by Fidel Sosa on 9/26/13.
//  Copyright (c) 2013 Fidel Sosa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTTBoard : NSObject

- (void) moveMarker:(NSInteger)marker toLocation:(NSInteger)location;
- (void) undoMoveAtLocation:(NSInteger)location;

- (NSString *) markerAtLocation:(NSInteger)location;
- (NSArray *) legalMoves;
- (BOOL) isGameComplete;

- (void) printGrid;

@end
