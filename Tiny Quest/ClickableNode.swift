//
//  ClickableNode.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 9/7/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

class ClickableNode : SKNode
{
    let sprite: SKSpriteNode
    let click: ()->()
    
    init (sprite: SKSpriteNode, onClick: @escaping ()->())
    {
        self.sprite = sprite
        click = onClick
        super.init()
        isUserInteractionEnabled = true
        addChild(sprite)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with withEvent: UIEvent?)
    {
        click()
    }

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
