//
//  Griffon.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 8/5/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

class Griffon : Mob
{
    init(limitRect: CGRect)
    {
        super.init(mobName: "Griffon",
            director: SimpleXAndYMovement(unitsPerSecond: 40.0),
            limitRect: limitRect,
            categoryBitMap: category.mob,
            contactBitMap: category.none)
        
        addSprite(Direction.up,
            bodyTextures: [mobAtlas.textureNamed("GriffonUp1"), mobAtlas.textureNamed("GriffonUp2")],
            eyeTextures: nil,
            eyeScale: 0.0,
            eyePos: CGPoint(x: 0.0, y: 0.0),
            shadowTexture: mobAtlas.textureNamed("Shadow"),
            shadowPos: CGPoint(x: 0.0, y: -8.0))
        addSprite(Direction.down,
            bodyTextures: [mobAtlas.textureNamed("GriffonDown1"), mobAtlas.textureNamed("GriffonDown2")],
            eyeTextures: eyeBank.tallEyeTextures,
            eyeScale: 0.14,
            eyePos: CGPoint(x: 2.0, y: 33.0),
            shadowTexture: mobAtlas.textureNamed("Shadow"),
            shadowPos: CGPoint(x: 0.0, y: -8.0))
        addSprite(Direction.left,
            bodyTextures: [mobAtlas.textureNamed("GriffonLeft1"), mobAtlas.textureNamed("GriffonLeft2")],
            eyeTextures: eyeBank.eyesSideLeftTextures,
            eyeScale: 0.15,
            eyePos: CGPoint(x: -26.0, y: 58.0),
            shadowTexture: mobAtlas.textureNamed("Shadow"),
            shadowPos: CGPoint(x: 0.0, y: -8.0))
        addSprite(Direction.right,
            bodyTextures: [mobAtlas.textureNamed("GriffonRight1"), mobAtlas.textureNamed("GriffonRight2")],
            eyeTextures: eyeBank.eyesSideRightTextures,
            eyeScale: 0.15,
            eyePos: CGPoint(x: 26.0, y: 58.0),
            shadowTexture: mobAtlas.textureNamed("Shadow"),
            shadowPos: CGPoint(x: 0.0, y: -8.0))
    }
    
    override func addPhysics(_ sprite: SKSpriteNode!)
    {
        if !(sprite.physicsBody != nil) {
            let radiusY = sprite.size.height / 3
            let radiusX = sprite.size.width / 3
            sprite.physicsBody = SKPhysicsBody(circleOfRadius: radiusY < radiusX ? radiusY : radiusX,
                center: CGPoint(x: 0.0,y: sprite.size.height / 2))
            sprite.physicsBody!.collisionBitMask = 0
            sprite.physicsBody!.categoryBitMask = categoryBitMap
            sprite.physicsBody!.contactTestBitMask = contactBitMap
        }
    }
    
    required init(coder: NSCoder)
    {
        fatalError("NSCoding not supported")
    }
}

