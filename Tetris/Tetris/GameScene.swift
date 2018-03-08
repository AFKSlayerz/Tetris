//
//  GameScene.swift
//  Tetris
//
//  Created by Mikel Harnisch on 13.02.18.
//  Copyright © 2018 Mikel & Co. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    
    required init(coder aDecoder: NSCoder){
        fatalError("NSCoder not supported")
    }
    
        override init(size: CGSize){
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0, y: 1.0)
        
        let background = SKSpriteNode(imageNamed: "background")
        
        background.position = CGPoint(x: 0, y: 0)               //The game will be built from the top-left
        background.anchorPoint = CGPoint(x:0 , y: 1.0)           //The anchor point (top left)
        addChild(background)
    }
}



