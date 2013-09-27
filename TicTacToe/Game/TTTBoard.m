//
//  TTTBoard.m
//  TicTacToe
//
//  Created by Fidel Sosa on 9/26/13.
//  Copyright (c) 2013 Fidel Sosa. All rights reserved.
//

#import "TTTBoard.h"

@interface TTTBoard ()

@property (nonatomic, retain, readwrite) NSMutableArray *grid;

@end

@implementation TTTBoard


#pragma mark - Lifecycle Methods

- (id) init {
    self = [super init];
    
    if (self) {
        // Initialize the grid representing our board
        [self resetGrid];
    }
    
    return self;
}

#pragma mark - Grid Operations

- (BOOL) moveMarker:(TTTBoardMarker)marker toLocation:(NSInteger)location {
    if ([self isValidMove:location]) {
        NSNumber *mark = [NSNumber numberWithInt:marker];
        [self.grid replaceObjectAtIndex:location withObject:mark];
        
        // Notify the delegate to perform any necessary updates (e.g. UI)
        NSString *markerString = [self stringForMarkerAtLocation:location];
        
        if (!self.searchMode) {
            [self.delegate didUpdateGridAtIndex:location withMarker:markerString];
        }
        
        return YES;
    }
    
    return NO;
}

- (void) undoMoveAtLocation:(NSInteger)location {
    if (location < 0 || location > 8) {
        return;
    }
    
    [self.grid replaceObjectAtIndex:location withObject:@0];
}

#pragma mark - Game Rules

- (NSArray *) legalMoves {
    NSMutableArray *legalMoves = [NSMutableArray array];
    for (int i = 0; i < [self.grid count]; i++) {
        NSInteger markerValue = [[self.grid objectAtIndex:i] integerValue];
        if (markerValue == 0) {
            [legalMoves addObject:[NSNumber numberWithInt:i]];
        }
    }
    
    return legalMoves;
}

- (BOOL) isValidMove:(NSInteger)location {
    if (location < 0 || location > 8) {
        return NO;
    }
    
    NSInteger marker = [[self.grid objectAtIndex:location] integerValue];
    
    if (marker == 0) {
        return YES;
    }
    
    return NO;
}

- (TTTBoardMarker) winner {
    NSInteger leftDiagonal = [self scoreForDiagonal:0];
    NSInteger rightDiagonal = [self scoreForDiagonal:2];
    
    if (leftDiagonal == 3 || rightDiagonal == 3) {
        return TTTBoardMarkerX;
    }
    
    if (leftDiagonal == -3 || rightDiagonal == -3) {
        return TTTBoardMarkerO;
    }
    
    
    for (int i = 0; i < 3; i++) {
        int rowScore = [self scoreForRow:i];
        int colScore = [self scoreForColumn:i];
        
        
        if (rowScore == 3 || colScore == 3) {
            return TTTBoardMarkerX;
        }
        
        if (rowScore == -3 || colScore == -3) {
            return TTTBoardMarkerO;
        }
    }
    
    return TTTBoardMarkerEmpty;
}

- (BOOL) isGameComplete {
    NSInteger movesLeft = [[self legalMoves] count];
    BOOL noRemainingMoves = movesLeft == 0;
    BOOL gameWon = [self winner] == TTTBoardMarkerX || [self winner] == TTTBoardMarkerO;
    
    return gameWon || noRemainingMoves;
}


#pragma mark - Helper Methods

- (NSString *) stringForMarkerAtLocation:(NSInteger)location {
    if (location < 0 || location > 8) {
        return @"";
    }
    
    NSInteger markerValue = [self.grid[location] integerValue];
    
    switch (markerValue) {
        case 0:
            return @"";
            break;
        case 1:
            return @"X";
            break;
        case -1:
            return @"O";
            break;
        default:
            return @"";
            break;
    }

}

- (NSInteger) scoreForRow:(NSInteger)row {
    if (row < 0 || row > 2) {
        return 0;
    }
    
    NSInteger rowScore = 0;
    NSInteger rowIndex = row * 3;
    
    for (int i = rowIndex; i < rowIndex + 3; i++) {
        NSInteger markerValue = [self.grid[i] integerValue];
        rowScore += markerValue;
    }
    
    return rowScore;
}

- (NSInteger) scoreForColumn:(NSInteger)column {
    if (column < 0 || column > 2) {
        return 0;
    }
    
    NSInteger columnScore = 0;
    
    for (int i = column; i < column + 7; i +=3) {
        NSInteger markerValue = [self.grid[i] integerValue];
        columnScore += markerValue;
    }
    
    return columnScore;
}

- (NSInteger) scoreForDiagonal:(NSInteger)topCornerIndex {
    if (topCornerIndex != 0 &&  topCornerIndex != 2) {
        return 0;
    }
    
    int increment = topCornerIndex == 0 ? 4 : 2;
    int upperBound = topCornerIndex + 2 * increment + 1;
    
    int diagonalScore = 0;
    for (int i = topCornerIndex; i < upperBound; i += increment) {
        diagonalScore += [self.grid[i] integerValue];
    }
    
    return diagonalScore;
}


- (void) resetGrid {
    self.grid = [NSMutableArray array];
    
    for (int i = 0; i < 9; i++) {
        [self.grid addObject:@0];
        
        if (!self.searchMode) {
            [self.delegate didUpdateGridAtIndex:i withMarker:@""];
        }
    }
    
    
}

- (void) printGrid {
    
    NSLog(@"");
    NSLog(@"%@ | %@ | %@", self.grid[0], self.grid[1], self.grid[2]);
    NSLog(@"----------");
    NSLog(@"%@ | %@ | %@", self.grid[3], self.grid[4], self.grid[5]);
    NSLog(@"----------");
    NSLog(@"%@ | %@ | %@", self.grid[6], self.grid[7], self.grid[8]);
    NSLog(@"");
}

- (TTTBoardMarker) opponentForMarker:(TTTBoardMarker)marker {
    switch (marker) {
        case TTTBoardMarkerO:
            return TTTBoardMarkerX;
            break;
        case TTTBoardMarkerX:
            return TTTBoardMarkerO;
            break;
        default:
            return TTTBoardMarkerEmpty;
            break;
    }
}

- (NSString *) stringForMarker:(TTTBoardMarker)marker {
    switch (marker) {
        case TTTBoardMarkerO:
            return @"O";
            break;
        case TTTBoardMarkerX:
            return @"X";
            break;
        default:
            return @"";
            break;
    }
}



@end
