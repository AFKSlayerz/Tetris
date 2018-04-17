//
//  Orientation.swift
//  Tetris
//
//  Created by Mikel Harnisch on 20.03.18.
//  Copyright © 2018 Mikel & Co. All rights reserved.
//

import SpriteKit

let NumberOfOrientations: UInt32 = 4

//Return a random orientation
enum Orientation: Int, CustomStringConvertible {
    case Zero = 0, Ninety, HundredEighty, TwoHundredSeventy
    //List the different orentation possible
    var description: String {
        switch self {
        case .Zero:
            return "0"
        case .Ninety:
            return "90"
        case .HundredEighty:
            return "180"
        case .TwoHundredSeventy:
            return "270"
        }
    }
    //return a random orentation
    static func random() -> Orientation {
        return Orientation(rawValue:Int(arc4random_uniform(NumberOfOrientations)))!
    }
    
    //Return the next orientation of the piece, travelleling clockwise or not
    static func Rotation(_ orientation:Orientation, clockwise: Bool) -> Orientation {
        var PreRotation = orientation.rawValue + (clockwise ? 1 : -1)
        if PreRotation > Orientation.TwoHundredSeventy.rawValue {
            PreRotation = Orientation.Zero.rawValue
        } else if PreRotation < 0 {
            PreRotation = Orientation.TwoHundredSeventy.rawValue
        }
        return Orientation(rawValue:PreRotation)!
    }
}


// The number of total piece varieities
let NumPieceTypes: UInt32 = 7

// Piece indexes
let FirstBlockIdx: Int = 0
let SecondBlockIdx: Int = 1
let ThirdBlockIdx: Int = 2
let FourthBlockIdx: Int = 3

class PieceOrientation: Hashable, CustomStringConvertible {
    // The color of the piece
    let color:PieceColor
    
    // The blocks comprising the piece
    var blocks = Array<Piece>()
    // The current orientation of the piece
    var orientation: Orientation
    // The column and row representing the piece's anchor point
    var column, row:Int
    
    // Required Overrides
    
    // Subclasses must override this property
    var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [:]
    }
    // Subclasses must override this property
    var bottomBlocksForOrientations: [Orientation: Array<Piece>] {
        return [:]
    }
    
    var bottomBlocks:Array<Piece> {
        guard let bottomBlocks = bottomBlocksForOrientations[orientation] else {
            return []
        }
        return bottomBlocks
    }
    
    // Hashable
    var hashValue:Int {
        return blocks.reduce(0) { $0.hashValue ^ $1.hashValue }
    }
    
    // Printable
    var description:String {
        return "\(color) block facing \(orientation): \(blocks[FirstBlockIdx]), \(blocks[SecondBlockIdx]), \(blocks[ThirdBlockIdx]), \(blocks[FourthBlockIdx])"
    }
    
    init(column:Int, row:Int, color: PieceColor, orientation:Orientation) {
        self.color = color
        self.column = column
        self.row = row
        self.orientation = orientation
        initializeBlocks()
    }
    
    convenience init(column:Int, row:Int) {
        self.init(column:column, row:row, color:PieceColor.random(), orientation:Orientation.random())
    }
    
    final func initializeBlocks() {
        guard let blockRowColumnTranslations = blockRowColumnPositions[orientation] else {
            return
        }
        blocks = blockRowColumnTranslations.map { (diff) -> Piece in
            return Piece(column: column + diff.columnDiff, row: row + diff.rowDiff, color: color)
        }
    }
    
    //Called by rotateClockwise
    final func RotatePiece(_ orientation: Orientation) {
        guard let blockRowColumnTranslation:Array<(columnDiff: Int, rowDiff: Int)> = blockRowColumnPositions[orientation] else {
            return
        }
        for (idx, diff) in blockRowColumnTranslation.enumerated() {
            blocks[idx].column = column + diff.columnDiff
            blocks[idx].row = row + diff.rowDiff
        }
    }
    
    final func rotateClockwise() {
        let newOrientation = Orientation.Rotation(orientation, clockwise: true)
        RotatePiece(newOrientation)
        orientation = newOrientation
    }
    
    final func rotateCounterClockwise() {
        let newOrientation = Orientation.Rotation(orientation, clockwise: false)
        RotatePiece(newOrientation)
        orientation = newOrientation
    }
    
    //Increment the rows by 1
    final func lowerPieceByOneRow() {
        shiftBy(0, rows:1)
    }
    //Increment the rows by -1
    final func raisePieceByOneRow() {
        shiftBy(0, rows:-1)
    }
    //Increment the column by 1
    final func MoveRightByOneColumn() {
        shiftBy(1, rows:0)
    }
    //Increment the column by -1
    final func MoveLeftByOneColumn() {
        shiftBy(-1, rows:0)
    }
    
    //Calculate where the piece is supposed to be after it moved
    final func shiftBy(_ columns: Int, rows: Int) {
        self.column += columns
        self.row += rows
        for block in blocks {
            block.column += columns
            block.row += rows
        }
    }
    
    //Move the piece where it was calculated
    final func moveTo(_ column: Int, row:Int) {
        self.column = column
        self.row = row
        RotatePiece(orientation)
    }
    
    final class func random(_ startingColumn:Int, startingRow:Int) -> PieceOrientation {
        switch Int(arc4random_uniform(NumPieceTypes)) {
        case 0:
            return oPiece(column:startingColumn, row:startingRow)
        case 1:
            return iPiece(column:startingColumn, row:startingRow)
        case 2:
            return TPiece(column:startingColumn, row:startingRow)
        case 3:
            return LPiece(column:startingColumn, row:startingRow)
        case 4:
            return zPiece(column:startingColumn, row:startingRow)
        case 5:
            return sPiece(column:startingColumn, row:startingRow)
        default:
            return rPiece(column:startingColumn, row:startingRow)
        }
    }
    
}

func ==(lhs: PieceOrientation, rhs: PieceOrientation) -> Bool {
    return lhs.row == rhs.row && lhs.column == rhs.column
}
