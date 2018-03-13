//
//  GameViewController.swift
//  Tetris
//
//  Created by Mikel Harnisch on 13.02.18.
//  Copyright © 2018 Mikel & Co. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    var scene: GameScene!                       //Type : GameScene, Name : scene
    var GameInt = 0
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let menuScene = MenuScene(size: view.bounds.size)
            
            
            let skView = view as! SKView
            skView.isMultipleTouchEnabled = false
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.ignoresSiblingOrder = true
            menuScene.scaleMode = .resizeFill
            skView.presentScene(menuScene)
            
        }
    
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

    /*func game(){
        GameInt += 1
        timeLabel.text = String(GameInt)
    }*/
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
}

