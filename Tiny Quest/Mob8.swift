//
//  Mob8.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 7/3/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

// Create a simple 8 texture Node (up, down, left, right)
class Mob8 : Mob
{
    // 8 textures (2 x 4 directions)
    var down1Texture: SKTexture
    var down2Texture: SKTexture
    var up1Texture: SKTexture
    var up2Texture: SKTexture
    var left1Texture: SKTexture
    var left2Texture: SKTexture
    var right1Texture: SKTexture
    var right2Texture: SKTexture
    
    // body sprites
    var downSprite: SKSpriteNode
    var upSprite: SKSpriteNode
    var leftSprite: SKSpriteNode
    var rightSprite: SKSpriteNode
    
    // eye sprites (up has no eyes)
    var eyes: [SKTexture]
    var downEyes: SKSpriteNode
    var leftEyes: SKSpriteNode
    var rightEyes: SKSpriteNode
    
    
    init (
        mobName: String,
        atlas: SKTextureAtlas,
        eyes: [SKTexture],
        eyeScale: CGFloat,
        downEyePos: CGPoint,
        leftEyePos: CGPoint,
        rightEyePos: CGPoint,
        director: MovementDirector,
        limitRect: CGRect
        )
    {
        self.eyes = eyes
        
        down1Texture = atlas.textureNamed(mobName + "_down1")
        down2Texture = atlas.textureNamed(mobName + "_down2")
        up1Texture = atlas.textureNamed(mobName + "_up1")
        up2Texture = atlas.textureNamed(mobName + "_up2")
        left1Texture = atlas.textureNamed(mobName + "_left1")
        left2Texture = atlas.textureNamed(mobName + "_left2")
        right1Texture = atlas.textureNamed(mobName + "_right1")
        right2Texture = atlas.textureNamed(mobName + "_right2")

        // set up down sprite
        downSprite = SKSpriteNode (texture: down1Texture)
        downSprite.name = "body"
        downEyes = SKSpriteNode (texture: eyes[0])
        downEyes.name = "eyes"
        downSprite.addChild(downEyes)
        downEyes.position = downEyePos
        downEyes.xScale = eyeScale
        downEyes.yScale = eyeScale
        downSprite.physicsBody = SKPhysicsBody(rectangleOfSize: downSprite.size)
        downSprite.physicsBody.categoryBitMask = 2
        downSprite.physicsBody.collisionBitMask = 0
        downSprite.physicsBody.contactTestBitMask = 1
        //downSprite.physicsBody.dynamic = false;
        downSprite.anchorPoint = CGPointMake(0.5,0.0)
        
        // set up up sprite
        upSprite = SKSpriteNode (texture: up1Texture)
        upSprite.name = "body"
        upSprite.physicsBody = SKPhysicsBody(rectangleOfSize: upSprite.size)
        upSprite.physicsBody.categoryBitMask = 2
        upSprite.physicsBody.collisionBitMask = 0
        upSprite.physicsBody.contactTestBitMask = 1
        //upSprite.physicsBody.dynamic = false;
        upSprite.anchorPoint = CGPointMake(0.5,0.0)
        
        // set up left sprite
        leftSprite = SKSpriteNode (texture: left1Texture)
        leftSprite.name = "body"
        leftEyes = SKSpriteNode (texture: eyeBank.eyesSideLeft)
        leftEyes.name = "eyes"
        leftSprite.addChild(leftEyes)
        leftEyes.position = leftEyePos
        leftEyes.xScale = eyeScale
        leftEyes.yScale = eyeScale
        leftSprite.physicsBody = SKPhysicsBody(rectangleOfSize: leftSprite.size)
        leftSprite.physicsBody.categoryBitMask = 2
        leftSprite.physicsBody.collisionBitMask = 0
        leftSprite.physicsBody.contactTestBitMask = 1
        //leftSprite.physicsBody.dynamic = false;
        leftSprite.anchorPoint = CGPointMake(0.5,0.0)
        
        // set up right sprite
        rightSprite = SKSpriteNode (texture: right1Texture)
        rightSprite.name = "body"
        rightEyes = SKSpriteNode (texture: eyeBank.eyesSideRight)
        rightEyes.name = "eyes"
        rightSprite.addChild(rightEyes)
        rightEyes.position = rightEyePos
        rightEyes.xScale = eyeScale
        rightEyes.yScale = eyeScale
        rightSprite.physicsBody = SKPhysicsBody(rectangleOfSize: rightSprite.size)
        rightSprite.physicsBody.categoryBitMask = 2
        rightSprite.physicsBody.collisionBitMask = 0
        rightSprite.physicsBody.contactTestBitMask = 1
        //rightSprite.physicsBody.dynamic = false;
        rightSprite.anchorPoint = CGPointMake(0.5,0.0)
        
        super.init(director: director, limitRect: limitRect)
        
        name = mobName
        
        currentDirection = Direction.Still
    }
    
