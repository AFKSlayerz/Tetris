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
    func gameDidEnd(_ tetris: Tetris)
    func gameDidBegin(_ tetris: Tetris)
    func gameShapeDidLand(_ tetris: Tetris)
    func gameShapeDidMove(_ tetris: Tetris)
    func gameShapeDidDrop(_ tetris: Tetris)
    func gameDidLevelUp(_ tetris: Tetris)
}

class Tetris {
    var blockArray:GameArray<Piece>
    var nextShape:PieceOrientation?
    var FallingPiece:PieceOrientation?
    var delegate:TetrisDelegate?
    
    var score = 0
    var level = 1
    
    init() {
        FallingPiece = nil
        nextShape = nil
        blockArray = GameArray<Piece>(GameColumns: NumColumns, GameRows: NumRows)
    }
    
    func beginGame() {
        if (nextShape == nil) {
            nextShape = PieceOrientation.random(PreviewColumn, startingRow: PreviewRow)
        }
        delegate?.gameDidBegin(self)
    }
    
    func newShape() -> (FallingPiece:PieceOrientation?, nextShape:PieceOrientation?) {
        FallingPiece = nextShape
        nextShape = PieceOrientation.random(PreviewColumn, startingRow: PreviewRow)
        FallingPiece?.moveTo(StartingColumn, row: StartingRow)
        guard detectIllegalPlacement() == false else {
            nextShape = FallingPiece
            nextShape!.moveTo(PreviewColumn, row: PreviewRow)
            endGame()
            return (nil, nil)
        }
        return (FallingPiece, nextShape)
    }
    
    func detectIllegalPlacement() -> Bool {
        guard let shape = FallingPiece else {
            return false
        }
        for block in shape.blocks {
            if block.column < 0 || block.column >= NumColumns
                || block.row < 0 || block.row >= NumRows {
                return true
            } else if blockArray[block.column, block.row] != nil {
                return true
            }
        }
        return false
    }
    
    func settleShape() {
        guard let shape = FallingPiece else {
            return
        }
        for block in shape.blocks {
            blockArray[block.column, block.row] = block
        }
        FallingPiece = nil
        delegate?.gameShapeDidLand(self)
    }
    
    
    func detectTouch() -> Bool {
        guard let shape = FallingPiece else {
            return false
        }
        for bottomBlock in shape.bottomBlocks {
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
        delegate?.gameDidEnd(self)
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
    func letShapeFall() {
        guard let shape = FallingPiece else {
            return
        }
        shape.lowerShapeByOneRow()
        if detectIllegalPlacement() {
            shape.raiseShapeByOneRow()
            if detectIllegalPlacement() {
                endGame()
            } else {
                settleShape()
            }
        } else {
            delegate?.gameShapeDidMove(self)
            if detectTouch() {
                settleShape()
            }
        }
    }
    
    func rotateShape() {
        guard let piece = FallingPiece else {
            return
        }
        piece.rotateClockwise()
        guard detectIllegalPlacement() == false else {
            piece.rotateCounterClockwise()
            return
        }
        delegate?.gameShapeDidMove(self)
    }
}

