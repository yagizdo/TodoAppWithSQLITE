//
//  TodoDetailInteractor.swift
//  TodoAppWithSQLite
//
//  Created by Yılmaz Yağız Dokumacı on 4.02.2023.
//

import Foundation

class TodoDetailInteractor : PresenterToInteractorTodoDetailProtocol {
    // Database object
    var db:FMDatabase?
    
    init() {
        // We want to access the database as soon as it runs
        // Public path where this database is
          let destinationPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
          
        // Now we represent the original copy location and give the file a name it will copy with the name we gave
          let databaseURL = URL(fileURLWithPath: destinationPath).appendingPathComponent("todohomework.db")
          
        // we provide access to the database
          db = FMDatabase(path: databaseURL.path)
    }
    
    func updateTodo(todoID: Int, todoTitle: String, todoDescription: String) {
        db?.open()
        
        do {
            try db!.executeUpdate("UPDATE todos SET todo_title = ?, todo_description = ? WHERE todo_id = ?", values: [todoTitle,todoDescription,todoID])
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
