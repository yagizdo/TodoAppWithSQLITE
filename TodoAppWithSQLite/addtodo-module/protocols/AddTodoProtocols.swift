//
//  AddTodoProtocols.swift
//  TodoAppWithSQLite
//
//  Created by Yılmaz Yağız Dokumacı on 3.02.2023.
//

import Foundation

protocol ViewToPresenterAddTodoProtocol {
    
    var interactor : PresenterToInteractorAddTodoProtocol? {get set}
    var view : PresenterToViewAddTodoProtocol? {get set}
    
    func addTodo(todoTitle:String,todoDescription:String,categoryID:Int)
    func getCategories()
}

protocol PresenterToInteractorAddTodoProtocol {
    var presenter:InteractorToPresenterAddTodoProtocol? {get set}
    
    func addTodo(todoTitle:String,todoDescription:String,categoryID:Int)
    func getCategories()
}

protocol InteractorToPresenterAddTodoProtocol {
    func sendDataToPresenter(categories:[Category])
}

protocol PresenterToViewAddTodoProtocol {
    func sendDataToView(categories:[Category])
}


// Router Protocol
protocol PresenterToRouterAddTodoProtocol {
    static func createModule(ref:AddTodoViewController)
}
