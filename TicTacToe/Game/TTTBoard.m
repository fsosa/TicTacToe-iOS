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
        self.grid = [NSMutableArray array];
        
        for (int i = 0; i < 9; i++) {
            [self.grid addObject:@0];
        }
    }
    
    return self;
}

#pragma mark - Grid Operations

- (void) moveMarker:(NSInteger)marker toLocation:(NSInteger)location {
    
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



@end
