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
        tetris.LetPieceFall()
        tetris.RotatePiece()
    }
    
    func NextPiece() {
        let NewPieces = tetris.NewPiece()
        guard let FallingPiece = NewPieces.FallingPiece else {
            return
        }
        self.scene.addPreviewPieceToScene(NewPieces.NextPiece!) {}
        self.scene.movePreviewPiece(FallingPiece) {
            self.view.isUserInteractionEnabled = true
            self.scene.startTicking()
        }
    }
    
    func gameDidBegin(_ tetris: Tetris) {
        /*levelLabel.text = "\(tetris.level)"
        scoreLabel.text = "\(tetris.score)"*/
        scene.TickLength = TickTime
        
        // The following is false when restarting a new game
        if tetris.NextPiece != nil && tetris.NextPiece!.blocks[0].sprite == nil {
            scene.addPreviewPieceToScene(tetris.NextPiece!) {
                self.NextPiece()
            }
        } else {
            NextPiece()
        }
    }
    
    func GameEnded(_ tetris: Tetris) {
        view.isUserInteractionEnabled = false
        scene.stopTicking()
        scene.CollapsingLine(tetris.removeAllBlocks(), fallenBlocks: tetris.removeAllBlocks()) {
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
        scene.redrawPiece(tetris.FallingPiece!) {
            tetris.LetPieceFall()
        }
    }
    
    //
    func GamePieceLanded(_ tetris: Tetris) {
        scene.stopTicking()
        self.view.isUserInteractionEnabled = false
        let removedLines = tetris.removeCompletedLines()
        if removedLines.linesRemoved.count > 0 {
            self.scoreLabel.text = "\(tetris.score)"
            scene.CollapsingLine(removedLines.linesRemoved, fallenBlocks:removedLines.fallenBlocks) {
                self.GamePieceLanded(tetris)
            }
        } else {
            NextPiece()
        }
    }
    
    func GamePieceMoved(_ tetris: Tetris) {
        scene.redrawPiece(tetris.FallingPiece!) {}
    }
}
