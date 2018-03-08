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
    var array: Array<T?>
    
    //Initialisation
    init(columns: Int, rows: Int) {
        GameColumns = columns
        GameRows = rows

        //Instantiate array with a size of rows * columns
        array = Array<T?>(repeating: nil, count: rows * columns)
    }
}

