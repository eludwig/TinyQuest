//
//  Qbert.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 7/1/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

class Qbert: Mob8 {
    
    init(limitRect: CGRect)
    {
        super.init(
            mobName: "mob_qbert",
            atlas: mobAtlas,
            eyes: eyeBank.googlyEyeTextures,
            eyeScale: 0.35,
            downEyePos: CGPointMake(0.0, 110.0),
            leftEyePos: CGPointMake(-10.0, 100.0),
            rightEyePos: CGPointMake(10.0, 100.0),
            director: SimpleXAndYMovement(),
            limitRect: limitRect
        )
    }
}
