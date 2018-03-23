//
//  oPiece.swift
//  Tetris
//
//  Created by Mikel Harnisch on 22.03.18.
//  Copyright © 2018 Mikel & Co. All rights reserved.
//

class oPiece:PieceOrientation {
    /*
     
     | 0•| 1 |
     | 2 | 3 |
     
     • marks the row/column indicator for the shape
     
     */
    
    // The square shape will not rotate
    
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero:              [(0, 0), (1, 0), (0, 1), (1, 1)],
            Orientation.HundredEighty:     [(0, 0), (1, 0), (0, 1), (1, 1)],
            Orientation.Ninety:            [(0, 0), (1, 0), (0, 1), (1, 1)],
            Orientation.TwoHundredSeventy: [(0, 0), (1, 0), (0, 1), (1, 1)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation: Array<Piece>] {
        return [
            Orientation.Zero:       [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.HundredEighty:  [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.Ninety:     [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.TwoHundredSeventy: [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]]
        ]
    }
    
}
