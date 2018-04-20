//
//  Snake.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 7/15/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

class Snake : Mob
{
    required init(coder: NSCoder)
    {
        fatalError("NSCoding not supported")
    }
    
    init(limitRect: CGRect)
    {
        super.init(mobName: "Snake",
            director: SimpleXAndYMovement(),
            limitRect: limitRect,
            categoryBitMap: category.mob,
            contactBitMap: category.none)
        
        addSprite(Direction.up,
            bodyTextures: [mobAtlas.textureNamed("SnakeUp1"), mobAtlas.textureNamed("SnakeUp2")],
            eyeTextures: nil,
            eyeScale: 0.0,
            eyePos: CGPoint(x: 0.0, y: 0.0),
            shadowTexture: mobAtlas.textureNamed("ShadowTall"),
            shadowPos: CGPoint(x: 0.0, y: 12.0))
        addSprite(Direction.down,
            bodyTextures: [mobAtlas.textureNamed("SnakeDown1"), mobAtlas.textureNamed("SnakeDown2")],
            eyeTextures: eyeBank.googlyEyeTextures,
            eyeScale: 0.15,
            eyePos: CGPoint(x: 2.0, y: 48.0),
            shadowTexture: mobAtlas.textureNamed("ShadowTall"),
            shadowPos: CGPoint(x: 0.0, y: 12.0))
        addSprite(Direction.left,
            bodyTextures: [mobAtlas.textureNamed("SnakeLeft1"), mobAtlas.textureNamed("SnakeLeft2")],
            eyeTextures: eyeBank.eyesSideLeftTextures,
            eyeScale: 0.18,
            eyePos: CGPoint(x: -11.0, y: 48.0),
            shadowTexture: mobAtlas.textureNamed("Shadow"),
            shadowPos: CGPoint(x: 0.0, y: 0.0))
        addSprite(Direction.right,
            bodyTextures: [mobAtlas.textureNamed("SnakeRight1"), mobAtlas.textureNamed("SnakeRight2")],
            eyeTextures: eyeBank.eyesSideRightTextures,
            eyeScale: 0.18,
            eyePos: CGPoint(x: 11.0, y: 48.0),
            shadowTexture: mobAtlas.textureNamed("Shadow"),
            shadowPos: CGPoint(x: 0.0, y: 0.0))
    }
}

