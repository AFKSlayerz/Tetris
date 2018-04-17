//
//  rPiece.swift
//  Tetris
//
//  Created by Mikel Harnisch on 22.03.18.
//  Copyright © 2018 Mikel & Co. All rights reserved.
//

class rPiece:PieceOrientation {
    /*
     
     Orientation 0
     
     | 0 |
     | 1 |
     | 3 | 2 |
     
     Orientation 90
     
     | 3 |
     | 2 | 1 | 0 |
     
     Orientation 180
     
     | 2 | 3 |
     | 1 |
     | 0 |
     
     Orientation 270
     
     | 0 | 1 | 2 |
     | 3 |
          
     Pivots about `1`
     
     */
    
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero:               [(1, 0), (1, 1),  (1, 2),  (0, 2)],
            Orientation.Ninety:             [(2, 1), (1, 1),  (0, 1),  (0, 0)],
            Orientation.HundredEighty:      [(0, 2), (0, 1),  (0, 0),  (1, 0)],
            Orientation.TwoHundredSeventy:  [(0, 0), (1, 0),  (2, 0),  (2, 1)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation: Array<Piece>] {
        return [
            Orientation.Zero:       [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.Ninety:     [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[ThirdBlockIdx]],
            Orientation.HundredEighty:  [blocks[FirstBlockIdx], blocks[FourthBlockIdx]],
            Orientation.TwoHundredSeventy: [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[FourthBlockIdx]]
        ]
    }
}
