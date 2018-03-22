//
//  GameOverScene.swift
//  Tetris
//
//  Created by Mikel Harnisch on 13.03.18.
//  Copyright © 2018 Mikel & Co. All rights reserved.
//

import UIKit
import SpriteKit

class GameOverScene: SKScene {
    
    let RestartButton = SKLabelNode()
    let BestScore = SKLabelNode()
    let textscore = SKLabelNode()
    var SavedBestScore = "6854"

    override init(size: CGSize) {
        super.init(size: size)
        
        backgroundColor = SKColor.black
        
        RestartButton.fontColor = SKColor.white
        RestartButton.text = "Restart"
        RestartButton.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(RestartButton)
        
        BestScore.fontSize = 24
        BestScore.fontColor = SKColor.white
        BestScore.text = SavedBestScore
        BestScore.position = CGPoint(x: size.width / 2, y: size.height / 1.7)
        addChild(BestScore)
        
        textscore.fontSize = 22
        textscore.fontColor = SKColor.white
        textscore.text = "Best Score"
        textscore.position = CGPoint(x: size.width / 2, y: size.height / 1.60)
        addChild(textscore)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        
        if RestartButton.contains(touchLocation) {
            
            let reveal = SKTransition.doorsOpenVertical(withDuration: 0.5)
            let gameScene = GameScene(size: self.size)
            self.view?.presentScene(gameScene, transition: reveal)
            
        }
    }
}
