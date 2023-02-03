//
//  AddTodoRouter.swift
//  TodoAppWithSQLite
//
//  Created by Yılmaz Yağız Dokumacı on 3.02.2023.
//

import Foundation

class AddTodoRouter : PresenterToRouterAddTodoProtocol {
   static func createModule(ref: AddTodoViewController) {
        
        let presenter = AddTodoPresenter()
        
        // View
        ref.addTodoPresentDelegate = presenter
        
        // Presenter
        ref.addTodoPresentDelegate?.view = ref
        ref.addTodoPresentDelegate?.interactor = AddTodoInteractor()
        
        // Interactor
        ref.addTodoPresentDelegate?.interactor?.presenter = presenter
    }
}
