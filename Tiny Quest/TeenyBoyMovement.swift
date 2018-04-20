//
//  TeenyBoyMovement.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 7/9/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit

class TeenyBoyMovement: MovementDirector
{
    override init()
    {
        super.init()
    }
    
    override init(unitsPerSecond: Double)
    {
        super.init(unitsPerSecond: unitsPerSecond)
    }
    
    override func getNextMovement (_ currentPoint: CGPoint, limitRect: CGRect) ->
        (newPoint: CGPoint, newDirection: Direction, newDuration: Double)
    {
        var newP = currentPoint
        newP.y = limitRect.height + 200
        let units = CGFloat(unitsPerSecond)
        return (newP, Direction.up, Double((newP.y - currentPoint.y) / units))
    }
}
