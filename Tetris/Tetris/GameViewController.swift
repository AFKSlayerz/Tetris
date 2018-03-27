//
//  GameViewController.swift
//  Tetris
//
//  Created by Mikel Harnisch on 13.02.18.
//  Copyright © 2018 Mikel & Co. All rights reserved.
import UIKit
import SpriteKit

class GameViewController: UIViewController, TetrisDelegate, UIGestureRecognizerDelegate {
    
    var scene: GameScene!
    var tetris:Tetris!
    var panPointReference:CGPoint?
    
    
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var levelLabel: UILabel!
    
    override func viewDidLoad() {
        /*super.viewDidLoad()
        
        let menuScene = MenuScene(size: view.bounds.size)
        
        
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        menuScene.scaleMode = .resizeFill

        
        // Present the scene.
         skView.presentScene(menuScene)*/
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false
        
        // Create and configure the scene.
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        scene.Tick = DidTick
        
        tetris = Tetris()
        tetris.delegate = self
        tetris.beginGame()
        
        // Present the scene.
        skView.presentScene(scene)
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    func DidTick() {
        tetris.letShapeFall()
        tetris.rotateShape()
    }
    
    func nextShape() {
        let newShapes = tetris.newShape()
        guard let FallingPiece = newShapes.FallingPiece else {
            return
        }
        self.scene.addPreviewShapeToScene(newShapes.nextShape!) {}
        self.scene.movePreviewShape(FallingPiece) {
            self.view.isUserInteractionEnabled = true
            self.scene.startTicking()
        }
    }
    
    func gameDidBegin(_ tetris: Tetris) {
        /*levelLabel.text = "\(tetris.level)"
        scoreLabel.text = "\(tetris.score)"*/
        scene.TickLength = TickTime
        
        // The following is false when restarting a new game
        if tetris.nextShape != nil && tetris.nextShape!.blocks[0].sprite == nil {
            scene.addPreviewShapeToScene(tetris.nextShape!) {
                self.nextShape()
            }
        } else {
            nextShape()
        }
    }
    
    func GameEnded(_ tetris: Tetris) {
        view.isUserInteractionEnabled = false
        scene.stopTicking()
        scene.animateCollapsingLines(tetris.removeAllBlocks(), fallenBlocks: tetris.removeAllBlocks()) {
            tetris.beginGame()
        }
    }
    
    func gameDidLevelUp(_ tetris: Tetris) {
        levelLabel.text = "\(tetris.level)"
        if scene.TickLength >= 100 {
            scene.TickLength -= 100
        } else if scene.TickLength > 50 {
            scene.TickLength -= 50
        }
    }
    
    func GamePieceDropped(_ tetris: Tetris) {
        scene.stopTicking()
        scene.redrawShape(tetris.FallingPiece!) {
            tetris.letShapeFall()
        }
    }
    
    //
    func GamePieceLanded(_ tetris: Tetris) {
        scene.stopTicking()
        self.view.isUserInteractionEnabled = false
        let removedLines = tetris.removeCompletedLines()
        if removedLines.linesRemoved.count > 0 {
            self.scoreLabel.text = "\(tetris.score)"
            scene.animateCollapsingLines(removedLines.linesRemoved, fallenBlocks:removedLines.fallenBlocks) {
                self.GamePieceLanded(tetris)
            }
        } else {
            nextShape()
        }
    }
    
    func GamePieceMoved(_ tetris: Tetris) {
        scene.redrawShape(tetris.FallingPiece!) {}
    }
}
