//
//  GameView.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 6/18/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

#if DEBUG
let debugAtlas = SKTextureAtlas(named:"Debug")
#endif

// globals for the entire game
let category = Category()
let eyeBank = EyeBank()
let commonAtlas =  SKTextureAtlas(named:"Common")
let mobAtlas =  SKTextureAtlas(named:"Mob")
let tinyBoyAtlas =  SKTextureAtlas(named:"TinyBoy")
let backgroundAtlas =  SKTextureAtlas(named:"Background")
let tinyBoy = TinyBoy()
var tinyBoyCloud: TinyBoyCloud?
var gameView: GameView?

class GameView: SKView
{
    var startTouchPosition: CGPoint?
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    override func awakeFromNib()
    {
        /*
        self.showsDrawCount = true
        self.showsNodeCount = true
        self.showsFPS = true
        */
        gameView = self;
        presentScene(LevelOne(size: gameSize))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with withEvent: UIEvent?)
    {
        // we are looking to drag tinyboy from side to side
        if let tinyBoy = scene!.childNode(withName: "TinyBoy") {
            // get the touch
            let aTouch:UITouch = (touches.first! as UITouch)
            // translate the touch point from view to scene coords
            var aPoint = aTouch.location(in: self)
            aPoint = convert(aPoint, to: scene!)
            let node = scene!.atPoint (aPoint)
            
            if node == tinyBoy || node.inParentHierarchy(tinyBoy)
            {
                startTouchPosition = aPoint;
            }
        }
        if startTouchPosition == nil {
            super.touchesBegan(touches, with: withEvent)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with withEvent: UIEvent?)
    {
        if let _ = startTouchPosition {
            // get the touch
            let aTouch:UITouch = (touches.first! as UITouch)
            // translate the touch point from view to scene coords
            var aPoint = aTouch.location(in: self)
            aPoint = convert(aPoint, to: scene!)
            let tinyBoy = scene!.childNode(withName: "TinyBoy")
            if (tinyBoy != nil)
            {
                tinyBoy!.position.x = aPoint.x;
            }
        } else {
            super.touchesMoved(touches, with: withEvent)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with withEvent: UIEvent?)
    {
        if tinyBoyCloud != nil {
            presentScene(LevelOne(size: gameSize))
        } else if let _ = startTouchPosition {
            startTouchPosition = nil
            if let tinyBoy = scene!.childNode(withName: "TinyBoy")
            {
                tinyBoy.run(SKAction.scale(to: 0.66, duration: 1.0), completion:startTeenyBoy)
            }
        } else {
            super.touchesEnded(touches, with: withEvent)
        }
    }
    
    func startTeenyBoy ()
    {
        var tinyPos = CGPoint()
        if let tinyBoy = scene!.childNode(withName: "TinyBoy")
        {
            tinyPos = tinyBoy.position
            tinyBoy.removeFromParent()
        }
        let teenyBoy = TeenyBoyCloth (limitRect: scene!.frame)
        teenyBoy.position = tinyPos
        teenyBoy.xScale = 0.50
        teenyBoy.yScale = 0.50
        scene!.addChild (teenyBoy)
        teenyBoy.addPhysics()
        teenyBoy.move()
        let gameScene = scene as! GameScene
        gameScene.teenyBoyBeginsQuest (teenyBoy)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder);
    }
}
