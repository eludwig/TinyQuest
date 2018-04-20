//
//  DustMote.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 7/23/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

class DustMote : Mob
{
    required init(coder: NSCoder)
    {
        fatalError("NSCoding not supported")
    }
    
    init(limitRect: CGRect)
    {
        super.init(mobName: "DustMote",
            director: SimpleXAndYMovementOneSprite(unitsPerSecond: 30.0),
            limitRect: limitRect,
            categoryBitMap: category.mob,
            contactBitMap: category.none)
        
        // convention "SimpleXAndYMovementOneSprite" requires on sprite in the Up direction
        addSprite(Direction.up,
            bodyTextures: [mobAtlas.textureNamed("DustMote")],
            eyeTextures: eyeBank.googlyEyeTextures,
            eyeScale: 0.25,
            eyePos: CGPoint(x: 0.0, y: 45.0),
            shadowTexture: mobAtlas.textureNamed("Shadow"),
            shadowPos: CGPoint(x: 0.0, y: 2.0))
    }
}
