//
//  MenuScene.swift
//  Tetris
//
//  Created by Mikel Harnisch on 13.03.18.
//  Copyright © 2018 Mikel & Co. All rights reserved.
//
import UIKit
import SpriteKit

class MenuScene: SKScene {
    
    let playButton = SKLabelNode()
    
    
    override init(size: CGSize) {
        super.init(size: size)
        
        backgroundColor = SKColor.black
        
        playButton.fontColor = SKColor.white
        playButton.text = "play"
        
        playButton.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        addChild(playButton)
        
    }
        required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        
        if playButton.contains(touchLocation) {
            
            let reveal = SKTransition.doorsOpenVertical(withDuration: 0.5)
            let gameScene = GameScene(size: self.size)
            self.view?.presentScene(gameScene, transition: reveal)
            
        }
    }
}
