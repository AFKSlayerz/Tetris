//
//  GameArray.swift
//  Tetris
//
//  Created by Mikel Harnisch on 08.03.18.
//  Copyright © 2018 Mikel & Co. All rights reserved.
//

//Defining the class named GameArray
class GameArray<T> {
    
    let GameColumns: Int
    let GameRows: Int
    
    //Parameter <T> allows to store any type of data
    var GameArray: Array<T?>
    
    //Initialisation
    init(GameColumns: Int, GameRows: Int) {
        self.GameColumns = GameColumns
        self.GameRows = GameRows

        //Instantiate array with a size of rows * columns
        GameArray = Array<T?>(repeating: nil, count: GameRows * GameColumns)
    }
    
    subscript(GameColumn: Int, GameRow: Int) -> T? {
        get {
            return GameArray[(GameRow * GameColumns) + GameColumn]                  // return an appropriate subscript value here
        }
        set(newValue) {
            GameArray[(GameRow * GameColumns) + GameColumn] = newValue                  // perform a suitable setting action here
        }
    }
}

