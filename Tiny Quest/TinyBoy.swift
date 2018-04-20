//
//  TinyBoySprite.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 6/23/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

class TinyBoy
{
    // stats
    var health: Int = 0             // 1 - 4 x 5 (max)
    var maxHealthForLevel: Int = 0  // power of 4
    var damage: Int  = 0            // 1 - ?
    var level: Double  = 0          // 1 - 50
    var score: Int = 0

    init()
    {
        reset ()
    }
    
    func reset ()
    {
        health = 4
        maxHealthForLevel = 4
        damage = 1
        level = 1.0
        score = 0
    }
    
    func getSprite () ->SKNode
    {
        let tinyBoy = SKNode ()
        tinyBoy.name = "TinyBoy"
        
        let body = SKSpriteNode (texture: tinyBoyAtlas.textureNamed("TinyBoyCloth"))
        body.name = "body"
        tinyBoy.addChild(body)
        // set anchor point in UNIT coords (0.0 - 1.0)
        body.anchorPoint = CGPoint(x: 0.5,y: 0.0)
        
        // add the eyes
        let eyes = SKSpriteNode (texture: eyeBank.tinyBoyEyesStraight)
        eyes.name = "eyes"
        body.addChild(eyes)
        eyes.position = CGPoint(x: 0.0,y: 75.0)
        
        // start his eyes blinking
        let animateEyes = SKAction.sequence([
            SKAction.wait(forDuration: 2.0, withRange:2.0),
            SKAction.run({eyes.texture = eyeBank.tinyBoyEyesClosed}),
            SKAction.wait(forDuration: 0.15),
            SKAction.run({eyes.texture = eyeBank.tinyBoyEyeTextures[randInt(0, high: eyeBank.tinyBoyEyeTextures.count - 1)]})
            ])
        
        tinyBoy.run(SKAction.repeatForever(animateEyes))
        
        return tinyBoy
    }
}
