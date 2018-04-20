//
//  SimpleXAndYMovement.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 7/9/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit

class SimpleXAndYMovement : MovementDirector
{
    var lastDirection: Direction
    
    override init()
    {
        lastDirection = Direction.up
        super.init()
    }
    
    override init(unitsPerSecond: Double)
    {
        lastDirection = Direction.up
        super.init(unitsPerSecond: unitsPerSecond)
    }
    
    override func getNextMovement (_ currentPoint: CGPoint, limitRect: CGRect) ->
        (newPoint: CGPoint, newDirection: Direction, newDuration: Double)
    {
        var newPoint = currentPoint
        var newDirection: Direction
        var newDuration: Double
        if lastDirection == Direction.up || lastDirection == Direction.down
        {
            newPoint.x = randCG(limitRect.origin.x, high: limitRect.origin.x + limitRect.width)
            newDirection = (newPoint.x > currentPoint.x) ? Direction.right : Direction.left
            newDuration = Double(fabs(newPoint.x - currentPoint.x)) / unitsPerSecond
        }
        else
        {
            newPoint.y = randCG(limitRect.origin.y, high: limitRect.origin.y + limitRect.height)
            newDirection = (newPoint.y > currentPoint.y) ? Direction.up : Direction.down
            newDuration = Double(fabs(newPoint.y - currentPoint.y)) / unitsPerSecond
        }
        lastDirection = newDirection
        return (newPoint, newDirection, newDuration)
    }
}
