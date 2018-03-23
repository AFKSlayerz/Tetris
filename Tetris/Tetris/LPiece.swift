//
//  LPiece.swift
//  Tetris
//
//  Created by Mikel Harnisch on 22.03.18.
//  Copyright © 2018 Mikel & Co. All rights reserved.
//

class LPiece:PieceOrientation {
    /*
     
     Orientation 0
     
     | 0•|
     | 1 |
     | 2 | 3 |
     
     Orientation 90
     
     •
     | 2 | 1 | 0 |
     | 3 |
     
     Orientation 180
     
     | 3 | 2•|
     | 1 |
     | 0 |
     
     Orientation 270
     
     • | 3 |
     | 0 | 1 | 2 |
     
     • marks the row/column indicator for the shape
     
     Pivots about `1`
     
     */
    
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero:               [ (0, 0), (0, 1),  (0, 2),  (1, 2)],
            Orientation.Ninety:             [ (1, 1), (0, 1),  (-1,1), (-1, 2)],
            Orientation.HundredEighty:      [ (0, 2), (0, 1),  (0, 0),  (-1,0)],
            Orientation.TwoHundredSeventy:  [ (-1,1), (0, 1),  (1, 1),   (1,0)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation: Array<Piece>] {
        return [
            Orientation.Zero:       [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.Ninety:     [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[FourthBlockIdx]],
            Orientation.HundredEighty:  [blocks[FirstBlockIdx], blocks[FourthBlockIdx]],
            Orientation.TwoHundredSeventy: [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[ThirdBlockIdx]]
        ]
    }
}


