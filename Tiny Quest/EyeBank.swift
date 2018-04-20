//
//  EyeBank.swift
//  Tiny Quest
//
//  Created by Ed Ludwig on 7/1/14.
//  Copyright (c) 2014 Scorpion Software LLC. All rights reserved.
//

import UIKit
import SpriteKit

class EyeBank
{
    var googlyEyesFrontLookAhead: SKTexture
    var googlyEyesFrontLookLeft: SKTexture
    var googlyEyesFrontLookRight: SKTexture
    var googlyEyesFrontClosed: SKTexture
    var googlyEyeTextures = [SKTexture]()
    
    var tallEyesFrontLookAhead: SKTexture
    var tallEyesFrontLookLeft: SKTexture
    var tallEyesFrontLookRight: SKTexture
    var tallEyesFrontClosed: SKTexture
    var tallEyeTextures = [SKTexture]()
    
    var scaryEyesFrontLookAhead: SKTexture
    var scaryEyesFrontClosed: SKTexture
    var scaryEyeTextures = [SKTexture]()
    
    var tinyBoyEyesUp: SKTexture
    var tinyBoyEyesLeft: SKTexture
    var tinyBoyEyesRight: SKTexture
    var tinyBoyEyesStraight: SKTexture
    var tinyBoyEyesClosed: SKTexture
    var tinyBoyEyeTextures = [SKTexture]()
    
    var eyesSideLeft: SKTexture
    var eyesSideRight: SKTexture
    var eyesSideLeftClosed: SKTexture
    var eyesSideRightClosed: SKTexture
    var eyesSideLeftTextures = [SKTexture]()
    var eyesSideRightTextures = [SKTexture]()
    
    init ()
    {
        let eyeBankAtlas =  SKTextureAtlas(named:"EyeBank")
        
        googlyEyesFrontLookAhead = eyeBankAtlas.textureNamed("googly_open")
        googlyEyesFrontLookLeft = eyeBankAtlas.textureNamed("googly_open_left")
        googlyEyesFrontLookRight = eyeBankAtlas.textureNamed("googly_open_right")
        googlyEyesFrontClosed = eyeBankAtlas.textureNamed("googly_closed")
        
        // build plain array for randomizing
        googlyEyeTextures.append(googlyEyesFrontLookAhead)
        googlyEyeTextures.append(googlyEyesFrontLookLeft)
        googlyEyeTextures.append(googlyEyesFrontLookRight)
        googlyEyeTextures.append(googlyEyesFrontClosed)
        
        tallEyesFrontLookAhead = eyeBankAtlas.textureNamed("tall_open")
        tallEyesFrontLookLeft = eyeBankAtlas.textureNamed("tall_open_left")
        tallEyesFrontLookRight = eyeBankAtlas.textureNamed("tall_open_right")
        tallEyesFrontClosed = eyeBankAtlas.textureNamed("tall_closed")
        
        // build plain array for randomizing
        tallEyeTextures.append(tallEyesFrontLookAhead)
        tallEyeTextures.append(tallEyesFrontLookLeft)
        tallEyeTextures.append(tallEyesFrontLookRight)
        tallEyeTextures.append(tallEyesFrontClosed)
        
        scaryEyesFrontLookAhead = eyeBankAtlas.textureNamed("scary_open")
        scaryEyesFrontClosed = eyeBankAtlas.textureNamed("scary_closed")
        
        scaryEyeTextures.append(scaryEyesFrontLookAhead)
        scaryEyeTextures.append(scaryEyesFrontClosed)
        
        tinyBoyEyesStraight = tinyBoyAtlas.textureNamed("TinyBoyEyesStraight")
        tinyBoyEyesUp = tinyBoyAtlas.textureNamed("TinyBoyEyesUp")
        tinyBoyEyesLeft = tinyBoyAtlas.textureNamed("TinyBoyEyesLeft")
        tinyBoyEyesRight = tinyBoyAtlas.textureNamed("TinyBoyEyesRight")
        tinyBoyEyesClosed = tinyBoyAtlas.textureNamed("TinyBoyEyesBlink")
        
        tinyBoyEyeTextures.append(tinyBoyEyesStraight)
        tinyBoyEyeTextures.append(tinyBoyEyesLeft)
        tinyBoyEyeTextures.append(tinyBoyEyesRight)
        tinyBoyEyeTextures.append(tinyBoyEyesUp)
        tinyBoyEyeTextures.append(tinyBoyEyesClosed)
        
        eyesSideLeft = eyeBankAtlas.textureNamed("open_left")
        eyesSideRight = eyeBankAtlas.textureNamed("open_right")
        eyesSideLeftClosed = eyeBankAtlas.textureNamed("closed_left")
        eyesSideRightClosed = eyeBankAtlas.textureNamed("closed_right")
        
        eyesSideLeftTextures.append(eyesSideLeft)
        eyesSideLeftTextures.append(eyesSideLeftClosed)
        
        eyesSideRightTextures.append(eyesSideRight)
        eyesSideRightTextures.append(eyesSideRightClosed)
    }
}
