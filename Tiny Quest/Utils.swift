//
//  Utils.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 6/23/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

// return random Double between 0.0 && .999999~
func randD() ->Double
{
    return Double(arc4random()) / Double(UINT32_MAX)
}

//------------------------------------------

// return random Double (val >= low && val < max)
func randD(_ low:Double, high:Double) ->Double
{
    return randD() * (high - low) + low
}

//------------------------------------------

// return random Double (val >= low && val < max)
func randCG(_ low:CGFloat, high:CGFloat) ->CGFloat
{
    let rand = CGFloat(randD())
    return CGFloat(rand * (high - low) + low)
}

//------------------------------------------

// return random Int (val >= low && val < max)
func randInt(_ low:Double, high:Double) ->Int
{
    return Int(randD(low, high: high))
}

//------------------------------------------

// return random Int (val >= low && val < max)
func randInt(_ low:Int, high:Int) ->Int
{
    return Int(randD(Double(low), high: Double(high)))
}

//------------------------------------------

func randCGPoint (_ limitRect: CGRect) ->CGPoint
{
    var newPoint = CGPoint()
    newPoint.x = CGFloat(randD(Double(limitRect.origin.x), high: Double(limitRect.origin.x + limitRect.width)))
    newPoint.y = CGFloat(randD(Double(limitRect.origin.y), high: Double(limitRect.origin.y + limitRect.height)))
    return newPoint
}

//------------------------------------------

func directions () -> [Direction]
{
    return [Direction.down, Direction.up, Direction.left, Direction.right]
}

//------------------------------------------

func rectanglesInRect (_ rect: CGRect, rows: Int, columns: Int, gutter: Double) ->[CGRect]
{
    var result = [CGRect]()
    
    let height = CGFloat(rect.size.height) / CGFloat(rows)
    let width = CGFloat(rect.size.width) / CGFloat(columns)
    
    for i in 0..<rows {
        for j in 0..<columns {
            let x = rect.origin.x + (CGFloat(j) * width + CGFloat(gutter))
            let y = rect.origin.y + (CGFloat(i) * height + CGFloat(gutter))
            result.append(CGRect(x: x, y: y, width: width - CGFloat(gutter * 2), height: height - CGFloat(gutter * 2)))
        }
    }
    return result
}

//------------------------------------------

func hexToUIColor (_ hex: Int, alpha: Double = 1.0) -> UIColor
{
    let red = Double((hex & 0xFF0000) >> 16) / 255.0
    let green = Double((hex & 0xFF00) >> 8) / 255.0
    let blue = Double((hex & 0xFF)) / 255.0
    let color: UIColor = UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha:CGFloat(alpha))
    return color
}

//------------------------------------------

func floatNumber (_ node: SKNode!, number: Int, direction: Direction)
{
    if (number != 0) {
        let textNode = SKLabelNode (fontNamed: "Verdana-BoldItalic")
        textNode.text = number > 0 ? "+" + String(number) : String(number)
        textNode.fontSize = 24
        textNode.fontColor = hexToUIColor (number > 0 ? 0x90fe98 : 0xff9a92, alpha: 1.0)
        textNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        textNode.verticalAlignmentMode = SKLabelVerticalAlignmentMode.baseline
        textNode.zPosition = 5000
        
        let rect = node.calculateAccumulatedFrame()
        var vector: CGVector
        
        switch direction {
            case Direction.up:
                textNode.position = CGPoint(x: node.position.x, y: node.position.y + (rect.size.height) + 10)
                vector = CGVector(dx: 0.0, dy: 50.0)
            case Direction.down:
                textNode.position = CGPoint(x: node.position.x, y: node.position.y + 10)
                vector = CGVector(dx: 0.0, dy: -50.0)
            case Direction.left:
                textNode.position = CGPoint(x: node.position.x - ((rect.size.width / 2) + 10), y: node.position.y + (rect.size.height / 2))
                vector = CGVector(dx: -50.0, dy: 0.0)
            case Direction.right:
                textNode.position = CGPoint(x: node.position.x + ((rect.size.width / 2) + 10), y: node.position.y + (rect.size.height / 2))
                vector = CGVector(dx: 50.0, dy: 0.0)
        }
        
        node!.scene!.addChild(textNode)
        
        textNode.run(SKAction.fadeOut(withDuration: 1.0))
        textNode.run(SKAction.sequence([
            SKAction.move(by: vector, duration: 1.0),
            SKAction.run({textNode.removeFromParent()})
            ]))
    }
}

//------------------------------------------

func rotate (_ startPoint: CGPoint, newPosition: CGPoint) -> CGFloat
{
    let dx = newPosition.x - startPoint.x
    let dy = newPosition.y - startPoint.y
    var theta: CGFloat
    
    if dy > 0 {
        theta = atan (abs(dx) / abs(dy))
    } else {
        theta = atan (abs(dy) / abs(dx)) + 1.57079632679
    }
    if dx > 0 {
        theta = -theta
    }
    
    return theta
}

//------------------------------------------

func knockback (_ anchor: CGPoint, victim: CGPoint, magnitude: Double) -> CGPoint
{
    var newVictimPoint = CGPoint(x: 0.0, y: 0.0)
    
    let xDiff = Double(anchor.x - victim.x)
    let yDiff = Double(anchor.y - victim.y)
    
    let victimDeltaX = xDiff * magnitude
    let victimDeltaY = yDiff * magnitude
    
    newVictimPoint.x = victim.x - CGFloat(victimDeltaX)
    newVictimPoint.y = victim.y - CGFloat(victimDeltaY)
    
    return newVictimPoint
}

//------------------------------------------

func removeActions(_ node: SKNode)
{
    node.removeAllActions()
    for child in node.children {
        removeActions(child )
    }
}
