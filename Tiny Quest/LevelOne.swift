//
//  LevelOne.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 6/24/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import Foundation

import UIKit
import SpriteKit

// globals for individual level
let levelOneAtlas =  SKTextureAtlas(named:"LevelOne")

class LevelOne: GameScene
{
    override func createSceneContents ()
    {
        tinyBoy.reset ()
        super.createSceneContents()
        createBackground ()
        
        bgSound = URL(fileURLWithPath: Bundle.main.path(forResource: "LevelOneBGLoop", ofType: "mp3")!)

        var r = CGRect(x: frame.origin.x + 5.0, y: 125, width: frame.width - 10.0, height: 250)
        for _ in 0 ..< 7
        {
            let dustMote = DustMote (limitRect: r)
            addChild(dustMote)
            dustMote.position = randCGPoint (r);
            dustMote.setScale(0.7)
            dustMote.move()
            dustMote.level = 1
            dustMote.health = 1
            dustMote.damage = 1
            dustMote.experience = 0.50
            dustMote.addPhysics()
        }
        r = CGRect(x: frame.origin.x + 5.0, y: 250, width: frame.width - 10.0, height: 300)
        for _ in 0 ..< 7
        {
            let mouse = Mouse (limitRect: r)
            addChild(mouse)
            mouse.position = randCGPoint (r);
            mouse.setScale(0.7)
            mouse.move()
            mouse.level = 1
            mouse.health = 1
            mouse.damage = 1
            mouse.experience = 0.50
            mouse.addPhysics()
        }
        r = CGRect(x: frame.origin.x + 5.0, y: 400, width: frame.width - 10.0, height: 250)
        for _ in 0 ..< 6
        {
            let batBoy = BatBoy (limitRect: r)
            addChild(batBoy)
            batBoy.position = randCGPoint (r);
            batBoy.move()
            batBoy.level = 2
            batBoy.health = 1
            batBoy.damage = 2
            batBoy.experience = 0.50
            batBoy.addPhysics()
        }
        r = CGRect(x: frame.origin.x + 5.0, y: 500, width: frame.width - 10.0, height: 200)
        for _ in 0 ..< 5
        {
            let snake = Snake (limitRect: r)
            addChild(snake)
            snake.position = randCGPoint (r);
            snake.setScale(0.8)
            snake.move()
            snake.level = 3
            snake.health = 2
            snake.damage = 2
            snake.experience = 0.75
            snake.addPhysics()
        }
        r = CGRect(x: frame.origin.x + 5.0, y: 700, width: frame.width - 10.0, height: 250)
        for _ in 0 ..< 5
        {
            let goblin = Goblin (limitRect: r)
            addChild(goblin)
            goblin.position = randCGPoint (r);
            goblin.move()
            goblin.level = 6
            goblin.health = 2
            goblin.damage = 2
            goblin.experience = 1.0
            goblin.addPhysics()
        }
        r = CGRect(x: frame.origin.x + 5.0, y: 900, width: frame.width - 10.0, height: 250)
        for _ in 0 ..< 4
        {
            let unicorn = Unicorn (limitRect: r)
            addChild(unicorn)
            unicorn.position = randCGPoint (r);
            unicorn.move()
            unicorn.level = 8
            unicorn.health = 2
            unicorn.damage = 2
            unicorn.experience = 1.34
            unicorn.addPhysics()
        }
        r = CGRect(x: frame.origin.x + 5.0, y: 250, width: frame.width - 10.0, height: 400)
        var rects = rectanglesInRect (r, rows: 1, columns: 5, gutter: 20.0)
        for i in 0 ..< 5
        {
            let heart = Heart (healthReplenished: 2)
            addChild(heart)
            heart.setScale(0.50)
            heart.position = randCGPoint (rects[i]);
            heart.addPhysics()
        }
        r = CGRect(x: frame.origin.x + 5.0, y: 700, width: frame.width - 10.0, height: 400)
        rects = rectanglesInRect (r, rows: 1, columns: 3, gutter: 20.0)
        for i in 0 ..< 3
        {
            let heart = Heart (healthReplenished: 4)
            addChild(heart)
            heart.setScale(0.50)
            heart.position = randCGPoint (rects[i]);
            heart.addPhysics()
        }
        r = frame
        r.size.height /= 3.33
        r.origin.y += r.size.height * 2.0
        r = r.insetBy(dx: 20.0, dy: 50.0)
        rects = rectanglesInRect (r, rows: 1, columns: 5, gutter: 20.0)
        for i in 0 ..< 5
        {
            let teleport = Teleport ()
            addChild(teleport)
            teleport.setScale(0.70)
            teleport.position = randCGPoint (rects[i])
            teleport.addPhysics()
        }
        
        let tower = Tower ()
        addChild(tower)
        tower.setScale(1.1)
        tower.position = CGPoint(x: frame.origin.x + (frame.size.width / 2),
            y: frame.origin.y + frame.size.height - 140)
        tower.addPhysics()
    }
    
