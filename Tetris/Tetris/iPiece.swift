//
//  iPiece.swift
//  Tetris
//
//  Created by Mikel Harnisch on 22.03.18.
//  Copyright © 2018 Mikel & Co. All rights reserved.
//

class iPiece:PieceOrientation {
    /*
     Orientations 0 and 180:
     
     | 0•|
     | 1 |
     | 2 |
     | 3 |
     
     Orientations 90 and 270:
     
     | 0 | 1•| 2 | 3 |
     
     • marks the row/column indicator for the shape
     
     */
    
    // Hinges about the second block
    
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero:               [(0, 0), (0, 1), (0, 2), (0, 3)],
            Orientation.Ninety:             [(-1,0), (0, 0), (1, 0), (2, 0)],
            Orientation.HundredEighty:      [(0, 0), (0, 1), (0, 2), (0, 3)],
            Orientation.TwoHundredSeventy:  [(-1,0), (0, 0), (1, 0), (2, 0)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation: Array<Piece>] {
        return [
            Orientation.Zero:       [blocks[FourthBlockIdx]],
            Orientation.Ninety:     blocks,
            Orientation.HundredEighty:  [blocks[FourthBlockIdx]],
            Orientation.TwoHundredSeventy: blocks
        ]
    }
}

