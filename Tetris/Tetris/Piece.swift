//
//  ShapeColor.swift
//  Tetris
//
//  Created by Mikel Harnisch on 08.03.18.
//  Copyright © 2018 Mikel & Co. All rights reserved.
//

import SpriteKit

//Number of color available in the game
let MaxNumOfColors: UInt32 = 6

//Enumaration of every color
enum PieceColor: Int, CustomStringConvertible {
    
    case blue = 0, orange, purple, red, teal, yellow
    
    var spriteName: String {
        switch self {
        case .blue:
            return "blue"
        case .orange:
            return "orange"
        case .purple:
            return "purple"
        case .red:
            return "red"
        case .teal:
            return "teal"
        case .yellow:
            return "yellow"
        }
    }
    
    //Return the a color
    var description: String {
        return self.spriteName
    }
    
    static func random() -> PieceColor {
        return PieceColor(rawValue:Int(arc4random_uniform(UInt32(MaxNumOfColors))))!
    }
}

//Create Piece class, Hashable allow to stock 'Piece' into 'GameArray'
class Piece: Hashable, CustomStringConvertible {
    
    //Constant
    let color: PieceColor      //Cannot change color in mid game
    
    var column: Int
    var row: Int
    var sprite: SKSpriteNode?
    
    var spriteName: String {
        return color.description
    }
    
    var hashValue: Int {
        return self.column ^ self.row
    }
    
    //return a string with the color and the value where the block is
    var description: String {
        return "\(color): [\(column), \(row)]"
    }
    
    //Initialisation
    init(column: Int, row: Int, color: PieceColor) {
        self.column = column
        self.row = row
        self.color = color
    }
}


func ==(lhs: Piece, rhs: Piece) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row && lhs.color.rawValue == rhs.color.rawValue
}




