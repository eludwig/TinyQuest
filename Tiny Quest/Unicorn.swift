//
//  BabyUnicorn.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 7/14/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

class Unicorn : Mob
{
    required init(coder: NSCoder)
    {
        fatalError("NSCoding not supported")
    }
    
    init(limitRect: CGRect)
    {
        super.init(mobName: "Unicorn",
            director: SimpleXAndYMovement(),
            limitRect: limitRect,
            categoryBitMap: category.mob,
            contactBitMap: category.none)
        
        addSprite(Direction.up,
            bodyTextures: [mobAtlas.textureNamed("UnicornUp1"), mobAtlas.textureNamed("UnicornUp2")],
            eyeTextures: nil,
            eyeScale: 0.0,
            eyePos: CGPoint(x: 0.0, y: 0.0),
            shadowTexture: mobAtlas.textureNamed("Shadow"),
            shadowPos: CGPoint(x: 0.0, y: 0.0))
        addSprite(Direction.down,
            bodyTextures: [mobAtlas.textureNamed("UnicornDown1"), mobAtlas.textureNamed("UnicornDown2")],
            eyeTextures: eyeBank.tallEyeTextures,
            eyeScale: 0.18,
            eyePos: CGPoint(x: 1.0, y: 60.0),
            shadowTexture: mobAtlas.textureNamed("Shadow"),
            shadowPos: CGPoint(x: 0.0, y: 0.0))
        addSprite(Direction.left,
            bodyTextures: [mobAtlas.textureNamed("UnicornLeft1"), mobAtlas.textureNamed("UnicornLeft2")],
            eyeTextures: eyeBank.eyesSideLeftTextures,
            eyeScale: 0.20,
            eyePos: CGPoint(x: -11.0, y: 63.0),
            shadowTexture: mobAtlas.textureNamed("Shadow"),
            shadowPos: CGPoint(x: 0.0, y: 0.0))
        addSprite(Direction.right,
            bodyTextures: [mobAtlas.textureNamed("UnicornRight1"), mobAtlas.textureNamed("UnicornRight2")],
            eyeTextures: eyeBank.eyesSideRightTextures,
            eyeScale: 0.20,
            eyePos: CGPoint(x: 11.0, y: 63.0),
            shadowTexture: mobAtlas.textureNamed("Shadow"),
            shadowPos: CGPoint(x: 0.0, y: 0.0))
    }
}
