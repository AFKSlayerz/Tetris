//
//  Block.swift
//  Tetris
//
//  Created by Mikel Harnisch on 07.03.18.
//  Copyright © 2018 Mikel & Co. All rights reserved.
//

import SpriteKit

//Number of color available in the game
let NumberOfColors: UInt32 = 6

//Enumaration of every color
enum BlockColor: Int, CustomStringConvertible {
    
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
        
        //Return the spriteName of the given color to describe the object
        var description: String {
            return self.spriteName
        }
        
        //return a random color find it 'BlockColor'
        static func random() -> BlockColor {
            return BlockColor(rawValue:Int(arc4random_uniform(NumberOfColors)))!
        }
    }

//Create Block class, Hashable allow to stock 'Block' into 'Array2D'
class Block: Hashable, CustomStringConvertible {
    
    //Constant
    let color: BlockColor       //Cannot change color in mid game
    
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
    init(column: Int, row: Int, color: BlockColor) {
        self.column = column
        self.row = row
        self.color = color
    }
}


func ==(lhs: Block, rhs: Block) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row && lhs.color.rawValue == rhs.color.rawValue
}


