//
//  TTTComputer.h
//  TicTacToe
//
//  Created by Fidel Sosa on 9/26/13.
//  Copyright (c) 2013 Fidel Sosa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTTBoard.h"

@interface TTTComputer : NSObject

- (void) moveMarker:(TTTBoardMarker)marker onBoard:(TTTBoard *) board;

@end
