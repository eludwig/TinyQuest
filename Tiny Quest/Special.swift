//
//  Special.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 7/23/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

class Special : MovableNode
{
    var categoryBitMap: UInt32 = category.none
    var contactBitMap: UInt32 = category.none
    
    required init(coder: NSCoder)
    {
        fatalError("NSCoding not supported")
    }
    
    init (specialName: String, categoryBitMap: UInt32 , contactBitMap: UInt32)
    {
        self.categoryBitMap = categoryBitMap
        self.contactBitMap = contactBitMap
        super.init()
        name = "special_" + specialName
    }
    
    init (specialName: String)
    {
        super.init()
        name = "special_" + specialName
    }
    
    func addSprite(_ special: SKSpriteNode) ->SKSpriteNode
    {
        special.anchorPoint = CGPoint(x: 0.5,y: 0.0)
        special.name = "special"
        addChild(special)
        return special
    }
    
    func addPhysics(_ special: SKSpriteNode)
    {
        if !(special.physicsBody != nil) {
            let radiusY = special.size.height / 2.0
            let radiusX = special.size.width / 2.0
            special.physicsBody = SKPhysicsBody(circleOfRadius: radiusY < radiusX ? radiusY : radiusX,
                center: CGPoint(x: 0.0,y: radiusY))
            special.physicsBody!.collisionBitMask = 0
            special.physicsBody!.categoryBitMask = category.special
            special.physicsBody!.contactTestBitMask = category.none
        }
    }
    
    func addPhysics ()
    {
        if let special = childNode(withName: "special") {
            addPhysics(special as! SKSpriteNode)
        }
    }
    
    func invoke (_ teenyBoy: Mob)
    {
        _ = scene as! GameScene
    }
}
