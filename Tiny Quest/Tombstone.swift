//
//  Tombstone.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 8/13/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

class Tombstone : Special
{
    required init(coder: NSCoder)
    {
        fatalError("NSCoding not supported")
    }
    
    init ()
    {
        super.init(specialName: "Tombstone")
        
        _ = addSprite (SKSpriteNode(texture: tinyBoyAtlas.textureNamed("Headstone")))
    }
}


