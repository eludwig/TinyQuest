//
//  Butterfly.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 8/30/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

class Butterfly : SKNode
{
    var limitRect: CGRect
    var sprite: SKSpriteNode
    var bodyTextures: [SKTexture] = [SKTexture]()
    
    required init(coder: NSCoder)
    {
        fatalError("NSCoding not supported")
    }
    
    init (limitRect: CGRect)
    {
        self.limitRect = limitRect
        bodyTextures.append(levelOneAtlas.textureNamed("Butterfly1"))
        bodyTextures.append(levelOneAtlas.textureNamed("Butterfly2"))
        sprite = SKSpriteNode (texture: bodyTextures[0])
        sprite.anchorPoint = CGPoint(x: 0.5,y: 0.0)
        sprite.run(SKAction.repeatForever(
            SKAction.animate(with: bodyTextures, timePerFrame: 0.1)
            ))
        super.init()
        name = "sort_Butterfly"
        setScale(0.65)
        addChild(sprite)
    }
    
    func move ()
    {
        var newPoint: CGPoint
        repeat {
            let rect = CGRect(x: position.x - 30.0, y: position.y - 30.0, width: 60.0, height: 60.0)
            newPoint = randCGPoint (rect)
        } while !limitRect.contains (newPoint)
        
        let theta = rotate (position, newPosition: newPoint)
        
        let xDelta = Double(fabs(newPoint.x - position.x))
        let yDelta = Double(fabs(newPoint.y - position.y))
        let distance: Double = sqrt(xDelta * xDelta + yDelta * yDelta)
        let duration: Double = (distance / 50.0)
        
        run(SKAction.sequence([
            SKAction.rotate(toAngle: theta, duration: 0.0),
            SKAction.move(to: newPoint, duration: duration)
            ]), completion: move)
    }
}
