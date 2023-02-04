//
//  HomeViewProtocols.swift
//  TodoAppWithSQLite
//
//  Created by Yılmaz Yağız Dokumacı on 2.02.2023.
//

import Foundation


protocol ViewToPresenterHomeViewProtocol {
    var view:PresenterToViewHomeViewProtocol? {get set}
    var interactor:PresenterToInteractorHomeViewProtocol? {get set}
    
    func getCategories()
    func getTodos(categoryID:Int)
    func addCategory(categoryName:String)
    func deleteCategory(categoryID:Int)
    func deleteTodo(todoID:Int,categoryID:Int)
    func searchTodo(searchText:String)
    func getTasksCount(categoryID:Int)->Int
}

protocol PresenterToInteractorHomeViewProtocol {
    
    var presenter:InteractorToPresenterHomeViewProtocol? {get set}
    
    func getCategories()
    func getTodos(categoryID:Int)
    func addCategory(categoryName:String)
    func deleteCategory(categoryID:Int)
    func deleteTodo(todoID:Int,categoryID:Int)
    func searchTodo(searchText:String)
    func getTasksCount(categoryID:Int)->Int
}

protocol InteractorToPresenterHomeViewProtocol {
    func sendDataToPresenter(categories:[Category])
    func sendDataToPresenter(todos:[Todo])
}

protocol PresenterToViewHomeViewProtocol {
    func sendDataToView(categories:[Category])
    func sendDataToView(todos:[Todo])
}

// Router Protocol
protocol PresenterToRouterProtocol {
    static func createModule(ref:HomeViewController)
}
