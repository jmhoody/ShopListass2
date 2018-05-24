//
//  SQLiteDatabase.swift
//  ass2
//
//  Created by Justin Hood on 24/5/18.
//  Copyright © 2018 University of Tasmania. All rights reserved.
//

import Foundation
import SQLite3
class SQLiteDatabase
{
    private var db: OpaquePointer?
    
    init(databaseName dbName:String)
    {
        //get a file handle somewhere on this device (if it doesn't exist, this should create the file for us)
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("\(dbName).sqlite")
        //try and open the file path as a database
        if sqlite3_open(fileURL.path, &db) == SQLITE_OK
        {
            print("Successfully opened connection to database at \(fileURL.path)")
        }
        else
        {
            print("Unable to open database at \(fileURL.path)")
            printCurrentSQLErrorMessage(db)
        }
    }
    deinit
    {
            sqlite3_close(db)
    }
    
    func printCurrentSQLErrorMessage(_ db: OpaquePointer?)
    {
        let errorMessage = String.init(cString: sqlite3_errmsg(db))
        print("Error:\(errorMessage)")
    }
    
    func createShoppingTable()
    {
        let createShoppingQuery = """
            CREATE TABLE Shopping (
                ID INTEGER PRIMARY KEY NOT NULL,
                Name CHAR(255),
                Year INTEGER,
                Director CHAR(255));
            """
        
        //prepare the statement
        var createShoppingStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createShoppingQuery, -1, &createShoppingStatement, nil) == SQLITE_OK {
        }
        else
        {
            print("CREATE TABLE statement could not be prepared.")
            printCurrentSQLErrorMessage(db)
        }
        
        //execute the statement
        if sqlite3_step(createShoppingStatement) == SQLITE_DONE
        {
            print("Shopping table created.")
        }
        else
        {
            print("Shopping table could not be created.")
            printCurrentSQLErrorMessage(db)
        }
        
        //clean up
        sqlite3_finalize(createShoppingStatement)
        
    }
    
    func insert(item:ShoppingItem){
        let insertStatementQuery = "INSERT INTO Shopping (ID, Name, Year, Director) VALUES (?, ?, ?, ?);"
        
        //prepare the statement
        var insertStatement: OpaquePointer? = nil
        if   sqlite3_prepare_v2(db, insertStatementQuery, -1, &insertStatement, nil) == SQLITE_OK
        {
            sqlite3_bind_int(insertStatement, 1, item.ID)
            sqlite3_bind_text(insertStatement, 2, item.name, -1, nil)
            sqlite3_bind_int(insertStatement, 3, item.year)
            sqlite3_bind_text(insertStatement, 4, item.director, -1, nil)
            
            //execute the statement
            if sqlite3_step(insertStatement) == SQLITE_DONE
            {
                print("Successfully inserted row.")
            }
            else
            {
                print("Could not insert row.")
                printCurrentSQLErrorMessage(db)
                
            }
        }
        else
        {
            print("INSERT statement could not be prepared.")
            printCurrentSQLErrorMessage(db)
        }
        
        //clean up
        sqlite3_finalize(insertStatement)
    }
    
    
    func selectAllItems() -> [ShoppingItem]
    {
        var result = [ShoppingItem]()
        let selectStatementQuery = "SELECT id,name,year,director FROM Shopping"
        
        //prepare the statement
        var selectStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, selectStatementQuery, -1, &selectStatement, nil) == SQLITE_OK
        {
            //iterate over the result
            while sqlite3_step(selectStatement) == SQLITE_ROW
            {
                //create a movie object from each result
                let items = ShoppingItem(
                    ID: sqlite3_column_int(selectStatement, 0),
                    name: String(cString:sqlite3_column_text(selectStatement, 1)),
                    year: sqlite3_column_int(selectStatement, 2),
                    director: String(cString:sqlite3_column_text(selectStatement, 3)) )
                //add it to the result array
                result += [items]
            }
        }
        else
        {
            print("SELECT statement could not be prepared.")
            printCurrentSQLErrorMessage(db)
            
        }
        //clean up
        sqlite3_finalize(selectStatement)
        return result
    }
    
    
    func update(item:ShoppingItem)
    {
        let updateStatementQuery =
        "UPDATE Shopping SET Name = ?, Year = ?, Director = ? WHERE ID = ? ;"
        
        //prepare the statement
        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateStatementQuery, -1, &updateStatement, nil) == SQLITE_OK
        {
            sqlite3_bind_int(updateStatement, 4, item.ID)
            sqlite3_bind_text(updateStatement, 1, item.name, -1, nil)
            sqlite3_bind_int(updateStatement, 2, item.year)
            sqlite3_bind_text(updateStatement, 3, item.director, -1, nil)
            
            //execute the statement
            if sqlite3_step(updateStatement) == SQLITE_DONE
            {
                print("Successfully updated row.")
            }
            else
            {
                print("Could not updated row.")
                printCurrentSQLErrorMessage(db)
            }
        }
        else
        {
            print("UPDATE statement could not be prepared.")
            printCurrentSQLErrorMessage(db)
        }
        
        //clean up
        sqlite3_finalize(updateStatement)
    }
    
    func selectItemBy(id:Int32) -> ShoppingItem?
    {
        var result: ShoppingItem?
        let selectStatementQuery = "SELECT id,name,year,director FROM Shopping WHERE id = ? "
        
        //prepare the statement
        var selectStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, selectStatementQuery, -1, &selectStatement, nil) == SQLITE_OK
        {
            sqlite3_bind_int(selectStatement, 1, id)
            
            if sqlite3_step(selectStatement) == SQLITE_ROW {
                let item = ShoppingItem(
                    ID: sqlite3_column_int(selectStatement, 0),
                    name: String(cString:sqlite3_column_text(selectStatement, 1)),
                    year: sqlite3_column_int(selectStatement, 2),
                    director: String(cString:sqlite3_column_text(selectStatement, 3)) )
                
                //add it to the result array
                result = item
            }
        }
        else
        {
            print("SELECT Movie statement could not be prepared.")
            printCurrentSQLErrorMessage(db)
        }
        //clean up
        sqlite3_finalize(selectStatement)
        return result
    }
}
