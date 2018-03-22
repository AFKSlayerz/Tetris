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


/*
class TheShape: Hashable, CustomStringConvertible {

    final func random(_ startingColumn:Int, startingRow:Int) -> Shape {
        switch Int(arc4random_uniform(NumShapeTypes)) {
        case 0:
            return SquareShape(column:startingColumn, row:startingRow)
        case 1:
            return LineShape(column:startingColumn, row:startingRow)
        case 2:
            return TShape(column:startingColumn, row:startingRow)
        case 3:
            return SShape(column:startingColumn, row:startingRow)
        case 4:
            return ZShape(column:startingColumn, row:startingRow)
        case 5:
            return LShape(column:startingColumn, row:startingRow)
        default:
            return JShape(column:startingColumn, row:startingRow)
        }
    }
}*/
