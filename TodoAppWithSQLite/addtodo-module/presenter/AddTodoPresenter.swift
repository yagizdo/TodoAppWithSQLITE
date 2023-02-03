//
//  AddTodoPresenter.swift
//  TodoAppWithSQLite
//
//  Created by Yılmaz Yağız Dokumacı on 3.02.2023.
//

import Foundation

class AddTodoPresenter : ViewToPresenterAddTodoProtocol {
    
    var interactor: PresenterToInteractorAddTodoProtocol?
    var view: PresenterToViewAddTodoProtocol?
    
    func addTodo(todoTitle:String,todoDescription:String,categoryID:Int) {
        interactor?.addTodo(todoTitle:todoTitle,todoDescription:todoDescription,categoryID:categoryID)
    }
    func getCategories() {
        interactor?.getCategories()
    }
}

extension AddTodoPresenter : InteractorToPresenterAddTodoProtocol {
    func sendDataToPresenter(categories: [Category]) {
        view?.sendDataToView(categories: categories)
    }
}
