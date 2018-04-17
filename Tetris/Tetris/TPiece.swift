//
//  TPiece.swift
//  Tetris
//
//  Created by Mikel Harnisch on 22.03.18.
//  Copyright © 2018 Mikel & Co. All rights reserved.
//

class TPiece:PieceOrientation {
    /*
     Orientation 0
     
     | 0 |
     | 1 | 2 | 3 |
     
     Orientation 90
     
     | 1 |
     | 2 | 0 |
     | 3 |
     
     Orientation 180
     
     
     | 1 | 2 | 3 |
     | 0 |
     
     Orientation 270
     
     | 1 |
     | 0 | 2 |
     | 3 |
          
     */
    
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero:               [(1, 0), (0, 1), (1, 1), (2, 1)],
            Orientation.Ninety:             [(2, 1), (1, 0), (1, 1), (1, 2)],
            Orientation.HundredEighty:      [(1, 2), (0, 1), (1, 1), (2, 1)],
            Orientation.TwoHundredSeventy:  [(0, 1), (1, 0), (1, 1), (1, 2)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation: Array<Piece>] {
        return [
            Orientation.Zero:       [blocks[SecondBlockIdx], blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.Ninety:     [blocks[FirstBlockIdx], blocks[FourthBlockIdx]],
            Orientation.HundredEighty:  [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[FourthBlockIdx]],
            Orientation.TwoHundredSeventy: [blocks[FirstBlockIdx], blocks[FourthBlockIdx]]
        ]
    }
}

