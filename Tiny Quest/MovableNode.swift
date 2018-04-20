//
//  MovableNode.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 9/9/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

class MovableNode : SKNode
{
    override init ()
    {
        super.init()
        isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with withEvent: UIEvent?)
    {
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with withEvent: UIEvent?)
    {
        #if DEBUG
        if movementPaused {
            // get the touch
            let aTouch:UITouch = touches.anyObject() as UITouch
            var aPoint = aTouch.locationInView(gameView)
            position = gameView!.convertPoint(aPoint, toScene: scene!)
        }
        #endif
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with withEvent: UIEvent?)
    {
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
