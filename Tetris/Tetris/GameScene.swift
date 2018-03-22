//
//  GameScene.swift
//  Tetris
//
//  Created by Mikel Harnisch on 13.02.18.
//  Copyright © 2018 Mikel & Co. All rights reserved.
//
import UIKit
import SpriteKit

let TickTime = TimeInterval(600)     //Set the slowest speed that a Piece can go

class GameScene: SKScene {
    
    let PauseButton = SKSpriteNode(imageNamed: "PauseButton.png")
    let RestartButton = SKSpriteNode(imageNamed: "Restart.png")
    let Background = SKSpriteNode(imageNamed: "background")
    let Scorecase = SKSpriteNode(imageNamed: "ScoreBoard.png")
    let BestScorecase = SKSpriteNode(imageNamed: "ScoreBoard.png")
    let Timecase = SKSpriteNode(imageNamed: "ScoreBoard.png")
    let ScoreTxT = SKLabelNode()
    let BestScoreTxT = SKLabelNode()
    let TimeTxT = SKLabelNode()
    let RestartTxt = SKLabelNode()
    let BestScoreIn = SKLabelNode()
    let ScoreIn = SKLabelNode()
    let TimeIn = SKLabelNode()
    
    let teal = SKSpriteNode(imageNamed: "teal.png")
    
    var Tick:(() -> ())?
    var TickLength = TickTime
    var LastTick:Date?
    
    override init(size: CGSize) {
        super.init(size: size)
        
        var BestScore:Int
        var Score:Int
        var Time:String
        
        Time = "4:05"
        BestScore = 43443
        Score = 6352
        anchorPoint = CGPoint(x: 0, y: 1.0)
        
        //Background
        Background.position = CGPoint(x: 0, y: 0)                //The game will be built from the top-left
        Background.anchorPoint = CGPoint(x:0 , y: 1.0)           //The anchor point (top left)
        Background.size = CGSize(width: size.width / 1.4, height: size.height)           //The anchor point (top left)
        addChild(Background)
        
        //BestScore case
        BestScorecase.position = CGPoint(x: 355.0, y: -135.0)  //The game will be built from the top-left
        BestScorecase.size = CGSize(width: 110, height: 45)  //The anchor point (top left)
        addChild(BestScorecase)
        BestScoreTxT.fontSize = 22
        BestScoreTxT.fontColor = SKColor.white
        BestScoreTxT.text = "Best Scores"
        BestScoreTxT.position = CGPoint(x: 355.0, y: -100.0)
        addChild(BestScoreTxT)
        /*BestScoreIn.fontSize = 22
        BestScoreIn.fontColor = SKColor.black
        BestScoreIn.text = "36464"
        BestScoreIn.position = CGPoint(x: 355.0, y: -140.0)
        addChild(BestScoreIn)*/
        
        //Score case
        Scorecase.position = CGPoint(x: 355.0, y: -260.0)  //The game will be built from the top-left
        Scorecase.size = CGSize(width: 110, height: 60)  //The anchor point (top left)
        addChild(Scorecase)
        ScoreTxT.fontSize = 22
        ScoreTxT.fontColor = SKColor.white
        ScoreTxT.text = "Score"
        ScoreTxT.position = CGPoint(x: 355.0, y: -225.0)
        addChild(ScoreTxT)
        /*ScoreIn.fontSize = 22
        ScoreIn.fontColor = SKColor.black
        ScoreIn.text = "3522"
        ScoreIn.position = CGPoint(x: 355.0, y: -265.0)
        addChild(ScoreIn)*/
        
        //Time case
        Timecase.position = CGPoint(x: 355.0, y: -485.0)  //The game will be built from the top-left
        Timecase.size = CGSize(width: 110, height: 45)  //The anchor point (top left)
        addChild(Timecase)
        TimeTxT.fontSize = 22
        TimeTxT.fontColor = SKColor.white
        TimeTxT.text = "Time"
        TimeTxT.position = CGPoint(x: 355.0, y: -450.0)
        addChild(TimeTxT)
        /*TimeIn.fontSize = 22
        TimeIn.fontColor = SKColor.black
        TimeIn.text = "5:04"
        TimeIn.position = CGPoint(x: 355.0, y: -490.0)
        addChild(TimeIn)*/
        
        //Pause button
        PauseButton.position = CGPoint(x: 390, y: -26)
        PauseButton.name = "PauseButton"
        PauseButton.isUserInteractionEnabled = false
        PauseButton.size = CGSize(width: 60, height: 60)
        addChild(PauseButton)
        
        //Restart button
        RestartButton.position = CGPoint(x: 355, y: -700)
        RestartButton.name = "RestartButton"
        RestartButton.isUserInteractionEnabled = false
        RestartButton.size = CGSize(width: 110, height: 45)
        addChild(RestartButton)
        /*RestartTxt.fontSize = 22
        RestartTxt.fontColor = SKColor.black
        RestartTxt.text = "Restart"
        RestartTxt.position = CGPoint(x: 355.0, y: -705.0)
        addChild(RestartTxt)*/
        
        GameArray[3][3] = teal

    }
    
    override func update(_ currentTime: CFTimeInterval) {
        /* Called before rendering each frame */
        //If the condition fail execute else block, if there is no LastTick put the game in pause and stop icking
        guard let LastTick = LastTick else {
            return
        }
        let timePassed = LastTick.timeIntervalSinceNow * -1000.0
        if timePassed > TickLength {
            self.LastTick = Date()
            Tick?()
        }
    }
    func startTicking() {
        LastTick = Date()
    }
    
    func stopTicking() {
        LastTick = nil
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //Scene changing & scene changing animation
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
            
        }else if RestartButton.contains(touchLocation) {
            let reveal = SKTransition.doorsOpenHorizontal(withDuration: 2.5)
            let gameScene = GameScene(size: self.size)
            self.view?.presentScene(gameScene, transition: reveal)
        }
    }
}
