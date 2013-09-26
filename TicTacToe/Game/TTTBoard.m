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


#pragma mark - Helper Methods


- (void) resetGrid {
    self.grid = [NSMutableArray array];
    
    for (int i = 0; i < 9; i++) {
        [self.grid addObject:@0];
    }
}

- (void) printGrid {
    NSLog(@"%@ | %@ | %@", self.grid[0], self.grid[1], self.grid[2]);
    NSLog(@"----------");
    NSLog(@"%@ | %@ | %@", self.grid[3], self.grid[4], self.grid[5]);
    NSLog(@"----------");
    NSLog(@"%@ | %@ | %@", self.grid[6], self.grid[7], self.grid[8]);
}



@end
