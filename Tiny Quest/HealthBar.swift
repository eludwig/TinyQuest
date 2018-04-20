//
//  HealthBar.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 8/14/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

class HealthBar : SKNode
{
    var maximumHealth: Int = 1;
    var currentHealth: Int = 1;
    
    var outline: SKShapeNode
    var inside: SKShapeNode
    
    required init(coder: NSCoder)
    {
        fatalError("NSCoding not supported")
    }
    
    override init ()
    {
        outline = SKShapeNode()
        let rect = CGRect(x: 0, y: 0, width: 100, height: 16)
        let path = CGMutablePath()
        path.addRect(rect)
        outline.path = path

        outline.lineWidth = 2.0
        outline.fillColor = SKColor.white
        outline.strokeColor = SKColor.black
        outline.glowWidth = 0.0
        outline.zPosition = 0

        inside = SKShapeNode()
        inside.lineWidth = 1.0
        inside.fillColor = SKColor.red
        inside.strokeColor = SKColor.clear
        inside.zPosition = 1

        super.init()
        
        updateHealth()
        addChild(outline)
        addChild(inside)
    }
    
    func updateHealth ()
    {
        inside.path = getHealthPath()
    }
    
    func getHealthPath() ->CGPath
    {
        let path = CGMutablePath()
        let rect = CGRect(x: 4.0, y: 4.0, width: CGFloat(currentHealth) * 92.0 / CGFloat(maximumHealth), height: 8.0)
        path.addRect(rect)
        return path
    }
}
