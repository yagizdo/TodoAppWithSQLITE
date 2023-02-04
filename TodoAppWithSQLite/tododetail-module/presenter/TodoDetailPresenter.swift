//
//  TodoDetailPresenter.swift
//  TodoAppWithSQLite
//
//  Created by Yılmaz Yağız Dokumacı on 4.02.2023.
//

import Foundation

class TodoDetailPresenter : ViewToPresenterTodoDetailProtocol {
    var todoDetailInteractor: PresenterToInteractorTodoDetailProtocol?
    
    func updateTodo(todoID: Int, todoTitle: String, todoDescription: String) {
        todoDetailInteractor?.updateTodo(todoID: todoID, todoTitle: todoTitle, todoDescription: todoDescription)
    }
}
