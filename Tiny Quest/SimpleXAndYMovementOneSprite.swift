//
//  SimpleXAndYMovementOneSprite.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 8/15/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit

class SimpleXAndYMovementOneSprite : SimpleXAndYMovement
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
        let (newPoint, _, newDuration) = super.getNextMovement(currentPoint, limitRect: limitRect)
        return (newPoint, Direction.up, newDuration)
    }
}
