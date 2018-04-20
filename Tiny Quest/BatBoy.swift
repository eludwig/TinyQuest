//
//  BatBoy.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 7/14/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

class BatBoy : Mob
{
    required init(coder: NSCoder)
    {
        fatalError("NSCoding not supported")
    }
    
    init(limitRect: CGRect)
    {
        super.init(mobName: "BatBoy",
            director: SimpleXAndYMovementOneSprite(),
            limitRect: limitRect,
            categoryBitMap: category.mob,
            contactBitMap: category.none)
        
        // convention "SimpleXAndYMovementOneSprite" requires on sprite in the Up direction
        addSprite(Direction.up,
            bodyTextures: [mobAtlas.textureNamed("BatBoy1"), mobAtlas.textureNamed("BatBoy2")],
            eyeTextures: eyeBank.googlyEyeTextures,
            eyeScale: 0.10,
            eyePos: CGPoint(x: 1.0, y: 35.0),
            shadowTexture: mobAtlas.textureNamed("Shadow"),
            shadowPos: CGPoint(x: 0.0, y: -20.0))
    }
}
