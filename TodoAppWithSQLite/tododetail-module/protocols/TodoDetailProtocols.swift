//
//  TodoDetailProtocols.swift
//  TodoAppWithSQLite
//
//  Created by Yılmaz Yağız Dokumacı on 4.02.2023.
//

import Foundation

protocol ViewToPresenterTodoDetailProtocol {
    var todoDetailInteractor:PresenterToInteractorTodoDetailProtocol? {get set}
    func updateTodo(todoID:Int, todoTitle:String, todoDescription:String)
}

protocol PresenterToInteractorTodoDetailProtocol {
    func updateTodo(todoID:Int, todoTitle:String, todoDescription:String)
}

// Router Protocol

protocol PresenterToRouterTodoDetailProtocol {
    static func createModule(ref:TodoDetailViewController)
}
