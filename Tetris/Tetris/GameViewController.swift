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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configure the view
        let skView = view as! SKView            //Force view to be seen as an SKView item and not UIView
        skView.isMultipleTouchEnabled = false
        
        //Create and configure the scene
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        
        //Present scene
        skView.presentScene(scene)
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
}

