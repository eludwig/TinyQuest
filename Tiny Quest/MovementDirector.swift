//
//  MovementDirector.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 7/8/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

class MovementDirector
{
    var unitsPerSecond: Double = 100.0
    
    init ()
    {
    }

    init (unitsPerSecond: Double)
    {
        self.unitsPerSecond = unitsPerSecond
    }

    // to be overrided
    func getNextMovement (_ currentPoint: CGPoint, limitRect: CGRect) ->
        (newPoint: CGPoint, newDirection: Direction, newDuration: Double)
    {
        return (currentPoint, Direction.up, 0.0)
    }
    
    func isMovementFinished () -> Bool
    {
        return false
    }
}
