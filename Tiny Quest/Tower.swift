//
//  Tower.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 8/7/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

class Tower : Special
{
    var charger: Charger?
    
    required init(coder: NSCoder)
    {
        fatalError("NSCoding not supported")
    }
    
    init ()
    {
        super.init(specialName: "Tower")
        
        let special = addSprite (SKSpriteNode(texture: levelOneAtlas.textureNamed("Tower")))
        
        let shadowSprite = SKSpriteNode (texture: mobAtlas.textureNamed("Shadow"))
        shadowSprite.name = "shadow"
        shadowSprite.zPosition = -1
        shadowSprite.xScale = 1.2
        shadowSprite.yScale = 2.0
        shadowSprite.position = CGPoint(x: 0.0, y: 10.0)
        special.addChild(shadowSprite)
        
        let towerOverlay = SKSpriteNode (texture: levelOneAtlas.textureNamed("TowerOverTop"))
        towerOverlay.name = "towerOverlay"
        towerOverlay.zPosition = 2000
        towerOverlay.anchorPoint = CGPoint(x: 0.5,y: 0.0)
        towerOverlay.position = CGPoint(x: 0.0, y: 0.0)
        special.addChild(towerOverlay)
    }
    
    override func invoke(_ teenyBoy: Mob)
    {
        let gameScene = scene as! GameScene
        // here we will create and execute the animation steps for the charger animation
        let towerPoint = position
        let teenyPoint = teenyBoy.position
        
        var xDiff = towerPoint.x - teenyPoint.x
        if xDiff < 0 {
            xDiff = -xDiff
        }
        if xDiff > 10 {
            let newTeenyBoyPoint = knockback(towerPoint, victim: teenyPoint, magnitude: 1.0)
            teenyBoy.removeAllActions()
            teenyBoy.run(SKAction.move(to: newTeenyBoyPoint, duration: 0.1), completion: teenyBoy.move)
        } else {
            // override the standard "present the next level" logic
            // we are taking over the duties for it and will change the level when
            // th charger is done rampaging!
            gameScene.sceneBorderCollision = chargerStart
        }
    }
    
    func chargerStart (_ teenyBoy: Mob)
    {
        // do the charger animation
        teenyBoy.removeFromParent()
        let special = childNode(withName: "special") as! SKSpriteNode?
        
        // calculate the route (6 points)
        //         T
        //         .
        //       . . .
        //
        //       .   .
        
        var points = [CGPoint]()
        points.append(CGPoint(x: position.x, y: 1000.0))
        points.append(CGPoint(x: 150.0, y: 1000.0))
        points.append(CGPoint(x: 150.0, y: 300.0))
        points.append(CGPoint(x: 600.0, y: 300.0))
        points.append(CGPoint(x: 600.0, y: 1000.0))
        points.append(CGPoint(x: position.x, y: 1000.0))
        points.append(position)
        
        charger = Charger(limitRect: CGRect(x: 0, y: 0, width: gameSize.width, height: gameSize.height), points: points, isDone: self.chargerDone)
        charger!.setScale(1.1)
        charger!.position = self.position
        charger!.addPhysics()
        
        run(SKAction.sequence([
            SKAction.wait(forDuration: 0.5),
            SKAction.run({special?.texture = levelOneAtlas.textureNamed("TowerClosed")}),
            SKAction.wait(forDuration: 1.0),
            SKAction.run({
                special?.texture = levelOneAtlas.textureNamed("Tower")
                self.scene!.addChild(self.charger!)
                self.charger!.move()
            })
            ]))
    }
    
    func chargerDone ()
    {
        charger!.removeFromParent()
        let special = childNode(withName: "special")as! SKSpriteNode?
        run(SKAction.sequence([
            SKAction.wait(forDuration: 0.5),
            SKAction.run({special?.texture = levelOneAtlas.textureNamed("TowerClosed")}),
            SKAction.wait(forDuration: 0.5),
            SKAction.run({
                let reveal = SKTransition.push(with: SKTransitionDirection.down, duration:2.0)
                // Change to the next scene
                gameView!.presentScene(LevelOne(size: gameSize), transition: reveal)
            })
        ]))
    }
}

