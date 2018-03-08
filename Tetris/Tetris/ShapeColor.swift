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
enum ColorPiece: Int, CustomStringConvertible {
    
    //List if enumarable value
    case Blue = 0, Green, Purple, Red, Teal, Yellow
    
    //Return the correct filename for the given color
    var spriteName: String {
        
        switch self {
            
        case .Blue:
            return "blue"
            
        case .Green:
            return "green"
            
        case .Purple:
            return "purple"
            
        case .Red:
            return "red"
            
        case .Teal:
            return "teal"
            
        case .Yellow:
            return " yellow"
        }
    }
    var description: String {
        return self.spriteName
    }
    //return a random color find it 'ColorPiece'
    static func random() -> ColorPiece {
        return ColorPiece(rawValue:Int(arc4random_uniform(MaxNumOfColors)))!
    }
}

//Create Piece class, Hashable allow to stock 'Piece' into 'GameArray'
class Piece: Hashable, CustomStringConvertible {
    
    //Constant
    let color: ColorPiece      //Cannot change color in mid game
    
    //Properties
    var column: Int
    var row: Int
    var sprite: SKSpriteNode?
    
    //Shorten block.color.spriteName to block.SpriteName
    var spriteName: String {
        return color.spriteName
    }
    
    //
    var hashValue: Int {
        return self.column ^ self.row
    }
    
    //return a string with the color and the value where the block is
    var description: String {
        return "\(color): [\(column), \(row)]"
    }
    
    //Initialisation
    init(column: Int, row: Int, color: ColorPiece) {
        self.column = column
        self.row = row
        self.color = color
    }
}


func ==(lhs: Piece, rhs: Piece) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row && lhs.color.rawValue == rhs.color.rawValue
}



