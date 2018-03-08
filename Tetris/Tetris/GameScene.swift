//
//  GameScene.swift
//  Tetris
//
//  Created by Mikel Harnisch on 13.02.18.
//  Copyright © 2018 Mikel & Co. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    var lanecounter:CGFloat = 0
    var lastOpen:CGFloat = 0
    var score:Int = 0
    var BGspeed:CGFloat = -700
    var player:SKSpriteNode?
    let scoreLabel = SKLabelNode()
    let highScoreLabel = SKLabelNode()
    var direction:Int?
    let noCategory:UInt32 = 0
    let carCategory:UInt32 = 0b1
    let playerCategory:UInt32 = 0b1 << 1
    let pointCategory:UInt32 = 0b1 << 2
    let bumperCategory:UInt32 = 0b1 << 3
    var died:Bool?
    var pause:Bool = false
    var gameStarted:Bool?
    var restartBTN = SKSpriteNode()
    var pauseBTN = SKSpriteNode()
    var unpauseBTN = SKSpriteNode()
    
    
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
            
        
        func createPauseBTN()
        {
            pauseBTN = SKSpriteNode(color: SKColor.purple, size: CGSize(width: 100, height: 100))
            pauseBTN.position = CGPoint(x: -self.frame.width/2 + 20, y: self.frame.height/2 - 20)
            pauseBTN.zPosition = 10
            self.addChild(pauseBTN)
        }
        
        func createunPauseBTN()
        {
            unpauseBTN = SKSpriteNode(color: SKColor.purple, size: CGSize(width: 100, height: 100))
            unpauseBTN.position = CGPoint(x: 0, y: 0)
            unpauseBTN.zPosition = 1000
            self.addChild(unpauseBTN)
            //pauseGame()
            //scene?.view?.isPaused = true
        }
        
        func pauseGame() {
            scene?.view?.isPaused = true
            createunPauseBTN()
        }
        
        
        
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            
            for touch in touches
            {
                let location = touch.location(in: self)
                
                if died == true
                {
                    if restartBTN.contains(location) {
                        restartScene()
                    }
                }
                
                if pauseBTN.contains(location) {
                    print(pause)
                    createunPauseBTN()
                    print("asd")
                    pauseBTN.removeFromParent()
                    pauseGame()
                }
                
                if unpauseBTN.contains(location) {
                    scene?.view?.isPaused = false
                    createPauseBTN()
                }
            }
        }
    }
}



