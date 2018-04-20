//
//  Poof.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 7/20/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

class Poof: SKNode
{
    var textures = [SKTexture]()
    var body: SKSpriteNode
    
    required init(coder: NSCoder)
    {
        fatalError("NSCoding not supported")
    }
    
    override init()
    {
        textures.append(commonAtlas.textureNamed("Poof1"))
        textures.append(commonAtlas.textureNamed("Poof2"))
        textures.append(commonAtlas.textureNamed("Poof3"))
        textures.append(commonAtlas.textureNamed("Poof4"))
        textures.append(commonAtlas.textureNamed("Poof5"))
        
        body = SKSpriteNode (texture: textures[0])
        body.name = "body"
        body.anchorPoint = CGPoint(x: 0.5,y: 0.0)

        super.init()
        
        name = "Poof"
        
        addChild(body)
    }
    
    func poof(_ scene: SKScene, position: CGPoint, scale: Double)
    {
        self.position = position
        body.xScale = CGFloat(scale)
        body.yScale = CGFloat(scale)
        // start legs moving
        scene.addChild(self)
        body.run(SKAction.sequence([
            SKAction.animate(with: textures, timePerFrame: 0.02),
            SKAction.run({self.removeFromParent()})
        ]))
    }
}
