//
//  AddTodoInteractor.swift
//  TodoAppWithSQLite
//
//  Created by Yılmaz Yağız Dokumacı on 3.02.2023.
//

import Foundation

class AddTodoInteractor : PresenterToInteractorAddTodoProtocol {
    
    var presenter: InteractorToPresenterAddTodoProtocol?
    
    // Database object
    var db:FMDatabase?
    
    var categories = [Category]()
    
    init() {
        // We want to access the database as soon as it runs
        // Public path where this database is
          let destinationPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
          
        // Now we represent the original copy location and give the file a name it will copy with the name we gave
          let databaseURL = URL(fileURLWithPath: destinationPath).appendingPathComponent("todohomework.db")
          
        // we provide access to the database
          db = FMDatabase(path: databaseURL.path)
    }
    
    func addTodo(todo: Todo) {
        db?.open()
        
        do {
            try db!.executeUpdate("INSERT INTO todos (todo_title,todo_description,category_id) VALUES (?,?,?)", values: [todo.todo_title!,todo.todo_description ?? "",todo.category_id!])
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func getCategories() {
        db?.open()
        
        do {
            categories.removeAll()
            let rs = try db!.executeQuery("SELECT * FROM categories", values: nil)
            
            while rs.next() {
                let category_id = Int(rs.string(forColumn: "category_id"))
                let category_name = rs.string(forColumn: "category_name")
                
               
                let category = Category(category_id: category_id!, category_name: category_name!)
                
                categories.append(category)
            }
            presenter?.sendDataToPresenter(categories: categories.reversed())
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
