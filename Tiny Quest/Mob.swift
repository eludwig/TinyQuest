//
//  Mob.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 7/9/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

class Mob : MovableNode
{
    var sprites = Dictionary<Direction, SKSpriteNode>()
    var bodyTextures = Dictionary<Direction, [SKTexture]>()
    var eyeTextures = Dictionary<Direction, [SKTexture]>()
    var movementDirector: MovementDirector
    var limitRect: CGRect
    var currentDirection: Direction?
    
    var categoryBitMap: UInt32 = category.none
    var contactBitMap: UInt32 = category.none
    
    // stats
    var health: Int = 0             // 1 - 4 x 5 (max)
    var damage: Int = 0             // 1 - ?
    var level: Double = 0.0         // 1 - 50
    var experience: Double = 0.0    // ?
    
    init (mobName: String, director: MovementDirector, limitRect: CGRect, categoryBitMap: UInt32 , contactBitMap: UInt32)
    {
        movementDirector = director;
        self.limitRect = limitRect
        self.categoryBitMap = categoryBitMap
        self.contactBitMap = contactBitMap
        super.init()
        name = "mob_" + mobName
    }
    
    func move()
    {
        #if DEBUG
        if movementPaused {return}
        #endif
        
        if !movementDirector.isMovementFinished() {
            let (newPoint, newDirection, newDuration) = movementDirector.getNextMovement(position, limitRect: limitRect)
            self.run(
                SKAction.sequence([
                    SKAction.run({self.setDirection(newDirection)}),
                    SKAction.move(to: newPoint, duration: Double(newDuration))
                    ]),
                completion: move)
        }
    }
    
    func addSprite(
        _ direction: Direction,
        bodyTextures: [SKTexture],
        eyeTextures: [SKTexture]?,
        eyeScale: CGFloat,
        eyePos: CGPoint,
        shadowTexture: SKTexture,
        shadowPos: CGPoint)
    {
        // set up down sprite
        let sprite = SKSpriteNode (texture: bodyTextures[0])
        sprite.anchorPoint = CGPoint(x: 0.5,y: 0.0)
        sprite.name = "body"
        sprites[direction] = sprite
        self.bodyTextures[direction] = bodyTextures
        if let eyes = eyeTextures
        {
            let eyeSprite = SKSpriteNode (texture: eyes[0])
            eyeSprite.name = "eyes"     // we use this below (activateSprite)
            sprite.addChild(eyeSprite)
            eyeSprite.position = eyePos
            eyeSprite.xScale = eyeScale
            eyeSprite.yScale = eyeScale
            self.eyeTextures[direction] = eyes
        }
        let shadowSprite = SKSpriteNode (texture: shadowTexture)
        shadowSprite.name = "shadow"
        shadowSprite.zPosition = -1
        shadowSprite.xScale = 0.60
        shadowSprite.yScale = 0.40
        shadowSprite.position = shadowPos
        sprite.addChild(shadowSprite)
    }
    
    func addPhysics(_ sprite: SKSpriteNode!)
    {
        if !(sprite.physicsBody != nil) {
            let radiusY = sprite.size.height / 2
            let radiusX = sprite.size.width / 2
            sprite.physicsBody = SKPhysicsBody(circleOfRadius: radiusY < radiusX ? radiusY : radiusX,
                center: CGPoint(x: 0.0,y: radiusY))
            sprite.physicsBody!.collisionBitMask = 0
            sprite.physicsBody!.categoryBitMask = categoryBitMap
            sprite.physicsBody!.contactTestBitMask = contactBitMap
        }
    }
    
    func addPhysics ()
    {
        if sprites[Direction.down] != nil {
            addPhysics (sprites[Direction.down])
        }
        if sprites[Direction.up] != nil {
            addPhysics (sprites[Direction.up])
        }
        if sprites[Direction.left] != nil {
            addPhysics (sprites[Direction.left])
        }
        if sprites[Direction.right] != nil {
            addPhysics (sprites[Direction.right])
        }
    }

    func setDirection(_ newDirection: Direction)
    {
        if currentDirection != newDirection
        {
            // remove from the scene
            if let body = childNode(withName: "body") {
                removeActions(body)
                body.removeFromParent()
            }
            activateSprite (newDirection)
            currentDirection = newDirection
        }
    }
    
    func activateSprite(_ direction: Direction)
    {
        // try to get the sprite for the correct Direction
        let sprite: SKSpriteNode! = sprites[direction]
        
        if (sprite != nil)
        {
            addChild(sprite)
            
            // there must be an array of at LEAST one texture (!)
            let bodyTextures: [SKTexture]! = self.bodyTextures[direction]
            
            // start legs moving
            sprite.run(SKAction.repeatForever(
                SKAction.animate(with: bodyTextures, timePerFrame: 0.4)
            ))

            // see if there are eyes for this sprite that
            if let eyeTextures = eyeTextures[direction]
            {
                // get the eye sprite
                if let eyeSprite = sprite.childNode(withName: "eyes") as? SKSpriteNode
                {
                    // start his eyes blinking
                    sprite.run(SKAction.repeatForever(SKAction.sequence([
                        SKAction.wait(forDuration: 2.0, withRange:2.0),
                        SKAction.run({eyeSprite.texture = eyeTextures[eyeTextures.count - 1]}),
                        SKAction.wait(forDuration: 0.15),
                        SKAction.run({eyeSprite.texture = eyeTextures[randInt(0, high: eyeTextures.count - 1)]})
                        ])))
                }
            }
        }
    }
    
    required init(coder: NSCoder)
    {
        fatalError("NSCoding not supported")
    }
}
