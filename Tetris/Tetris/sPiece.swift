//
//  sPiece.swift
//  Tetris
//
//  Created by Mikel Harnisch on 22.03.18.
//  Copyright © 2018 Mikel & Co. All rights reserved.
//

class sPiece:PieceOrientation {
    /*
     
     Orientation 0
     
     | 0•|
     | 1 | 2 |
     | 3 |
     
     Orientation 90
     
     • | 1 | 0 |
     | 3 | 2 |
     
     Orientation 180
     
     | 0•|
     | 1 | 2 |
     | 3 |
     
     Orientation 270
     
     • | 1 | 0 |
     | 3 | 2 |
     
     • marks the row/column indicator for the shape
     
     */
    
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero:               [(0, 0), (0, 1), (1, 1), (1, 2)],
            Orientation.Ninety:             [(2, 0), (1, 0), (1, 1), (0, 1)],
            Orientation.HundredEighty:      [(0, 0), (0, 1), (1, 1), (1, 2)],
            Orientation.TwoHundredSeventy:  [(2, 0), (1, 0), (1, 1), (0, 1)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation: Array<Piece>] {
        return [
            Orientation.Zero:       [blocks[SecondBlockIdx], blocks[FourthBlockIdx]],
            Orientation.Ninety:     [blocks[FirstBlockIdx], blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.HundredEighty:  [blocks[SecondBlockIdx], blocks[FourthBlockIdx]],
            Orientation.TwoHundredSeventy: [blocks[FirstBlockIdx], blocks[ThirdBlockIdx], blocks[FourthBlockIdx]]
        ]
    }
}

