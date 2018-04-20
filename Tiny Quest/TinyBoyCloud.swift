//
//  TinyBoyCloud.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 7/28/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

class TinyBoyCloud : SKNode
{
    required init(coder: NSCoder)
    {
        fatalError("NSCoding not supported")
    }
    
    init (scene: GameScene, scale: Double, position: CGPoint)
    {
        super.init();
        
        var bodyTextures = [SKTexture]()
        bodyTextures.append(tinyBoyAtlas.textureNamed("TinyBoyCloud1"))
        bodyTextures.append(tinyBoyAtlas.textureNamed("TinyBoyCloud2"))
        
        let body = SKSpriteNode (texture: bodyTextures[0])
        body.name = "body"
        addChild(body)
        body.xScale = CGFloat(scale)
        body.yScale = CGFloat(scale)
        // set anchor point in UNIT coords (0.0 - 1.0)
        body.anchorPoint = CGPoint(x: 0.5,y: 0.5)
        
        var eyeTextures = [SKTexture]()
        eyeTextures.append(tinyBoyAtlas.textureNamed("TinyBoyCloudEyesOpen"))
        eyeTextures.append(tinyBoyAtlas.textureNamed("TinyBoyCloudEyesClosed"))
        
        // add the eyes
        let eyes = SKSpriteNode (texture: eyeTextures[0])
        eyes.name = "eyes"
        body.addChild(eyes)
        eyes.position = CGPoint(x: 3.0,y: 12.0)
        
        // start his wings flapping
        // start legs moving
        body.run(SKAction.repeatForever(
            SKAction.animate(with: bodyTextures, timePerFrame: 1.0)
            ))
        
        // start his eyes blinking
        let animateEyes = SKAction.sequence([
            SKAction.wait(forDuration: 2.0, withRange:2.0),
            SKAction.run({eyes.texture = eyeTextures[1]}),
            SKAction.wait(forDuration: 0.15),
            SKAction.run({eyes.texture = eyeTextures[0]})
            ])
        
        eyes.run(SKAction.repeatForever(animateEyes))
        
        scene.addChild(self)
        self.position = position
        zPosition = 10000
    }
}
