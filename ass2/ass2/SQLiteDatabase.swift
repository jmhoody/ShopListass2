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
        print("created table")
        let createShoppingQuery = """
            CREATE TABLE Shopping2 (
                Name CHAR(255) PRIMARY KEY,
                NumberOf INTEGER,
                Cost DOUBLE,
                CostTotal DOUBLE,
                Purchased INTEGER
            );
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
        let insertStatementQuery = "INSERT INTO Shopping2 (Name, NumberOf, Cost, CostTotal, Purchased) VALUES (?, ?, ?, ?, ?);"

        //prepare the statement
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementQuery, -1, &insertStatement, nil) == SQLITE_OK
        {
            sqlite3_bind_text(insertStatement, 1, NSString(string: item.name).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 2, item.numberOf)
            if (item.cost != nil) {
                sqlite3_bind_double(insertStatement, 3, Double(item.cost!))
                sqlite3_bind_double(insertStatement, 4, Double(Double(item.numberOf)*item.cost!))
            }
            sqlite3_bind_int(insertStatement, 5, item.purchased)

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
        let selectStatementQuery = "SELECT name,numberOf,cost,costTotal,purchased FROM Shopping2"
        
        //prepare the statement
        var selectStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, selectStatementQuery, -1, &selectStatement, nil) == SQLITE_OK
        {
            //iterate over the result
            while sqlite3_step(selectStatement) == SQLITE_ROW
            {
                //create a movie object from each result
                let items = ShoppingItem(
                    name: String(cString:sqlite3_column_text(selectStatement, 0)),
                    numberOf: sqlite3_column_int(selectStatement, 1),
                    cost: sqlite3_column_double(selectStatement, 2),
                    costTotal: sqlite3_column_double(selectStatement, 3),
                    purchased: sqlite3_column_int(selectStatement, 4)
                )
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
        "UPDATE Shopping2 SET Name = ?, numberOf = ?, cost = ?, costTotal = ?, purchased = ? WHERE Name = ? ;"
        
        //prepare the statement
        var updateStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, updateStatementQuery, -1, &updateStatement, nil) == SQLITE_OK
        {
            sqlite3_bind_text(updateStatement, 6, item.name, -1, nil)
            sqlite3_bind_text(updateStatement, 1, item.name, -1, nil)
            sqlite3_bind_int(updateStatement, 2, item.numberOf)
            sqlite3_bind_double(updateStatement, 3, item.cost!)
            sqlite3_bind_double(updateStatement, 4, Double(Double(item.numberOf)*item.cost!))
            sqlite3_bind_int(updateStatement, 5, item.purchased)

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
    
    func delete(item:ShoppingItem)
    {
        let deleteStatementQuery =
        "DELETE FROM Shopping2 WHERE Name = ? ;"
        
        //prepare the statement
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementQuery, -1, &deleteStatement, nil) == SQLITE_OK
        {
            sqlite3_bind_text(deleteStatement, 1, item.name, -1, nil)
            
            //execute the statement
            if sqlite3_step(deleteStatement) == SQLITE_DONE
            {
                print("Successfully deleted row.")
            }
            else
            {
                print("Could not deleted row.")
                printCurrentSQLErrorMessage(db)
            }
        }
        else
        {
            print("DELETE statement could not be prepared.")
            printCurrentSQLErrorMessage(db)
        }
        
        //clean up
        sqlite3_finalize(deleteStatement)
    }
}
