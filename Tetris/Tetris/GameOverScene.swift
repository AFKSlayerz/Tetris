//
//  GameOverScene.swift
//  Tetris
//
//  Created by Mikel Harnisch on 13.03.18.
//  Copyright © 2018 Mikel & Co. All rights reserved.
//

import UIKit
import SpriteKit
/*
class GameOverScene: SKScene {
    
    var HomeButton: SKNode! = nil
    
    
    init(size: CGSize, won: Bool) {
        super.init(size: size)
        
        backgroundColor = SKColor.whiteColor()
        
        HomeButton = SKSpriteNode(color: SKColor.blueColor(), size: CGSize(width: 100, height: 100))
        HomeButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        HomeButton.userInteractionEnabled = true
        self.addChild(HomeButton)
        
        let message = won ? "You Won!" : "You Lose!"
        
        
        
        
        
        let label = SKLabelNode(fontNamed: "Title 1")
        label.text = message
        label.fontSize = 40
        label.fontColor = SKColor.blackColor()
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(label)
        
        runAction(SKAction.sequence([SKAction.waitForDuration(3.0), SKAction.runBlock() {
            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
            let scene = GameScene(size: size)
            self.view?.presentScene(scene, transition: reveal)
            }
            ]))
        
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            
            if HomeButton.containsPoint(location) {
                
                HomeButton.prepareForSegueWithIdentifier()
                
            }
        }
}*/
