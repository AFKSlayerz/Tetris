//
//  zPiece.swift
//  Tetris
//
//  Created by Mikel Harnisch on 22.03.18.
//  Copyright © 2018 Mikel & Co. All rights reserved.
//

class zPiece:PieceOrientation {
    /*
     
     Orientation 0
     
     | 0 |
     | 2 | 1 |
     | 3 |
     
     Orientation 90
     
     | 0 | 1 |
     | 2 | 3 |
     
     Orientation 180
     
     | 0 |
     | 2 | 1 |
     | 3 |
     
     Orientation 270
     
     | 0 | 1 |
     | 2 | 3 |
     
          
     */
    
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero:               [(1, 0), (1, 1), (0, 1), (0, 2)],
            Orientation.Ninety:             [(-1,0), (0, 0), (0, 1), (1, 1)],
            Orientation.HundredEighty:      [(1, 0), (1, 1), (0, 1), (0, 2)],
            Orientation.TwoHundredSeventy:  [(-1,0), (0, 0), (0, 1), (1, 1)]
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

