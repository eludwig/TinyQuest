//
//  SimpleMovement.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 7/9/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit

class SimpleMovement : MovementDirector
{
    var nextPointIndex = 0
    var points: [CGPoint]?
    
    override init()
    {
        super.init()
    }
    
    init(points:[CGPoint])
    {
        self.points = points
        super.init()
    }
    
    override init(unitsPerSecond: Double)
    {
        super.init(unitsPerSecond: unitsPerSecond)
    }
    
    init(points:[CGPoint], unitsPerSecond: Double)
    {
        self.points = points
        super.init(unitsPerSecond: unitsPerSecond)
    }
    
    override func getNextMovement (_ currentPoint: CGPoint, limitRect: CGRect) ->
        (newPoint: CGPoint, newDirection: Direction, newDuration: Double)
    {
        var newPoint = CGPoint()
        
        if let points = self.points {
            newPoint = points[nextPointIndex]
            nextPointIndex += 1
        } else {
            newPoint.x = randCG(limitRect.origin.x, high: limitRect.origin.x + limitRect.width)
            newPoint.y = randCG(limitRect.origin.y, high: limitRect.origin.y + limitRect.height)
        }
        
        let xDelta = Double(fabs(newPoint.x - currentPoint.x))
        let yDelta = Double(fabs(newPoint.y - currentPoint.y))
        let distance: Double = sqrt(xDelta * xDelta + yDelta * yDelta)
        let duration: Double = (distance / unitsPerSecond)
        
        var direction: Direction
        
        if xDelta > yDelta {
            direction = Direction.right
            if newPoint.x < currentPoint.x {
                direction = Direction.left
            }
        } else {
            direction = Direction.up
            if newPoint.y < currentPoint.y {
                direction = Direction.down
            }
        }
        
        return (newPoint, direction, duration)
    }
    
    override func isMovementFinished () -> Bool
    {
        if let points = self.points {
            return nextPointIndex >= points.count
        } else {
            return false
        }
    }
}
