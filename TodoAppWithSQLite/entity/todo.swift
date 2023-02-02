//
//  todo.swift
//  TodoAppWithSQLite
//
//  Created by Yılmaz Yağız Dokumacı on 2.02.2023.
//

import Foundation

class Todo {
    var todo_id:Int?
    var todo_title:String?
    var todo_description:String?
    var category_id:Int?
    
    init(todo_id: Int, todo_title: String, todo_description: String, category_id: Int) {
        self.todo_id = todo_id
        self.todo_title = todo_title
        self.todo_description = todo_description
        self.category_id = category_id
    }
}
