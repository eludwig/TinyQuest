//
//  TinyStatBoard.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 7/22/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

class TinyStatBoard : SKNode
{
    fileprivate var level: SKLabelNode
    fileprivate var healthBar: HealthBar
    fileprivate var score: SKLabelNode

    required init(coder: NSCoder)
    {
        fatalError("NSCoding not supported")
    }
    
    init(gameScene: SKScene)
    {
        let height = CGFloat(32.0)
        
        let backGround = SKSpriteNode (color: SKColor.black, size:CGSize(width: gameScene.frame.width,height: height))
        backGround.anchorPoint = CGPoint(x: 0.0,y: 0.0)
        
        let baseLine = CGFloat(8.0)
        let fontSize = CGFloat(28.0)
        let fontName = "Copperplate-Bold"
        
        var textNode = SKLabelNode (fontNamed: fontName)
        textNode.text = "Level:"
        textNode.fontSize = fontSize
        textNode.position = CGPoint(x: 5.0, y: baseLine)
        textNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        textNode.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        backGround.addChild(textNode)
        
        level = SKLabelNode (fontNamed: fontName)
        level.text = "1"
        level.fontSize = fontSize
        level.position = CGPoint(x: 105.0, y: baseLine)
        level.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        level.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        backGround.addChild(level)

        textNode = SKLabelNode (fontNamed: fontName)
        textNode.text = "Health:"
        textNode.fontSize = fontSize
        textNode.position = CGPoint(x: 250.0, y: baseLine)
        textNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        textNode.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        backGround.addChild(textNode)

        healthBar = HealthBar()
        healthBar.position = CGPoint(x: 370, y: 8)
        backGround.addChild(healthBar)
        
        textNode = SKLabelNode (fontNamed: fontName)
        textNode.text = "Score:"
        textNode.fontSize = fontSize
        textNode.position = CGPoint(x: 550.0, y: baseLine)
        textNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        textNode.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        backGround.addChild(textNode)
        
        score = SKLabelNode (fontNamed: fontName)
        score.text = "?"
        score.fontSize = fontSize
        score.position = CGPoint(x: 650.0, y: baseLine)
        score.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        score.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        backGround.addChild(score)
        
        super.init()
        
        addChild(backGround)

        position = CGPoint(x: gameScene.frame.origin.x, y: gameScene.frame.origin.y + (gameScene.frame.height - height))
    }
    
    func updateLevel (_ val: Int)
    {
        level.text = String(val)
    }
    
    func updateHealth (_ currentHealth: Int, maximumHealth: Int)
    {
        healthBar.maximumHealth = maximumHealth
        healthBar.currentHealth = currentHealth
        healthBar.updateHealth()
    }
    
    func updateScore (_ val: Int)
    {
        score.text = String(val)
    }
}
