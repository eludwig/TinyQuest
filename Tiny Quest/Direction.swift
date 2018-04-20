//
//  Direction.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 7/8/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

enum Direction : Int
{
    case down = 0, up, left, right
    
    func random(_ currentDirection: Direction) -> Int
    {
        var r: Int
        repeat {
            r = random()
        } while r == currentDirection.rawValue
        return r
    }
    
    func random() -> Int
    {
        return randInt(Direction.down.rawValue, high: Direction.right.rawValue + 1)
    }
}
