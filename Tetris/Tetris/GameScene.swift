//
//  GameScene.swift
//  Tetris
//
//  Created by Mikel Harnisch on 13.02.18.
//  Copyright © 2018 Mikel & Co. All rights reserved.
import UIKit
import SpriteKit

let TickTime = TimeInterval(600)     //Set the slowest speed that a Piece can go
let BlockSize:CGFloat = 20.0

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
    
    let gameLayer = SKNode()
    let shapeLayer = SKNode()
    let LayerPosition = CGPoint(x: 6, y: -6)

    var Tick:(() -> ())?
    var TickLength = TickTime
    var LastTick:Date?
    var textureCache = Dictionary<String, SKTexture>()
    var tetris:Tetris!
    
    override init(size: CGSize) {
        super.init(size: size)
    
        var BestScore:Int
        var Score:Int
        var Time:String
        
        Time = "4:05"
        BestScore = 43443
        Score = 6352
        anchorPoint = CGPoint(x: 0, y: 1.0)
        
        let background = SKSpriteNode(imageNamed: "background.png")
        background.position = CGPoint(x: 0, y: 0)
        background.anchorPoint = CGPoint(x: 0, y: 1.0)
        background.size = CGSize(width: size.width, height: size.height)           //The anchor point (top left)
        addChild(background)
        
        addChild(gameLayer)
        
        let gameBoardTexture = SKTexture(imageNamed: "gameboard.png")
        let gameBoard = SKSpriteNode(texture: gameBoardTexture, size: CGSize(width: BlockSize * CGFloat(NumColumns), height: BlockSize * CGFloat(NumRows)))
        gameBoard.anchorPoint = CGPoint(x:0, y:1.0)
        gameBoard.size = CGSize(width: size.width / 1.4, height: size.height / 1.03)           //The anchor point (top left)
        gameBoard.position = LayerPosition
        
        shapeLayer.position = LayerPosition
        shapeLayer.addChild(gameBoard)
        gameLayer.addChild(shapeLayer)
        
        /*
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

        
        //Score case
        Scorecase.position = CGPoint(x: 355.0, y: -260.0)  //The game will be built from the top-left
        Scorecase.size = CGSize(width: 110, height: 60)  //The anchor point (top left)
        addChild(Scorecase)
        ScoreTxT.fontSize = 22
        ScoreTxT.fontColor = SKColor.white
        ScoreTxT.text = "Score"
        ScoreTxT.position = CGPoint(x: 355.0, y: -225.0)
        addChild(ScoreTxT)
        
        //Time case
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
        
        //Restart button
        RestartButton.position = CGPoint(x: 355, y: -700)
        RestartButton.name = "RestartButton"
        RestartButton.isUserInteractionEnabled = false
        RestartButton.size = CGSize(width: 110, height: 45)
        addChild(RestartButton)*/
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func playSound(_ sound:String) {
        run(SKAction.playSoundFileNamed(sound, waitForCompletion: false))
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
    
    func pointForColumn(_ column: Int, row: Int) -> CGPoint {
        let x = LayerPosition.x + (CGFloat(column) * BlockSize) + (BlockSize / 2)
        let y = LayerPosition.y - ((CGFloat(row) * BlockSize) + (BlockSize / 2))
        return CGPoint(x: x, y: y)
    }
    
    func addPreviewShapeToScene(_ orientation:PieceOrientation, completion:@escaping () -> ()) {
        for piece in orientation.blocks {
            var texture = textureCache[piece.spriteName]
            if texture == nil {
                texture = SKTexture(imageNamed: piece.spriteName)
                textureCache[piece.spriteName] = texture
            }
            let sprite = SKSpriteNode(texture: texture)
            sprite.position = pointForColumn(piece.column, row:piece.row - 4)
            shapeLayer.addChild(sprite)
            piece.sprite = sprite
            
            // Animation
            sprite.alpha = 0
            let moveAction = SKAction.move(to: pointForColumn(piece.column, row: piece.row), duration: 0.2)
            moveAction.timingMode = .easeOut
            let fadeInAction = SKAction.fadeAlpha(to: 0.7, duration: 0.2)
            fadeInAction.timingMode = .easeOut
            sprite.run(SKAction.group([moveAction, fadeInAction]))
        }
        run(SKAction.wait(forDuration: 0.2), completion: completion)
    }
    
    func movePreviewShape(_ orientation:PieceOrientation, completion:@escaping () -> ()) {
        for piece in orientation.blocks {
            let sprite = piece.sprite!
            let moveTo = pointForColumn(piece.column, row:piece.row)
            let moveToAction = SKAction.move(to: moveTo, duration: 0.2)
            moveToAction.timingMode = .easeOut
            let fadeInAction = SKAction.fadeAlpha(to: 1.0, duration: 0.2)
            fadeInAction.timingMode = .easeOut
            sprite.run(SKAction.group([moveToAction, fadeInAction]))
        }
        run(SKAction.wait(forDuration: 0.2), completion: completion)
    }
    func redrawShape(_ orientation:PieceOrientation, completion:@escaping () -> ()) {
        for piece in orientation.blocks {
            let sprite = piece.sprite!
            let moveTo = pointForColumn(piece.column, row:piece.row)
            let moveToAction:SKAction = SKAction.move(to: moveTo, duration: 0.05)
            moveToAction.timingMode = .easeOut
            if piece == orientation.blocks.last {
                sprite.run(moveToAction, completion: completion)
            } else {
                sprite.run(moveToAction)
            }
        }
    }
    
    func animateCollapsingLines(_ linesToRemove: Array<Array<Piece>>, fallenBlocks: Array<Array<Piece>>, completion:@escaping () -> ()) {
        var longestDuration: TimeInterval = 0
        
        for (columnIdx, column) in fallenBlocks.enumerated() {
            for (blockIdx, block) in column.enumerated() {
                let newPosition = pointForColumn(block.column, row: block.row)
                let sprite = block.sprite!
                let delay = (TimeInterval(columnIdx) * 0.05) + (TimeInterval(blockIdx) * 0.05)
                let duration = TimeInterval(((sprite.position.y - newPosition.y) / BlockSize) * 0.1)
                let moveAction = SKAction.move(to: newPosition, duration: duration)
                moveAction.timingMode = .easeOut
                sprite.run(
                    SKAction.sequence([
                        SKAction.wait(forDuration: delay),
                        moveAction]))
                longestDuration = max(longestDuration, duration + delay)
            }
        }
    }
    
    
    
    //Scene changing & scene changing animation
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        
        if PauseButton.contains(touchLocation) {
            
            let reveal = SKTransition.doorsOpenVertical(withDuration: 0.5)
            let pauseScene = PauseScene(size: self.size)
            self.view?.presentScene(pauseScene, transition: reveal)
            
        }/*else if Background.contains(touchLocation) {
            
            let reveal = SKTransition.doorsOpenVertical(withDuration: 0.5)
            let gameOverScene = GameOverScene(size: self.size)
            self.view?.presentScene(gameOverScene, transition: reveal)
            
        }*/else if RestartButton.contains(touchLocation) {
            let reveal = SKTransition.doorsOpenHorizontal(withDuration: 2.5)
            let gameScene = GameScene(size: self.size)
            self.view?.presentScene(gameScene, transition: reveal)
        }
    }
}
