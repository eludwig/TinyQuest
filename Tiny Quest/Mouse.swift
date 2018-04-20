//
//  Mouse.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 7/15/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

class Mouse : Mob
{
    required init(coder: NSCoder)
    {
        fatalError("NSCoding not supported")
    }
    
    init(limitRect: CGRect)
    {
        super.init(mobName: "Mouse",
            director: SimpleXAndYMovement(unitsPerSecond: 300.0),
            limitRect: limitRect,
            categoryBitMap: category.mob,
            contactBitMap: category.none)
        
        addSprite(Direction.up,
            bodyTextures: [mobAtlas.textureNamed("MouseUp1"), mobAtlas.textureNamed("MouseUp2")],
            eyeTextures: nil,
            eyeScale: 0.0,
            eyePos: CGPoint(x: 0.0, y: 0.0),
            shadowTexture: mobAtlas.textureNamed("Shadow"),
            shadowPos: CGPoint(x: 0.0, y: 0.0))
        addSprite(Direction.down,
            bodyTextures: [mobAtlas.textureNamed("MouseDown1"), mobAtlas.textureNamed("MouseDown2")],
            eyeTextures: eyeBank.tallEyeTextures,
            eyeScale: 0.18,
            eyePos: CGPoint(x: 0.0, y: 40.0),
            shadowTexture: mobAtlas.textureNamed("Shadow"),
            shadowPos: CGPoint(x: 0.0, y: 0.0))
        addSprite(Direction.left,
            bodyTextures: [mobAtlas.textureNamed("MouseLeft1"), mobAtlas.textureNamed("MouseLeft2")],
            eyeTextures: eyeBank.eyesSideLeftTextures,
            eyeScale: 0.20,
            eyePos: CGPoint(x: -20.0, y: 38.0),
            shadowTexture: mobAtlas.textureNamed("Shadow"),
            shadowPos: CGPoint(x: 0.0, y: 0.0))
        addSprite(Direction.right,
            bodyTextures: [mobAtlas.textureNamed("MouseRight1"), mobAtlas.textureNamed("MouseRight2")],
            eyeTextures: eyeBank.eyesSideRightTextures,
            eyeScale: 0.20,
            eyePos: CGPoint(x: 20.0, y: 38.0),
            shadowTexture: mobAtlas.textureNamed("Shadow"),
            shadowPos: CGPoint(x: 0.0, y: 0.0))
    }
    
    override func move()
    {
        let (newPoint, newDirection, newDuration) = movementDirector.getNextMovement(position, limitRect: limitRect)
        
        self.run(
            SKAction.sequence([
                SKAction.run({self.setDirection(newDirection)}),
                SKAction.move(to: newPoint, duration: Double(newDuration)),
                SKAction.run({
                    if let body = self.childNode(withName: "body") {
                        body.removeAllActions()
                    }}),
                SKAction.wait(forDuration: randD(1.0, high: 3.0))
                ]),
            completion: move)
    }
}
