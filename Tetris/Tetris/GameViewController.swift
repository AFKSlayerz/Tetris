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

    var clickCount = 0
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func buttonClick(_ sender: UIButton) {
        timeLabel.text="You clicked the button \(clickCount) times"
    }

    var scene: GameScene!                       //Type : GameScene, Name : scene
    var GameInt = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view.
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false
        
        //Create and configure the scene
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        
        //Present scene
        skView.presentScene(scene)
        
        
        
    }
        @objc func buttonAction(_ sender:UIButton!){
            print("Button tapped")
        }
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }

    func game(){
        GameInt += 1
        timeLabel.text = String(GameInt)
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
}

