//
//  TeenyBoyCloth.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 7/8/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

class TeenyBoyCloth: Mob
{
    required init(coder: NSCoder)
    {
        fatalError("NSCoding not supported")
    }
    
    init(limitRect: CGRect)
    {
        let contactBitMap: UInt32 = category.mob | category.sceneBorder | category.special

        super.init(mobName: "TeenyBoyCloth",
            director: TeenyBoyMovement(),
            limitRect: limitRect,
            categoryBitMap: category.teenyBoy,
            contactBitMap: contactBitMap)
        
        // TeenyBoyMovement only ever sets the Up sprite
        addSprite(Direction.up,
            bodyTextures: [tinyBoyAtlas.textureNamed("TinyBoyClothUp1"), tinyBoyAtlas.textureNamed("TinyBoyClothUp2")],
            eyeTextures: nil,
            eyeScale: 0.0,
            eyePos: CGPoint(x: 0.0, y: 0.0),
            shadowTexture: tinyBoyAtlas.textureNamed("Shadow"),
            shadowPos: CGPoint(x: 0.0, y: 0.0))
    }
}

