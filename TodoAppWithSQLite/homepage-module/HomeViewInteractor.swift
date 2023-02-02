//
//  HomeViewInteractor.swift
//  TodoAppWithSQLite
//
//  Created by Yılmaz Yağız Dokumacı on 2.02.2023.
//

import Foundation

class HomeViewInteractor : PresenterToInteractorHomeViewProtocol {
    var presenter: InteractorToPresenterHomeViewProtocol?
    
    // Database object
    var db:FMDatabase?
    
    var categories = [Category]()
    var todos = [Todo]()
    
    init() {
        // We want to access the database as soon as it runs
        // Public path where this database is
          let destinationPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
          
        // Now we represent the original copy location and give the file a name it will copy with the name we gave
          let databaseURL = URL(fileURLWithPath: destinationPath).appendingPathComponent("todohomework.db")
          
        // we provide access to the database
          db = FMDatabase(path: databaseURL.path)
    }
    
    func getCategories() {
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM categories", values: nil)
            
            while rs.next() {
                let category_id = Int(rs.string(forColumn: "category_id"))
                let category_name = rs.string(forColumn: "category_name")
                
               
                let category = Category(category_id: category_id!, category_name: category_name!)
                
                categories.append(category)
            }
            presenter?.sendDataToPresenter(categories: categories)
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func getTodos(categoryID: Int) {
        todos.removeAll()
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM todos WHERE category_id = ?", values: [categoryID])
            
            while rs.next() {
                let todo_id = Int(rs.string(forColumn: "todo_id"))
                let todo_title = rs.string(forColumn: "todo_title")
                let todo_description = rs.string(forColumn: "todo_description")
                let category_id = Int(rs.string(forColumn: "category_id"))
                
                let todo = Todo(todo_id: todo_id!, todo_title: todo_title!, todo_description: todo_description!, category_id: category_id!)
                
                todos.append(todo)
            }
            presenter?.sendDataToPresenter(todos: todos)
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
