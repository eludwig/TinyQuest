//
//  InitialScene.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 6/18/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

let gameSize = CGSize(width:750 ,height:1350)
var audioPlayer: AVAudioPlayer?
#if DEBUG
var movementPaused: Bool = false
#endif

class GameScene: SKScene, SKPhysicsContactDelegate
{
    var contentCreated: Bool = false
    var gameView: GameView?
    var tinyStatBoard: TinyStatBoard?
    var sceneBorderCollision: ((_ teenyBoy: Mob)->())?
    var bgSound: URL?
    #if DEBUG
    var playButton: ClickableNode?
    var pauseButton: ClickableNode?
    #endif
    
    override func didMove(to view: SKView)
    {
        if contentCreated == false {
            gameView = view as? GameView
            srandom(UInt32(time(nil)))  // reset random seed
            createSceneContents ()
            contentCreated = true
            physicsWorld.gravity = CGVector(dx: 0, dy: 0)
            physicsWorld.contactDelegate = self;
            let frame = self.frame.insetBy(dx: -50.0, dy: -100.0)
            physicsBody = SKPhysicsBody (edgeLoopFrom:frame);
            physicsBody!.categoryBitMask = category.sceneBorder
//            if bgSound != nil {
//                audioPlayer = AVAudioPlayer(contentsOfURL: bgSound, error: nil)
//                audioPlayer!.numberOfLoops = -1
//                audioPlayer!.volume = 0.20
//                audioPlayer!.play()
//            }
            isUserInteractionEnabled = true
        }
    }
    
