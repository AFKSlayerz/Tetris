//
//  GameScene.swift
//  Tetris
//
//  Created by Mikel Harnisch on 13.02.18.
//  Copyright © 2018 Mikel & Co. All rights reserved.
//
import UIKit
import SpriteKit

class GameScene: SKScene {
    
let PauseButton = SKSpriteNode(imageNamed: "PauseButton.png")
let Background = SKSpriteNode(imageNamed: "background")
let Scorecase = SKSpriteNode(imageNamed: "ScoreBoard.png")
let BestScorecase = SKSpriteNode(imageNamed: "ScoreBoard.png")
let Timecase = SKSpriteNode(imageNamed: "ScoreBoard.png")
let RestartButton = SKLabelNode()
let ScoreTxT = SKLabelNode()
let BestScoreTxT = SKLabelNode()
let TimeTxT = SKLabelNode()

    override init(size: CGSize) {
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0, y: 1.0)
        
        // Background
        Background.position = CGPoint(x: 0, y: 0)                //The game will be built from the top-left
        Background.anchorPoint = CGPoint(x:0 , y: 1.0)           //The anchor point (top left)
        Background.size = CGSize(width: size.width / 1.4, height: size.height)           //The anchor point (top left)
        addChild(Background)
        
        //BestScorecase
        BestScorecase.position = CGPoint(x: 355.0, y: -135.0)  //The game will be built from the top-left
        BestScorecase.size = CGSize(width: 110, height: 45)  //The anchor point (top left)
        addChild(BestScorecase)
        BestScoreTxT.fontSize = 22
        BestScoreTxT.fontColor = SKColor.white
        BestScoreTxT.text = "Best Scores"
        BestScoreTxT.position = CGPoint(x: 355.0, y: -100.0)
        addChild(BestScoreTxT)
        
        //Scorecase
        Scorecase.position = CGPoint(x: 355.0, y: -260.0)  //The game will be built from the top-left
        Scorecase.size = CGSize(width: 110, height: 60)  //The anchor point (top left)
        addChild(Scorecase)
        ScoreTxT.fontSize = 22
        ScoreTxT.fontColor = SKColor.white
        ScoreTxT.text = "Score"
        ScoreTxT.position = CGPoint(x: 355.0, y: -225.0)
        addChild(ScoreTxT)
        
        //Timecase
        Timecase.position = CGPoint(x: 355.0, y: -485.0)  //The game will be built from the top-left
        Timecase.size = CGSize(width: 110, height: 45)  //The anchor point (top left)
        addChild(Timecase)
        TimeTxT.fontSize = 22
        TimeTxT.fontColor = SKColor.white
        TimeTxT.text = "Time"
        TimeTxT.position = CGPoint(x: 355.0, y: -450.0)
        addChild(TimeTxT)
        
        //Pause button
        PauseButton.position = CGPoint(x: 390, y: -26)
        PauseButton.name = "PauseButton"
        PauseButton.isUserInteractionEnabled = false
        PauseButton.size = CGSize(width: 60, height: 60)
        addChild(PauseButton)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        
        if PauseButton.contains(touchLocation) {
            
            let reveal = SKTransition.doorsOpenVertical(withDuration: 0.5)
            let pauseScene = PauseScene(size: self.size)
            self.view?.presentScene(pauseScene, transition: reveal)
            
        }else if Background.contains(touchLocation) {
            
            let reveal = SKTransition.doorsOpenVertical(withDuration: 0.5)
            let gameOverScene = GameOverScene(size: self.size)
            self.view?.presentScene(gameOverScene, transition: reveal)
            
        }
    }
}
