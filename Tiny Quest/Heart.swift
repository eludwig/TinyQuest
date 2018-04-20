//
//  Heart.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 7/23/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

class Heart : Special
{
    let healthReplenished: Int
    
    init (healthReplenished : Int)
    {
        self.healthReplenished = healthReplenished
        super.init(specialName: "Heart")
        
        let special = addSprite (SKSpriteNode(texture: commonAtlas.textureNamed("Heart")))
        
        let fontName = "Copperplate-Bold"
        let textNode = SKLabelNode (fontNamed: fontName)
        textNode.text = String(healthReplenished)
        textNode.fontSize = 55.0
        textNode.position = CGPoint(x: 0.0, y: 45.0)
        textNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        textNode.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        special.addChild(textNode)
        
        let shadowSprite = SKSpriteNode (texture: mobAtlas.textureNamed("Shadow"))
        shadowSprite.name = "shadow"
        shadowSprite.zPosition = -1
        shadowSprite.xScale = 1.0
        shadowSprite.yScale = 1.0
        shadowSprite.position = CGPoint(x: 0.0, y: 2.0)
        special.addChild(shadowSprite)
    }
    
    override func invoke(_ teenyBoy: Mob)
    {
        let gameScene = scene as! GameScene

        tinyBoy.health += healthReplenished
        if tinyBoy.health > tinyBoy.maxHealthForLevel {
            tinyBoy.health = tinyBoy.maxHealthForLevel
        }
        gameScene.tinyStatBoard!.updateHealth(tinyBoy.health, maximumHealth: tinyBoy.maxHealthForLevel)
        let poof = Poof()
        poof.poof(gameScene, position: position, scale: 0.50)
        removeFromParent()
        floatNumber (teenyBoy, number: healthReplenished, direction: Direction.left)
    }
    
    required init(coder: NSCoder)
    {
        fatalError("NSCoding not supported")
    }
}
