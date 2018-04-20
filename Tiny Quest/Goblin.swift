//
//  Goblin.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 7/14/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

class Goblin : Mob
{
    required init(coder: NSCoder)
    {
        fatalError("NSCoding not supported")
    }
    
    init(limitRect: CGRect)
    {
        super.init(mobName: "Goblin",
            director: SimpleXAndYMovement(unitsPerSecond: 66.0),
            limitRect: limitRect,
            categoryBitMap: category.mob,
            contactBitMap: category.none)
        
        addSprite(Direction.up,
            bodyTextures: [mobAtlas.textureNamed("GoblinUp1"), mobAtlas.textureNamed("GoblinUp2")],
            eyeTextures: nil,
            eyeScale: 0.0,
            eyePos: CGPoint(x: 0.0, y: 0.0),
            shadowTexture: mobAtlas.textureNamed("Shadow"),
            shadowPos: CGPoint(x: 0.0, y: 2.0))
        addSprite(Direction.down,
            bodyTextures: [mobAtlas.textureNamed("GoblinDown1"), mobAtlas.textureNamed("GoblinDown2")],
            eyeTextures: eyeBank.googlyEyeTextures,
            eyeScale: 0.18,
            eyePos: CGPoint(x: -4.0, y: 52.0),
            shadowTexture: mobAtlas.textureNamed("Shadow"),
            shadowPos: CGPoint(x: 0.0, y: 2.0))
        addSprite(Direction.left,
            bodyTextures: [mobAtlas.textureNamed("GoblinLeft1"), mobAtlas.textureNamed("GoblinLeft2")],
            eyeTextures: eyeBank.eyesSideLeftTextures,
            eyeScale: 0.18,
            eyePos: CGPoint(x: -2.0, y: 48.0),
            shadowTexture: mobAtlas.textureNamed("Shadow"),
            shadowPos: CGPoint(x: 0.0, y: 2.0))
        addSprite(Direction.right,
            bodyTextures: [mobAtlas.textureNamed("GoblinRight1"), mobAtlas.textureNamed("GoblinRight2")],
            eyeTextures: eyeBank.eyesSideRightTextures,
            eyeScale: 0.18,
            eyePos: CGPoint(x: 2.0, y: 48.0),
            shadowTexture: mobAtlas.textureNamed("Shadow"),
            shadowPos: CGPoint(x: 0.0, y: 2.0))
    }
}