    func createSceneContents ()
    {
        tinyBoyCloud = nil
        scaleMode = SKSceneScaleMode.aspectFit
        let tinySprite = tinyBoy.getSprite();
        tinySprite.position = CGPoint(x: self.frame.midX,y: 0.0)
        tinySprite.xScale = 1.33
        tinySprite.yScale = 1.33
        tinySprite.zPosition = 10000
        addChild (tinySprite)
        tinyStatBoard = TinyStatBoard (gameScene: self)
        addChild(tinyStatBoard!)
        tinyStatBoard!.updateLevel(Int(tinyBoy.level))
        tinyStatBoard!.updateHealth(tinyBoy.health, maximumHealth: tinyBoy.maxHealthForLevel)
        tinyStatBoard!.updateScore(tinyBoy.score)
        tinyStatBoard!.zPosition = 5000
        #if DEBUG
        // add the play button
        var sprite = SKSpriteNode (texture: debugAtlas.textureNamed("play-arrow"))
        sprite.anchorPoint = CGPointMake(0.0, 0.0)
        sprite.setScale(2.0)
        playButton = ClickableNode(sprite: sprite, onClick: {
            self.playButton!.removeFromParent()
            self.addChild(self.pauseButton!)
            movementPaused = false
            for child in self.children {
                let c = child as SKNode
                if let name = c.name {
                    if name.hasPrefix("mob_") {
                        let mob = c as Mob
                        mob.move()
                    }
                }
            }
//            self.enumerateChildNodesWithName("mob_*", usingBlock: { node, stop in
//                let mob = node as Mob
//                mob.move()
//            })
            
        })
        playButton!.position = CGPointMake(5, 5)
        // add the pause button
        sprite = SKSpriteNode (texture: debugAtlas.textureNamed("pause-arrow"))
        sprite.anchorPoint = CGPointMake(0.0, 0.0)
        sprite.setScale(2.0)
        pauseButton = ClickableNode(sprite: sprite, onClick: {
            self.pauseButton!.removeFromParent()
            self.addChild(self.playButton!)
            movementPaused = true
            removeActions(self)
        })
        addChild (pauseButton!)
        pauseButton!.position = CGPointMake(5, 5)
        #endif
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        // scene logic
        // zPosition all of the sprites based on the y pos
        var sortedChildren = [SKNode]()
        for child in children {
            let c = child 
            if let name = c.name {
                if name.hasPrefix("mob_") || name.hasPrefix("special_") || name.hasPrefix("sort_") {
                    sortedChildren.append(c)
                }
            }
        }
//        self.enumerateChildNodesWithName("mob_*", usingBlock: { node, stop in sortedChildren.append(node) })
//        self.enumerateChildNodesWithName("special_*", usingBlock: { node, stop in sortedChildren.append(node) })
//        self.enumerateChildNodesWithName("sort_*", usingBlock: { node, stop in sortedChildren.append(node) })
        sortedChildren = sortedChildren.sorted(by: {s1, s2 in return s1.position.y <  s2.position.y})
        var zStart = CGFloat(1000.0)
        for node in sortedChildren {
            node.zPosition = zStart
            zStart -= 1.0
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact)
    {
        var mob: Mob!
        var teenyBoy: Mob!
        var scene: SKScene!
        var special: Special!
        var mobKiller: SKNode!
        
        #if DEBUG
        if movementPaused {return}
        #endif

        if contact.bodyA.categoryBitMask == category.teenyBoy {
            teenyBoy = contact.bodyA.node!.parent as! Mob
        }
        else if contact.bodyB.categoryBitMask == category.teenyBoy {
            teenyBoy = contact.bodyB.node!.parent as! Mob
        }
        
        if contact.bodyA.categoryBitMask == category.mob {
            mob = contact.bodyA.node!.parent as! Mob
        }
        else if contact.bodyB.categoryBitMask == category.mob {
            mob = contact.bodyB.node!.parent as! Mob
        }
        
        if contact.bodyA.categoryBitMask == category.sceneBorder {
            scene = contact.bodyA.node! as! SKScene
        }
        else if contact.bodyB.categoryBitMask == category.sceneBorder {
            scene = contact.bodyB.node! as! SKScene
        }
        
        if contact.bodyA.categoryBitMask == category.special {
            special = contact.bodyA.node!.parent as! Special
        }
        else if contact.bodyB.categoryBitMask == category.special {
            special = contact.bodyB.node!.parent as! Special
        }
        
        if contact.bodyA.categoryBitMask == category.mobKiller {
            mobKiller = contact.bodyA.node!.parent
        }
        else if contact.bodyB.categoryBitMask == category.mobKiller {
            mobKiller = contact.bodyB.node!.parent
        }
        
        if mob != nil && teenyBoy != nil
        {
            let mobHealth = mob.health
            let tinyBoyHealth = tinyBoy.health
            
            if mob.level == tinyBoy.level {
                mob.health -= tinyBoy.damage
                if  tinyBoy.health < tinyBoy.maxHealthForLevel {
                    tinyBoy.health -= mob.damage
                }
            } else if mob.level < tinyBoy.level {
                mob.health -= tinyBoy.damage
            } else if mob.level > tinyBoy.level {
                tinyBoy.health -= mob.damage
                if mob.level - tinyBoy.level < 3 {
                    mob.health -= tinyBoy.damage
                }
            }
            if tinyBoy.health < 0 {
                tinyBoy.health = 0
            }
            
            if mobHealth != mob.health {
                floatNumber (mob, number: mob.health - mobHealth, direction: Direction.right)
            }
            
            if tinyBoyHealth != tinyBoy.health {
                floatNumber (teenyBoy, number: tinyBoy.health - tinyBoyHealth, direction: Direction.left)
            }
            
            let mobPoint = mob.position
            let teenyPoint = teenyBoy.position
            
            let newTeenyBoyPoint = knockback(mobPoint, victim: teenyPoint, magnitude: 0.75)
            let newMobPoint = knockback(teenyPoint, victim: mobPoint, magnitude: 0.75)

            if mob.health <= 0 {
                tinyBoy.level += mob.experience
                mob.removeFromParent()
                let poof = Poof()
                poof.poof(self, position: mobPoint, scale: 0.50)
            } else {
                mob.removeAllActions()
                mob.run(SKAction.move(to: newMobPoint, duration: 0.1), completion: mob.move)
            }
            
            if tinyBoy.health <= 0 {
                
                teenyBoy.removeFromParent()
                
                let tombstone = Tombstone()
                tombstone.position = teenyPoint
                addChild(tombstone)
                
                tinyBoyCloud = TinyBoyCloud (scene: self, scale: 0.33, position: teenyPoint)
                tinyBoyCloud!.run(SKAction.scale(to: 6.0, duration: 1.0))
                tinyBoyCloud!.run(SKAction.move(to: CGPoint(x: frame.width / 2, y: frame.height / 2), duration: 1.0))
                tinyBoyCloud!.run(SKAction.rotate(byAngle: 0.26175, duration: 1.0), completion: swayTinyCloudBoy)
                
            } else {
                // continue up the board
                teenyBoy.removeAllActions()
                teenyBoy.run(SKAction.move(to: newTeenyBoyPoint, duration: 0.1), completion: teenyBoy.move)
            }
            
            tinyStatBoard!.updateLevel(Int(tinyBoy.level))
            tinyStatBoard!.updateHealth(tinyBoy.health, maximumHealth: tinyBoy.maxHealthForLevel)
            tinyStatBoard!.updateScore(tinyBoy.score)
        }
        else if mob != nil && mobKiller != nil
        {
            tinyBoy.level += mob.experience
            
            mob.removeFromParent()
            let poof = Poof()
            poof.poof(self, position: mob.position, scale: 0.50)
            
            tinyStatBoard!.updateLevel(Int(tinyBoy.level))
            tinyStatBoard!.updateScore(tinyBoy.score)
        }
        else if (scene != nil)
        {
            if contact.contactPoint.y > scene.frame.origin.y + scene.frame.height {
                
                let reveal = SKTransition.push(with: SKTransitionDirection.down, duration:2.0)
                // Change to the next scene
                if let borderCollisionFunc = sceneBorderCollision {
                    borderCollisionFunc (teenyBoy)
                } else {
                    // go to the next scene
                    view!.presentScene(LevelOne(size: gameSize), transition: reveal)
                }
                
            } else {
                var bounceOff = 0.0
                if contact.contactPoint.x < scene.frame.origin.x {
                    bounceOff = 75.0
                }
                if contact.contactPoint.x > scene.frame.origin.x + scene.frame.width {
                    bounceOff = -75.0
                }
                if bounceOff != 0.0 {
                    teenyBoy.removeAllActions()
                    teenyBoy.run(SKAction.moveBy(x: CGFloat(bounceOff), y: 0.0, duration: 0.1), completion: teenyBoy.move)
                }
            }
        }
        else if (special != nil)
        {
            special.invoke(teenyBoy)
        }
    }
    
    func swayTinyCloudBoy ()
    {
        let sequence = SKAction.sequence([
            SKAction.rotate(byAngle: -0.5235, duration: 2.0),
            SKAction.rotate(byAngle: 0.5235, duration: 2.0)
            ])
        
        tinyBoyCloud!.run(SKAction.repeatForever(sequence))
    }
    
    func didEnd(_ contact: SKPhysicsContact)
    {
    }
    
    func teenyBoyBeginsQuest (_ teenBoy: Mob)
    {
    }
    
    
}
