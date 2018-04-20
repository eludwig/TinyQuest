//
//  Teleport.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 8/5/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

class Teleport : Special
{
    required init(coder: NSCoder)
    {
        fatalError("NSCoding not supported")
    }
    
    init ()
    {
        super.init(specialName: "Teleport")
        
        let special = addSprite (SKSpriteNode(texture: commonAtlas.textureNamed("Teleport")))
        
        let shadowSprite = SKSpriteNode (texture: mobAtlas.textureNamed("Shadow"))
        shadowSprite.name = "shadow"
        shadowSprite.zPosition = -1
        shadowSprite.xScale = 0.6
        shadowSprite.yScale = 0.6
        shadowSprite.position = CGPoint(x: 0.0, y: 2.0)
        special.addChild(shadowSprite)
    }
    
    override func invoke(_ teenyBoy: Mob)
    {
        let gameScene = scene as! GameScene
        var r = gameScene.frame
        r.size.height /= 2.0
        r = r.insetBy(dx: 5.0, dy: 5.0)
        teenyBoy.removeAllActions()
        teenyBoy.run(SKAction.move(to: randCGPoint (r), duration: 0.0), completion: teenyBoy.move)
        let poof = Poof()
        poof.poof(gameScene, position: position, scale: 0.50)
        removeFromParent()
    }
}
