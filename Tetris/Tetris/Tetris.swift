//
//  Tetris.swift
//  Tetris
//
//  Created by Mikel Harnisch on 22.03.18.
//  Copyright © 2018 Mikel & Co. All rights reserved.
//

let NumColumns = 10
let NumRows = 20

let StartingColumn = 4
let StartingRow = 0

let PreviewColumn = 12
let PreviewRow = 1

let LinePoints = 10
let UpLevel = 500

protocol TetrisDelegate {
    func GameEnded(_ tetris: Tetris)
    func gameDidBegin(_ tetris: Tetris)
    func GamePieceLanded(_ tetris: Tetris)
    func GamePieceMoved(_ tetris: Tetris)
    func GamePieceDropped(_ tetris: Tetris)
    func gameDidLevelUp(_ tetris: Tetris)
}

class Tetris {
    var blockArray:GameArray<Piece>
    var NextPiece:PieceOrientation?
    var FallingPiece:PieceOrientation?
    var delegate:TetrisDelegate?
    
    var score = 0
    var level = 1
    
    init() {
        FallingPiece = nil
        NextPiece = nil
        blockArray = GameArray<Piece>(GameColumns: NumColumns, GameRows: NumRows)
    }
    
    func beginGame() {
        if (NextPiece == nil) {
            NextPiece = PieceOrientation.random(PreviewColumn, startingRow: PreviewRow)
        }
        delegate?.gameDidBegin(self)
    }
    
    func NewPiece() -> (FallingPiece:PieceOrientation?, NextPiece:PieceOrientation?) {
        FallingPiece = NextPiece
        NextPiece = PieceOrientation.random(PreviewColumn, startingRow: PreviewRow)
        FallingPiece?.moveTo(StartingColumn, row: StartingRow)
        guard detectIllegalPlacement() == false else {
            NextPiece = FallingPiece
            NextPiece!.moveTo(PreviewColumn, row: PreviewRow)
            endGame()
            return (nil, nil)
        }
        return (FallingPiece, NextPiece)
    }
    
    func detectIllegalPlacement() -> Bool {
        guard let piece = FallingPiece else {
            return false
        }
        for block in piece.blocks {
            if block.column < 0 || block.column >= NumColumns
                || block.row < 0 || block.row >= NumRows {
                return true
            } else if blockArray[block.column, block.row] != nil {
                return true
            }
        }
        return false
    }
    
    func SettlePiece() {
        guard let piece = FallingPiece else {
            return
        }
        for block in piece.blocks {
            blockArray[block.column, block.row] = block
        }
        FallingPiece = nil
        delegate?.GamePieceLanded(self)
    }
    
    
    func detectTouch() -> Bool {
        guard let piece = FallingPiece else {
            return false
        }
        for bottomBlock in piece.bottomBlocks {
            if bottomBlock.row == NumRows - 1
                || blockArray[bottomBlock.column, bottomBlock.row + 1] != nil {
                return true
            }
        }
        return false
    }
    
    func endGame() {
        score = 0
        level = 1
        delegate?.GameEnded(self)
    }
    
    func removeAllBlocks() -> Array<Array<Piece>> {
        var allBlocks = Array<Array<Piece>>()
        for row in 0..<NumRows {
            var rowOfBlocks = Array<Piece>()
            for column in 0..<NumColumns {
                guard let block = blockArray[column, row] else {
                    continue
                }
                rowOfBlocks.append(block)
                blockArray[column, row] = nil
            }
            allBlocks.append(rowOfBlocks)
        }
        return allBlocks
    }
    
    func removeCompletedLines() -> (linesRemoved: Array<Array<Piece>>, fallenBlocks: Array<Array<Piece>>) {
        var removedLines = Array<Array<Piece>>()
        for row in (1..<NumRows).reversed() {
            var rowOfBlocks = Array<Piece>()
            for column in 0..<NumColumns {
                guard let block = blockArray[column, row] else {
                    continue
                }
                rowOfBlocks.append(block)
            }
            if rowOfBlocks.count == NumColumns {
                removedLines.append(rowOfBlocks)
                for block in rowOfBlocks {
                    blockArray[block.column, block.row] = nil
                }
            }
        }
        
        if removedLines.count == 0 {
            return ([], [])
        }
        let pointsEarned = removedLines.count * LinePoints * level
        score += pointsEarned
        if score >= level * UpLevel {
            level += 1
            delegate?.gameDidLevelUp(self)
        }
        
        var fallenBlocks = Array<Array<Piece>>()
        for column in 0..<NumColumns {
            var fallenBlocksArray = Array<Piece>()
            for row in (1..<removedLines[0][0].row).reversed() {
                guard let block = blockArray[column, row] else {
                    continue
                }
                var newRow = row
                while (newRow < NumRows - 1 && blockArray[column, newRow + 1] == nil) {
                    newRow += 1
                }
                block.row = newRow
                blockArray[column, row] = nil
                blockArray[column, newRow] = block
                fallenBlocksArray.append(block)
            }
            if fallenBlocksArray.count > 0 {
                fallenBlocks.append(fallenBlocksArray)
            }
        }
        return (removedLines, fallenBlocks)
    }

    //Called by DidTick
    func LetPieceFall() {
        guard let piece = FallingPiece else {
            return
        }
        piece.lowerPieceByOneRow()
        if detectIllegalPlacement() {
            piece.raisePieceByOneRow()
            if detectIllegalPlacement() {
                endGame()
            } else {
                SettlePiece()
            }
        } else {
            delegate?.GamePieceMoved(self)
            if detectTouch() {
                SettlePiece()
            }
        }
    }
    
    func RotatePiece() {
        guard let piece = FallingPiece else {
            return
        }
        piece.rotateClockwise()
        guard detectIllegalPlacement() == false else {
            piece.rotateCounterClockwise()
            return
        }
        delegate?.GamePieceMoved(self)
    }
}

