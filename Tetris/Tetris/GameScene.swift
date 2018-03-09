//
//  GameScene.swift
//  Tetris
//
//  Created by Mikel Harnisch on 13.02.18.
//  Copyright © 2018 Mikel & Co. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    

    
    required init(coder aDecoder: NSCoder){
        fatalError("NSCoder not supported")
    }
    
        override init(size: CGSize){
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0, y: 1.0)
        
        let background = SKSpriteNode(imageNamed: "background")
        
        background.position = CGPoint(x: 0, y: 0)                //The game will be built from the top-left
        background.anchorPoint = CGPoint(x:0 , y: 1.0)           //The anchor point (top left)
        addChild(background)
            
        let Scorecase = SKSpriteNode(imageNamed: "ScoreBoard.png")
            
        Scorecase.position = CGPoint(x: 325.0, y: -50.0)               //The game will be built from the top-left
        Scorecase.anchorPoint = CGPoint(x: 0, y: 1.0)            //The anchor point (top left)
        addChild(Scorecase)
    }
    
    /*func startGameTimer(){
        GameInt += 1
        
        if startInt == 0{
            GameTimer.invalidate()
        }
    }*/
}



