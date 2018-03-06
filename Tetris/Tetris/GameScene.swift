//
//  GameScene.swift
//  Tetris
//
//  Created by Mikel Harnisch on 13.02.18.
//  Copyright © 2018 Mikel & Co. All rights reserved.
//

import SpriteKit
let TickLengthLevelOne = TimeInterval(600)      //Define the speed that our shape will travel

class GameScene: SKScene {


    var tick:(() -> ())?                        //Won't take or return any parameter
    var tickLengthMillis = TickLengthLevelOne
    var lastTick:Date?                          //Will track the last time a tick was experienced
    
    required init(coder aDecoder: NSCoder){
        fatalError("NSCoder not supported")
    }
    
    override init(size: CGSize){
        super.init(size: size)
        
        anchorPoint = CGPoint(x: 0, y: 1.0)
        
        let background = SKSpriteNode(imageNamed: "background")
        
        background.position = CGPoint(x: 0, y: 0)               //The game will be built from the top-left
        background.anchorPoint = CGPoint(x:0 , y: 1.0)           //The anchor point (top left)
        addChild(background)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        guard let lastTick = lastTick else {    //Guard check if lastTick = LastTick, if fails execute the else block
            return
        }
        
        let timePassed = lastTick.timeIntervalSinceNow * -1000.0    //Calculate the time passed if lastTick is present
        
        if timePassed > tickLengthMillis{      //Report a tick if the time passed is greater than tickLenghtMillis
            self.lastTick = Date()
            tick?()
        }
    }
    
    //External class to let external class stop and start the ticking proccess
    func startTicking(){
        lastTick = Date()
    }
    
    func stopTicking(){
        lastTick = nil
    }
}



