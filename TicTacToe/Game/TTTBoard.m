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

- (void) moveMarker:(NSInteger)marker toLocation:(NSInteger)location {
    if ([self isValidMove:location]) {
        NSNumber *mark = [NSNumber numberWithInt:marker];
        [self.grid replaceObjectAtIndex:location withObject:mark];
    }
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

- (BOOL) isGameComplete {
    NSInteger movesLeft = [[self legalMoves] count];
    BOOL noRemainingMoves = movesLeft == 0;
    
    return [self hasWinningRows] || [self hasWinningColumns] || [self hasWinningDiagonal] || noRemainingMoves;
}

- (BOOL) hasWinningRows {
    for (int i = 0; i < 3; i++) {
        int rowScore = [self scoreForRow:i];
        
        if (rowScore == 3 || rowScore == -3) {
            return YES;
        }
    }
    
    return NO;
    
}

- (BOOL) hasWinningColumns {
    for (int i = 0; i < 3; i++) {
        int colScore = [self scoreForColumn:i];
        
        if (colScore == 3 || colScore == -3) {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL) hasWinningDiagonal {
    BOOL leftDiagonal = [self scoreForDiagonal:0];
    BOOL rightDiagonal = [self scoreForDiagonal:2];
    
    return leftDiagonal || rightDiagonal;
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
    if (topCornerIndex != 0 || topCornerIndex != 2) {
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




#pragma mark - Helper Methods

- (NSString *) markerAtLocation:(NSInteger)location {
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


- (void) resetGrid {
    self.grid = [NSMutableArray array];
    
    for (int i = 0; i < 9; i++) {
        [self.grid addObject:@0];
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



@end
