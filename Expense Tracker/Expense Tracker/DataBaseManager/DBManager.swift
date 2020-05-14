//
//  DBManager.swift
//  Expense Tracker
//
//  Created by Parth Thakkar on 2020-05-12.
//  Copyright © 2020 ParthThakkar. All rights reserved.
//

import UIKit

var sharedDBManager = DBManager()
class DBManager: NSObject {

    //Shared Instance
    var database: FMDatabase? = nil
    var resultDelegate: ResultDelegate?
    var arrCatagories: [String] = ["Fuel","Food","Shopping","Electronics","Subscription"]
    
    var sharedQueue: FMDatabaseQueue? = nil
    
    class func getInstance() -> DBManager{
        
        if sharedDBManager.database == nil && sharedDBManager.sharedQueue ==  nil{
            sharedDBManager.database = FMDatabase(path: Utility.getFilePath(fileName: dataBaseName))
            sharedDBManager.sharedQueue = FMDatabaseQueue(path: Utility.getFilePath(fileName: dataBaseName))
            if sharedDBManager.database != nil{
                if (sharedDBManager.database?.open())!{
                    do{
                        try sharedDBManager.database?.executeUpdate(createExpenseTable, values: nil)
                        try sharedDBManager.database?.executeUpdate(createCatagoriesTable, values: nil)
                        if userDefaults.bool(forKey: ISFIRSTTIME){
                            _ = sharedDBManager.InsertIntoCatagories()
                        }
                    }catch{
                        
                        print(error.localizedDescription)
                    }
                    sharedDBManager.database?.close()
                }
            }
        }
        
        return sharedDBManager
    }

    
    func featchDataFromTheTable(){
        sharedDBManager.database?.open()
        var result:FMResultSet!
        let query = "SELECT * FROM Catagories"
        do {
            result = try (sharedDBManager.database?.executeQuery(query, values: nil))! as FMResultSet
            resultDelegate?.resultWasGenerated(result: result)
            
        }catch let error as NSError{
            print(error.localizedDescription)
        }
        sharedDBManager.database?.close()
    }
    
    func featchAllDataFromExpense(){
        sharedDBManager.database?.open()
        var result: FMResultSet!
        let query = "SELECT * FROM \(expenseTable)"
        do {
             result = try (sharedDBManager.database?.executeQuery(query, values: nil))! as FMResultSet         
            resultDelegate?.resultWasGenerated(result: result)
    
        }catch let error as NSError{
            print(error.localizedDescription)
        }
        sharedDBManager.database?.close()
    }
    
    
    func insertDataToExpense(model: Expense) -> Bool{
        sharedDBManager.database?.open()
        var result: Bool = false
        do{
            result = ((try sharedDBManager.database?.executeUpdate("INSERT INTO \(expenseTable) (title, amount, note, date, catagory) values (?, ?, ?, ?, ?)", values: [model.title as String, model.amount as Double, (model.note ?? "") as String, model.date as String, model.catagory as String])) != nil)
        }catch{
            print(error.localizedDescription)
        }
        sharedDBManager.database?.close()
        return result
    }
    
    func InsertIntoCatagories() -> Bool {
        sharedDBManager.database?.open()
        var result: Bool = false
        _ = arrCatagories.reduce(into: arrCatagories[0]) { (x, y) in
                do{
                    result = ((try sharedDBManager.database?.executeUpdate("INSERT INTO \(catagoryTable) (catagoryname) values (?)", values: [y]) != nil))
                    
                }
            catch{
                print(error.localizedDescription)
            }
        }
        sharedDBManager.database?.close()
        return result
    }
    
      func update(sqlStatement:String, values:[Any]? = nil) {
     
        sharedDBManager.sharedQueue?.inDeferredTransaction { (db, rollback) in
               do {
                if !sharedDBManager.database!.isOpen{
                    sharedDBManager.database?.open()
                }
                try sharedDBManager.database?.executeUpdate(sqlStatement, values: values)
                print("Item inserted successfully")
                sharedDBManager.database?.close()
                    } catch {
                        print("failed: \(error.localizedDescription)")
                        sharedDBManager.database?.close()
                    }
                }
           }
    
    
    func insert(values: [Any], into table:String) {
        
        /* we need to specify NULL when using VALUES for any autoincremented keys */
        
       var sqlStatement = "INSERT INTO \(table) VALUES"
        
        for (index, _) in values.enumerated() {
            sqlStatement += (index == values.count - 1) ? ", ?)" :", ?"
        }
        print(sqlStatement)
        self.update(sqlStatement: sqlStatement, values:values)
    }

}