    override func update(_ currentTime: TimeInterval)
    {
        super.update(currentTime)
    }
    
    override func teenyBoyBeginsQuest (_ teenBoy: Mob)
    {
        if randD() < 0.33
        {
            let r = CGRect(x: frame.origin.x + 5.0, y: 600, width: frame.width - 10.0, height: 300)
            let griffon = Griffon(limitRect: r)
            addChild(griffon)
            // start him off stage left
            griffon.position = CGPoint(x: -60.0, y: frame.size.height * 0.75)
            griffon.setScale(1.7)
            griffon.move()
            griffon.level = 15
            griffon.health = 4
            griffon.damage = 4
            griffon.experience = 3.0
            griffon.addPhysics()
        }
    }
    
    func createBackground()
    {
        // place big green square
        let backGroundSprite = SKSpriteNode (texture: backgroundAtlas.textureNamed("LevelOneBG"))
        backGroundSprite.position = CGPoint(x: self.frame.midX,y: frame.midY)
        backGroundSprite.xScale = 2.4
        backGroundSprite.yScale = 2.4
        backGroundSprite.zPosition = -2
        addChild(backGroundSprite)
        
        // flowers and foliage
        var rects: [CGRect]
        
        rects = rectanglesInRect (frame, rows: 5, columns: 1, gutter: 30.0)
        
        for j in 1...9 {
        
            for i in 0..<rects.count {
                let sprite = SKSpriteNode (texture: levelOneAtlas.textureNamed("Foliage" + String(j)))
                sprite.position = randCGPoint(rects[i])
                sprite.xScale = 1.5
                sprite.yScale = 1.5
                sprite.zPosition = -1
                addChild(sprite)
            }
        }
        
        rects = rectanglesInRect (frame, rows: 3, columns: 3, gutter: 30.0)
        
        for i in 0..<rects.count {
            let sprite = SKSpriteNode (texture: levelOneAtlas.textureNamed("Flowers" + String(randInt(1, high: 4))))
            sprite.position = randCGPoint(rects[i])
            sprite.xScale = 0.7
            sprite.yScale = 0.7
            sprite.zPosition = -1
            addChild(sprite)
        }
        
        
        var r = frame
        r = r.insetBy(dx: 20.0, dy: 50.0)
        rects = rectanglesInRect (r, rows: 3, columns: 1, gutter: 20.0)
        for i in 0..<3
        {
            let butterfly = Butterfly(limitRect: rects[i])
            var p: CGPoint
            p = randCGPoint (rects[i])
            butterfly.position = p
            addChild(butterfly)
            butterfly.move()
        }
        
        /*
        // lay down the broken pillars/blocks
        var rubble = [SKTexture]()
        rubble += levelOneAtlas.textureNamed("BrokenBlock1")
        rubble += levelOneAtlas.textureNamed("BrokenBlock3")
        rubble += levelOneAtlas.textureNamed("BrokenPillar")
        rubble += levelOneAtlas.textureNamed("BrokenBlock2")
        rubble += levelOneAtlas.textureNamed("BrokenBlock3")
        rubble += levelOneAtlas.textureNamed("BrokenWall")
        
        var frameleft = CGRectMake(frame.origin.x - 15, frame.origin.y, 40, frame.size.height)
        rects = rectanglesInRect (frameleft, 12, 1, 10.0)
        var j = 0
        for var i = rects.count - 1; i >= 0; i-- {
            let sprite = SKSpriteNode (texture: rubble[j++])//randInt(0, 5)
            if j >= rubble.count {j = 0}
            sprite.position = randCGPoint(rects[i])
            sprite.xScale = 1.2 // randD(0, 1) >= 0.5 ? -1.5 : 1.5
            sprite.yScale = 1.2
            sprite.zPosition = -1
            addChild(sprite)
        }
        frameleft = CGRectMake(frame.origin.x + frame.size.width - 30, frame.origin.y, 40, frame.size.height)
        rects = rectanglesInRect (frameleft, 12, 1, 10.0)
        j = 0
        for var i = rects.count - 1; i >= 0; i-- {
            let sprite = SKSpriteNode (texture: rubble[j++])//randInt(0, 5)
            if j >= rubble.count {j = 0}
            sprite.position = randCGPoint(rects[i])
            sprite.xScale = 1.2 // randD(0, 1) >= 0.5 ? -1.5 : 1.5
            sprite.yScale = 1.2
            sprite.zPosition = -1
            addChild(sprite)
        }
        */
    }
}
