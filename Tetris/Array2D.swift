//
//  Array2D.swift
//  Tetris
//
//  Created by Mikel Harnisch on 06.03.18.
//  Copyright © 2018 Mikel & Co. All rights reserved.
//

//Defining the class named Array2D
class Array2D<T> {

 
    let columns: Int
    let rows: Int
    
    //Parameter <T> allows to store any type of data
    var array: Array<T?>
    
    init(columns: Int, rows: Int) {
        self.columns = columns
        self.rows = rows
    
        //Instantiate Array2D with a size of rows * columns so we can store all the objects inside (200 in our case)
        array = Array<T?>(repeating: nil, count: rows * columns)
    }
    
    //Creating a custom subscript
    subscript(column: Int, row: Int) -> T? {
        get{
            return array[(row * columns) + column]      //Return the value at a given location
        }
        
        set(newValue){
            array[(row * columns) + column] = newValue
        }
    }
}
