//
//  Charger.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 9/10/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

class Charger : Mob
{
    var completion: ()->()
    
    required init(coder: NSCoder)
    {
        fatalError("NSCoding not supported")
    }
    
    init(limitRect: CGRect, points: [CGPoint], isDone: @escaping ()->())
    {
        completion = isDone
        
        super.init(mobName: "Charger",
            director: SimpleMovement(points: points, unitsPerSecond: 250.0),
            limitRect: limitRect,
            categoryBitMap: category.mobKiller,
            contactBitMap: category.mob)
        
        addSprite(Direction.up,
            bodyTextures: [levelOneAtlas.textureNamed("ChargerUp1"), levelOneAtlas.textureNamed("ChargerUp2")],
            eyeTextures: nil,
            eyeScale: 0,
            eyePos: CGPoint(x: 0.0, y: 0.0),
            shadowTexture: mobAtlas.textureNamed("ShadowTall"),
            shadowPos: CGPoint(x: 0.0, y: 12.0))
        addSprite(Direction.down,
            bodyTextures: [levelOneAtlas.textureNamed("ChargerDown1"), levelOneAtlas.textureNamed("ChargerDown2")],
            eyeTextures: nil,
            eyeScale: 0,
            eyePos: CGPoint(x: 0.0, y: 0.0),
            shadowTexture: mobAtlas.textureNamed("ShadowTall"),
            shadowPos: CGPoint(x: 0.0, y: 12.0))
        addSprite(Direction.left,
            bodyTextures: [levelOneAtlas.textureNamed("ChargerLeft1"), levelOneAtlas.textureNamed("ChargerLeft2")],
            eyeTextures: nil,
            eyeScale: 0,
            eyePos: CGPoint(x: 0.0, y: 0.0),
            shadowTexture: mobAtlas.textureNamed("Shadow"),
            shadowPos: CGPoint(x: 0.0, y: 0.0))
        addSprite(Direction.right,
            bodyTextures: [levelOneAtlas.textureNamed("ChargerRight1"), levelOneAtlas.textureNamed("ChargerRight2")],
            eyeTextures: nil,
            eyeScale: 0,
            eyePos: CGPoint(x: 0.0, y: 0.0),
            shadowTexture: mobAtlas.textureNamed("Shadow"),
            shadowPos: CGPoint(x: 0.0, y: 0.0))
    }
    
    override func move()
    {
        if movementDirector.isMovementFinished() {
            completion()
        } else {
            super.move()
        }
    }
}