    override func setDirection (newDirection: Direction)
    {
        if (newDirection != currentDirection)
        {
            // get the current child
            if let body = childNodeWithName("body") {
                body.removeFromParent()
                body.removeAllActions()
            }

            // add the correct sprite
            switch (newDirection)
            {
            case Direction.Down:
                addChild(downSprite);
                // start his eyes blinking
                downSprite.runAction(SKAction.repeatActionForever(SKAction.sequence([
                    SKAction.waitForDuration(2.0, withRange:2.0),
                    SKAction.runBlock({self.downEyes.texture = self.eyes[self.eyes.count - 1]}),
                    SKAction.waitForDuration(0.15),
                    SKAction.runBlock({self.downEyes.texture = self.eyes[randInt(0, self.eyes.count - 1)]})
                    ])))
                
                // start legs moving
                downSprite.runAction(SKAction.repeatActionForever(SKAction.sequence([
                    SKAction.waitForDuration(0.4),
                    SKAction.runBlock({self.downSprite.texture = self.down2Texture}),
                    SKAction.waitForDuration(0.4),
                    SKAction.runBlock({self.downSprite.texture = self.down1Texture})
                    ])))
                
            case Direction.Up:
                addChild(upSprite);
                // start legs moving
                upSprite.runAction(SKAction.repeatActionForever(SKAction.sequence([
                    SKAction.waitForDuration(0.4),
                    SKAction.runBlock({self.upSprite.texture = self.up2Texture}),
                    SKAction.waitForDuration(0.4),
                    SKAction.runBlock({self.upSprite.texture = self.up1Texture})
                    ])))
                
            case Direction.Left:
                addChild(leftSprite);
                // start his eyes blinking
                leftSprite.runAction(SKAction.repeatActionForever(SKAction.sequence([
                    SKAction.waitForDuration(2.0, withRange:2.0),
                    SKAction.runBlock({self.leftEyes.texture = eyeBank.eyesSideLeftClosed}),
                    SKAction.waitForDuration(0.15),
                    SKAction.runBlock({self.leftEyes.texture = eyeBank.eyesSideLeft})
                    ])))
                
                // start legs moving
                leftSprite.runAction(SKAction.repeatActionForever(SKAction.sequence([
                    SKAction.waitForDuration(0.4),
                    SKAction.runBlock({self.leftSprite.texture = self.left2Texture}),
                    SKAction.waitForDuration(0.4),
                    SKAction.runBlock({self.leftSprite.texture = self.left1Texture})
                    ])))
                
            case Direction.Right:
                addChild(rightSprite);
                // start his eyes blinking
                rightSprite.runAction(SKAction.repeatActionForever(SKAction.sequence([
                    SKAction.waitForDuration(2.0, withRange:2.0),
                    SKAction.runBlock({self.rightEyes.texture = eyeBank.eyesSideRightClosed}),
                    SKAction.waitForDuration(0.15),
                    SKAction.runBlock({self.rightEyes.texture = eyeBank.eyesSideRight})
                    ])))
                
                // start legs moving
                rightSprite.runAction(SKAction.repeatActionForever(SKAction.sequence([
                    SKAction.waitForDuration(0.4),
                    SKAction.runBlock({self.rightSprite.texture = self.right2Texture}),
                    SKAction.waitForDuration(0.4),
                    SKAction.runBlock({self.rightSprite.texture = self.right1Texture})
                    ])))
                
            case Direction.Still:
                    break
            }
            currentDirection = newDirection
        }
    }
}
