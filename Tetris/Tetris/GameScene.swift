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

    override init(size: CGSize) {
        super.init(size: size)
        
        let PauseButton = SKSpriteNode(imageNamed: "PauseButton.png")
        PauseButton.position = CGPoint(x: 300, y: -100)
        PauseButton.size = CGSize(width: size.width/1.1, height: size.height/1.1)
        PauseButton.name = "PauseButton"; // set the name for your sprite
        PauseButton.isUserInteractionEnabled = false; // userInteractionEnabled should be disabled
        self.addChild(PauseButton)
        
        func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
            let location = (touches.anyObject() as AnyObject).location(self)
            let node = self.atPoint(location)
            if (node.name == "PauseButton") {
                print("you hit me with your best shot!")
            }
        }
        anchorPoint = CGPoint(x: 0, y: 1.0)
        
        let background = SKSpriteNode(imageNamed: "background")
        
        background.position = CGPoint(x: 0, y: 0)                //The game will be built from the top-left
        background.anchorPoint = CGPoint(x:0 , y: 1.0)           //The anchor point (top left)
        addChild(background)
        
        let Scorecase = SKSpriteNode(imageNamed: "ScoreBoard.png")
        
        Scorecase.position = CGPoint(x: 325.0, y: -50.0)               //The game will be built from the top-left
        Scorecase.anchorPoint = CGPoint(x: 0, y: 1.0)            //The anchor point (top left)
        addChild(Scorecase)
        
        /*let PauseButton = SKSpriteNode(imageNamed: "PauseButton.png")
        PauseButton.position = CGPoint(x: 390, y: -26)
        PauseButton.name = "PauseButton"
        PauseButton.size = CGSize(width: PauseButton.size.width * 1.05, height: PauseButton.size.height * 1.05)
        addChild(PauseButton)*/
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buttonAction(sender: UIButton!) {
        let reveal = SKTransition.doorsOpenVertical(withDuration: 0.5)
        let pauseScene = PauseScene(size: self.size)
        self.view?.presentScene(pauseScene, transition: reveal)
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        
        if PauseButton.contains(touchLocation) {
            
            let reveal = SKTransition.doorsOpenVertical(withDuration: 0.5)
            let pauseScene = PauseScene(size: self.size)
            self.view?.presentScene(pauseScene, transition: reveal)
            
        }
    }
}
